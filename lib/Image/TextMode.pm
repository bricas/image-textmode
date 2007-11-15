package Image::TextMode;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

use Image::TextMode::Pixel;
use File::SAUCE;
use IO::File;
use IO::String;

__PACKAGE__->mk_classaccessors(
    qw( width height _image sauce font palette ) );
__PACKAGE__->mk_classaccessor( font_class => 'Image::TextMode::Font::8x16' );
__PACKAGE__->mk_classaccessor(
    palette_class => 'Image::TextMode::Palette::VGA' );

sub new {
    my $class = shift;
    my $args  = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };
    my $self  = bless $args, $class;
    $self->clear;
    return $self;
}

sub clear {
    my $self = shift;
    $self->clear_screen;
    $self->sauce( File::SAUCE->new );

    for ( qw( font palette ) ) {
        my $method = "${_}_class";
        my $class  = $self->$method;
        eval "use $class";
        die $@ if $@;
        $self->$_( $class->new );
    }
}

sub clear_screen {
    my $self = shift;
    $self->$_( undef ) for qw( width height );
    $self->_image( [] );
}

sub read {
    my ( $self, $options ) = ( shift, shift );
    my $file =  $self->_create_io_object( $options );
    $self->clear;

    # attempt to find a sauce record in the file
    $self->sauce->read( handle => $file );

    return $self->parse( $file, @_ );
}

sub write {
    my ( $self, $options ) = ( shift, shift );
    my $file = $self->_create_io_object( $options, '>' );

    $file->print( $self->as_string( @_ ) );
}

sub getpixel {
    my ( $self, $x, $y ) = @_;

    if (    exists $self->_image->[ $y ]
        and exists $self->_image->[ $y ]->[ $x ] )
    {
        my $data = $self->_image->[ $y ]->[ $x ];
        return wantarray
            ? @$data
            : Image::TextMode::Pixel->new(
            { char => $data->[ 0 ], attr => $data->[ 1 ] } );
    }

    return;
}

sub putpixel {
    my ( $self, $x, $y, $pixel, $attr ) = @_;
    my $char = $pixel;

    if ( ref $pixel ) {
        $char = $pixel->char;
        $attr = $pixel->attr;
    }

    $self->_image->[ $y ]->[ $x ] = [ $char, $attr ];
}

sub clear_line {
    my $self = shift;
    my $y    = shift;

    my $line = $self->_image->[ $y ];

    $self->_image->[ $y ] = [] if defined $line;
}

sub as_ascii {
    my ( $self ) = @_;

    my $output = '';
    for my $row ( @{ $self->_image } ) {
        $output
            .= join( '', map { defined $_->[ 0 ] ? $_->[ 0 ] : ' ' } @$row )
            . "\n";
    }

    return $output;
}

sub _create_io_object {
    my ( $self, $options, $perms ) = @_;

    if ( !ref $options ) {
        $options = { file => $options };
    }

    $perms = '<' unless $perms;

    my $file;

    # use appropriate IO object for what we get in
    if ( exists $options->{ file } ) {
        $file = IO::File->new( $options->{ file }, $perms ) || die "$!";
    }
    elsif ( exists $options->{ string } ) {
        $file = IO::String->new( $options->{ string }, $perms );
    }
    elsif ( exists $options->{ handle } ) {
        $file = $options->{ handle };
    }
    else {
        die
            "No valid read type. Must be one of 'file', 'string' or 'handle'.";
    }

    binmode( $file );
    return $file;
}

sub has_sauce {
    return shift->sauce->has_sauce;
}

sub calculate_and_set_dimensions {
    my $self = shift;
    my $image = $self->_image;
    $self->height( scalar @$image );
    my $max_x = 0;
    for( @$image ) {
        my $x = scalar @$_;
        $max_x = $x if $x > $max_x;
    }
    $self->width( $max_x );
}

sub parse {
    die 'Abstract method!';
}

sub as_string {
    die 'Abstract method!';
}

1;
