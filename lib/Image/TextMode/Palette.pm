package Image::TextMode::Palette;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( colors => [] );

=head1 NAME

Image::TextMode::Palette - A base class for text mode palettes

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ACCESSORS

=over 4

=item * colors - An array of R, G, B, triples

=back

=head1 METHODS

=head2 new( \%opts )

=cut

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $self = bless $options, $class;

    return $self;
}

=head2 new_from_raw_data( $data )

=cut

sub new_from_raw_data {
    my ( $class, $data ) = @_;

    my @values = unpack( 'C*', $data );
    my @palette;

    for my $i ( 0 .. @values / 3 - 1 ) {
        my $offset = $i * 3;
        $palette[ $i ] = [
            $values[ $offset ] * 4,
            $values[ $offset + 1 ] * 4,
            $values[ $offset + 2 ] * 4,
        ];
    }

    return $class->new( { colors => \@palette } );
}

=head2 colours( )

=cut

sub colours {
    return shift->colors( @_ );
}

=head2 get( $index )

=cut

sub get {
    my $self  = shift;
    my $index = shift;

    return $self->colors->[ $index ];
}

=head2 set( $index, \@rgb )

=cut

sub set {
    my $self = shift;
    my ( $index, $rgb ) = @_;

    $self->colors->[ $index ] = $rgb;
}

=head2 clear( )

=cut

sub clear {
    my $self = shift;

    $self->colors( [] );
}

=head2 as_string( )

=cut

sub as_string {
    my $self = shift;
    return
        pack( 'C*', join( '', map { join( '', @$_ ) } @{ $self->colors } ) );
}

=head2 fill_gd_palette( $image )

=cut

sub fill_gd_palette {
    my ( $self, $image ) = @_;

    my @allocations = map { $image->colorAllocate( @$_ ) } @{ $self->colors };
    return \@allocations;
}

=head2 fill_gd_palette_8step( $image )

=cut

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

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
