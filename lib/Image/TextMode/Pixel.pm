package Image::TextMode::Pixel;

use base qw( Class::Data::Accessor );

use strict;
use warnings;

# Attribute byte constants
use constant ATTR_BLINK => 128;
use constant ATTR_BG    => 112;
use constant ATTR_FG    => 15;

__PACKAGE__->mk_classaccessors( qw( char fg bg blink ) );

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $attr = delete $options->{ attr };
    my $self = bless $options, $class;

    $self->attr( $attr ) if defined $attr;

    return $self;
}

sub attr {
    my $self = shift;
    my $attr = $_[ 0 ];

    if ( @_ ) {
        $self->fg( $attr & ATTR_FG );
        $self->bg(    ( $attr & ATTR_BG ) >> 4 );
        $self->blink( ( $attr & ATTR_BLINK ) >> 7 );
    }
    else {
        $attr = 0;
        $attr |= $self->fg;
        $attr |= ( $self->bg << 4 );
        $attr |= ( $self->blink << 7 );
    }

    return $attr;
}

1;
