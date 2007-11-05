package Image::TextMode::Palette;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( colors => [] );

sub get {
    my $self  = shift;
    my $index = shift;

    return $self->colors->[ $index ];
}

sub set {
    my $self = shift;
    my ( $index, $rgb ) = @_;

    $self->colors->[ $index ] = $rgb;
}

sub clear {
    my $self = shift;

    $self->colors( [] );
}

sub fill_gd_palette {
    my $self  = shift;
    my $image = shift;

    my @allocations = map { $image->colorAllocate( @$_ ) } @{ $self->colors };

    return \@allocations;
}

1;
