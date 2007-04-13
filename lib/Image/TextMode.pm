package Image::TextMode;

use strict;
use warnings;

use base qw( Class::Accessor::Fast );

use Image::TextMode::Pixel;

__PACKAGE__->mk_accessors( qw( width height _image ) );

sub clear {
    my $self = shift;
    $self->$_( undef ) for qw( width height );
    $self->_image( [] );
}

sub getrawdata {
}

sub getpixel {
}

sub putpixel {
    my( $self, $x, $y, $pixel, $attr ) = @_;
    my $char = $pixel;
    
    if( ref $pixel ) {
        $char = $pixel->char;
        $attr = $pixel->attr;
    }

#    push @{ $self->_image }, $char, $attr;
}

1;
