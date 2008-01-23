package Image::TextMode::Font;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( width  => 0 );
__PACKAGE__->mk_classaccessor( height => 0 );
__PACKAGE__->mk_classaccessor( chars  => [] );
__PACKAGE__->mk_classaccessor(
    intensity_map => [
        0,  50, 83, 49,  16, 33,  32, 0,   136, 0,  119, 18,
        32, 18, 35, 33,  99, 16,  16, 33,  48,  66, 4,   17,
        16, 0,  16, 16,  33, 16,  18, 48,  0,   16, 16,  34,
        50, 17, 34, 0,   0,  0,   16, 0,   0,   16, 0,   1,
        67, 16, 19, 17,  32, 65,  66, 32,  66,  48, 0,   0,
        0,  17, 0,  32,  51, 51,  50, 50,  50,  50, 50,  50,
        83, 0,  2,  50,  34, 83,  83, 50,  50,  67, 50,  34,
        16, 66, 65, 66,  34, 32,  35, 16,  32,  0,  16,  1,
        0,  18, 50, 34,  18, 34,  34, 36,  50,  0,  1,   50,
        0,  35, 17, 34,  19, 35,  18, 17,  16,  34, 17,  35,
        17, 36, 18, 0,   0,  0,   16, 18,  50,  66, 34,  18,
        34, 18, 18, 16,  50, 50,  50, 16,  16,  16, 51,  51,
        50, 18, 67, 34,  50, 34,  66, 50,  67,  50, 66,  32,
        50, 16, 99, 17,  18, 0,   34, 50,  49,  99, 16,  16,
        18, 18, 16, 66,  66, 0,   16, 17,  17,  68, 85,  0,
        16, 32, 33, 17,  32, 49,  17, 33,  48,  32, 32,  16,
        0,  16, 16, 0,   16, 16,  0,  17,  16,  1,  48,  33,
        17, 32, 49, 32,  32, 32,  17, 16,  0,   0,  1,   33,
        32, 16, 0,  136, 24, 119, 0,  112, 35,  37, 83,  33,
        34, 35, 18, 16,  17, 50,  50, 17,  33,  34, 17,  51,
        33, 1,  0,  0,   0,  3,   0,  17,  16,  0,  0,   17,
        48, 48, 33, 0
    ]
);

=head1 NAME

Image::TextMode::Font - A base class for text mode fonts

=head1 DESCRIPTION

Represents a font in text mode. That is, an array of characters represented
by an array of byte scanlines.

=head1 ACCESSORS

=over 4

=item * width - The width of the font

=item * height - The height of the font

=item * chars - An array of array of scanline data

=item * itensity_map - an array of integers for color intensities in thumbnails

=back

=head1 METHODS

=head2 new( \%opts )

Creates a new font object.

=cut

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $self = bless $options, $class;

    return $self;
}

=head2 new_from_raw_data( $data, $height )

Reads basic raw data and parses out the scanlines for character of a 
given C<$height>.

=cut

sub new_from_raw_data {
    my ( $class, $data, $height ) = @_;
    my @chars;

    for ( 0 .. ( length( $data ) / $height ) - 1 ) {
        push @chars,
            [ unpack( 'C*', substr( $data, $_ * $height, $height ) ) ];
    }

    return $class->new(
        {   width  => 8,
            height => $height,
            chars  => \@chars,
        }
    );
}

=head2 get( $index )

Get the character at C<$index>.

=cut

sub get {
    my $self  = shift;
    my $index = shift;

    return $self->chars->[ $index ];
}

=head2 set( $index, \@lines )

Set the character data at C<$index>.

=cut

sub set {
    my $self = shift;
    my ( $index, $lines ) = @_;

    $self->chars->[ $index ] = $lines;
}

=head2 clear( )

Clears all char data.

=cut

sub clear {
    my $self = shift;

    $self->chars( [] );
    $self->width( 0 );
    $self->height( 0 );
}

=head2 characters( )

Returns the number of characters in the font.

=cut

sub characters {
    my $self = shift;
    return scalar @{ $self->chars };
}

=head2 as_string( )

Packs the data into a raw string.

=cut

sub as_string {
    my $self = shift;
    return pack( 'C*', map { @$_ } @{ $self->chars } );
}

=head2 as_gd( \%options )

Returns the object as a C<GD::Font>. Options include:

=over 4

=item * 9th_bit - adds another bit to each character for 720px mode

=back

=cut

sub as_gd {
    my $self = shift;
    my $options = shift || {};
    require GD;
    require File::Temp;

    my $temp = File::Temp->new;

    binmode( $temp );

    my $ninth = $options->{ '9th_bit' };
    print $temp pack( 'VVVV',
        $self->characters, 0, $self->width + ( $ninth ? 1 : 0 ),
        $self->height );
    for my $charval ( 0 .. $self->characters - 1 ) {
        my $char = $self->chars->[ $charval ];
        for ( @$char ) {
            my @binary = split( //, sprintf( '%08b', $_ ) );

            if ( $ninth ) {
                push @binary,
                    (       $charval >= 0xc0
                        and $charval <= 0xdf ? $binary[ -1 ] : 0 );
            }

            print $temp pack( 'C*', @binary );
        }
    }
    close $temp;

    return GD::Font->load( $temp->filename );
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
