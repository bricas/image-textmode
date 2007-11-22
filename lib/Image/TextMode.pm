package Image::TextMode;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

use Image::TextMode::Pixel;
use Image::TextMode::Palette::VGA;
use Image::TextMode::Font::8x16;
use File::SAUCE;
use IO::File;
use IO::String;

__PACKAGE__->mk_classaccessors(
    qw( width height _image sauce font palette blink_mode ) );

our $VERSION = '0.01';

=head1 NAME

Image::TextMode - A base class for text mode graphics

=head1 SYNOPSIS

    package MyFormat;
    
    use base qw( Image::TextMode );

    sub parse { ... }

    sub as_string { ... }

    1;

=head1 DESCRIPTION

=head1 METHODS

=head2 new( \%opts )

=cut

sub new {
    my $class = shift;
    my $args  = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };
    my $self  = bless $args, $class;
    $self->clear;
    return $self;
}

=head2 clear( )

=cut

sub clear {
    my $self = shift;
    $self->clear_screen;
    $self->sauce( File::SAUCE->new );
    $self->blink_mode( 0 );
    $self->font( Image::TextMode::Font::8x16->new );
    $self->palette( Image::TextMode::Palette::VGA->new );
}

=head2 clear_screen( )

=cut

sub clear_screen {
    my $self = shift;
    $self->$_( undef ) for qw( width height );
    $self->_image( [] );
}

=head2 read( \%opts )

=cut

sub read {
    my ( $self, $options ) = ( shift, shift );
    my $file = $self->_create_io_object( $options );
    $self->clear;

    # attempt to find a sauce record in the file
    $self->sauce->read( handle => $file );

    return $self->parse( $file, @_ );
}

=head2 write( \%opts )

=cut

sub write {
    my ( $self, $options ) = ( shift, shift );
    my $file = $self->_create_io_object( $options, '>' );

    $file->print( $self->as_string( @_ ) );
}

=head2 getpixel( $x, $y )

=cut

sub getpixel {
    my ( $self, $x, $y ) = @_;

    if (    exists $self->_image->[ $y ]
        and exists $self->_image->[ $y ]->[ $x ] )
    {
        my $data = $self->_image->[ $y ]->[ $x ];
        return wantarray
            ? @$data
            : Image::TextMode::Pixel->new(
            {   char       => $data->[ 0 ],
                attr       => $data->[ 1 ],
                blink_mode => $self->blink_mode
            }
            );
    }

    return;
}

=head2 new( $x, $y, ( $char, $attr || $pixel ) )

=cut

sub putpixel {
    my ( $self, $x, $y, $pixel, $attr ) = @_;
    my $char = $pixel;

    if ( ref $pixel ) {
        $char = $pixel->char;
        $attr = $pixel->attr;
    }

    $self->_image->[ $y ]->[ $x ] = [ $char, $attr ];
}

=head2 clear_line( $line )

=cut

sub clear_line {
    my $self = shift;
    my $y    = shift;

    my $line = $self->_image->[ $y ];

    $self->_image->[ $y ] = [] if defined $line;
}

=head2 as_ascii( )

=cut

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

=head2 has_sauce( )

=cut

sub has_sauce {
    return shift->sauce->has_sauce;
}

=head2 calculate_and_set_dimensions( )

=cut

sub calculate_and_set_dimensions {
    my $self = shift;
    my ( $width, $height ) = $self->calculate_dimensions;
    $self->width( $width );
    $self->height( $height );
}

=head2 calculate_dimensions( )

=cut

sub calculate_dimensions {
    my $self   = shift;
    my $image  = $self->_image;
    my $height = scalar @$image;
    my $max_x  = 0;
    for ( @$image ) {
        my $x = $_ ? scalar @$_ : 0;
        $max_x = $x if $x > $max_x;
    }
    return $max_x, $height;
}

=head2 dimensions( )

=cut

sub dimensions {
    my $self = shift;
    return $self->width, $self->height;
}

=head2 as_bitmap_full( %options )

=cut

## TODO: custom gd-font

sub as_bitmap_full {
    my ( $self, %options ) = @_;

    my $font     = $self->font->as_gd;
    my $ftheight = $font->height;
    my $ftwidth  = $font->width;

    my ( $width, $height )
        = $self->width ? $self->dimensions : $self->calculate_dimensions;
    $height = $options{ crop } if $options{ crop };

    require GD;
    my $image = GD::Image->new( $width * $ftwidth, $height * $ftheight );
    my $colors = $self->palette->fill_gd_palette( $image );

    for my $y ( 0 .. $height - 1 ) {
        for my $x ( 0 .. $width - 1 ) {
            my $pixel = $self->getpixel( $x, $y );

            next unless $pixel;

            if ( $pixel->bg ) {
                $image->filledRectangle(
                    $x * $ftwidth,
                    $y * $ftheight,
                    ( $x + 1 ) * $ftwidth,
                    ( $y + 1 ) * $ftheight - 1,
                    $colors->[ $pixel->bg ]
                );
            }

            $image->string(
                $font,
                $x * $ftwidth,
                $y * $ftheight,
                $pixel->char, $colors->[ $pixel->fg ]
            );
        }
    }

    my $output = $options{ format } || 'png';

    return $image->$output;
}

=head2 as_bitmap_full( %options )

=cut

sub as_bitmap_thumbnail {
    my ( $self, %options ) = @_;

    my $font     = $self->font;
    my $ftheight = int( $font->height / 8 + 0.5 );

    my ( $width, $height )
        = $self->width ? $self->dimensions : $self->calculate_dimensions;
    $height = $options{ crop } if $options{ crop };

    require GD;
    my $image     = GD::Image->new( $width, $height * $ftheight, 1 );
    my $intensity = $font->intensity_map;
    my $colors    = $self->palette->fill_gd_palette_8step( $image );

    for my $y ( 0 .. $height - 1 ) {
        for my $x ( 0 .. $width - 1 ) {
            my $pixel = $self->getpixel( $x, $y );
            next unless $pixel;

            my $offset  = $pixel->fg * 8 + $pixel->bg;
            my $charint = $intensity->[ ord( $pixel->char ) ];
            unless ( $ftheight == 1 ) {
                $image->setPixel(
                    $x,
                    $y * $ftheight + 1,
                    $colors->[ $offset ]->[ $charint & 15 ]
                );
            }
            $image->setPixel(
                $x,
                $y * $ftheight,
                $colors->[ $offset ]->[ $charint >> 4 ]
            );
        }
    }

    my $output = $options{ format } || 'png';

    return $image->$output unless $options{ zoom } > 1;

    my ( $iwidth, $iheight ) = $image->getBounds;

    my $scalex = $iwidth * $options{ zoom };
    my $scaley = $iheight * $options{ zoom };

    my $image2 = GD::Image->new( $scalex, $scaley );
    $image2->copyResized( $image, 0, 0, 0, 0, $scalex, $scaley, $iwidth,
        $iheight );

    return $image2->$output;
}

=head1 ABSTRACT METHODS

=head2 parse( )

=cut

sub parse {
    die 'Abstract method!';
}

=head2 as_string( )

=cut

sub as_string {
    die 'Abstract method!';
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
