package Image::TextMode::Palette;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( colors => [] );

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $self = bless $options, $class;

    return $self;
}

sub new_from_raw_data {
    my( $class, $data ) = @_;

	my @values = unpack( 'C*', $data );
	my @palette;

	for my $i ( 0..15 ) {
		$palette[ $i ] = [
            $values[ $i * 3 ] / 63 * 255,
            $values[ $i * 3 + 1 ] / 63 * 255,
            $values[ $i * 3 + 2 ] / 63 * 255,
        ];
	}

    return $class->new( { colors => \@palette } );
}

sub colours {
    return shift->colors( @_ );
}

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
    my ( $self, $image ) = @_;

    my @allocations = map { $image->colorAllocate( @$_ ) } @{ $self->colors };
    return \@allocations;
}

sub fill_gd_palette_8step {
    my ( $self, $image ) = @_;
    my @colors;

    for my $bg ( 0 .. 7 ) {
        my $pal_bg = $self->get( $bg );
        for my $fg ( 0 .. 15 ) {
            my $pal_fg = $self->get( $fg );
            for my $z ( 0 .. 8 ) {
                $colors[ $fg * 8 + $bg ]->[ 8 - $z ] = $image->colorAllocate(
                    $z / 8 * ( $pal_bg->[ 0 ] )
                        + ( 8 - $z ) / 8 * ( $pal_fg->[ 0 ] ),
                    $z / 8 * ( $pal_bg->[ 1 ] )
                        + ( 8 - $z ) / 8 * ( $pal_fg->[ 1 ] ),
                    $z / 8 * ( $pal_bg->[ 2 ] )
                        + ( 8 - $z ) / 8 * ( $pal_fg->[ 2 ] ),
                );
            }
        }
    }

    return \@colors;
}

1;
