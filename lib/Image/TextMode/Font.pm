package Image::TextMode::Font;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( width         => 0 );
__PACKAGE__->mk_classaccessor( height        => 0 );
__PACKAGE__->mk_classaccessor( chars         => [] );
__PACKAGE__->mk_classaccessor( intensity_map => [] );

=head1 NAME

Image::TextMode::Font - A base class for text mode fonts

=head1 SYNOPSIS

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
        {   width         => 8,
            height        => $height,
            chars         => \@chars,
            intensity_map => []
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
    return
        pack( 'C*', join( '', map { join( '', @$_ ) } @{ $self->chars } ) );
}

=head2 as_gd( )

Returns the object as a C<GD::Font>.

=cut

sub as_gd {
    my $self = shift;
    require GD;
    require File::Temp;

    my $temp = File::Temp->new;

    binmode( $temp );

    print $temp
        pack( 'VVVV', $self->characters, 0, $self->width, $self->height );
    for my $char ( @{ $self->chars } ) {
        print $temp pack( 'C*', split( //, sprintf( '%08b', $_ ) ) )
            for @$char;
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
