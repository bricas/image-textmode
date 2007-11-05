package Image::TextMode;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

use Image::TextMode::Pixel;
use File::SAUCE;

__PACKAGE__->mk_classaccessors( qw( width height _image sauce ) );

sub new {
    my $class = shift;
    my $args  = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };
    my $self  = bless $args, $class;
    $self->clear;
    return $self;
}

sub clear {
    my $self = shift;
    $self->$_( undef ) for qw( width height );
    $self->_image( [] );
    $self->sauce( File::SAUCE->new );
}

sub getpixel {
    my ( $self, $x, $y ) = @_;

    if (    exists $self->_image->[ $y ]
        and exists $self->_image->[ $y ]->[ $x ] )
    {
        my $data = $self->_image->[ $y ]->[ $x ];
        return
            wantarray
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

sub as_ascii {
    my ( $self ) = @_;

    my $output = '';
    for my $row ( @{ $self->_image } ) {
        $output .= join( '', map { $_->[ 0 ] || ' ' } @$row ) . "\n";
    }

    return $output;
}

1;
