package Image::TextMode::IDF::Parser;

=head1 NAME

Image::XBin::Parser - Reads in XBin image files

=head1 SYNOPSIS

	my $parser = Image::XBin::Parser->new;
	my $xbin   = $parser->parse( file => 'xbin.xb' );

=cut

use strict;
use warnings;

use Carp;

our $VERSION = '0.01';

=head1 METHODS

=head2 clear( )

Clears the internal xbin object.

=cut

sub reset {
    my $self = shift;
}

=head2 parse( %options )

Reads in a file, handle or string

	my $parser = Image::XBin::Parser->new;

	# filename
	$xbin = $parser->parse( file => 'file.xb' );
	
	# file handle
	$xbin = $parser->parse( handle => $handle );

	# string
	$xbin = $parser->parse( string => $string );

=cut

sub parse {
    my $self = shift;
    my ( $idf, $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $buffer;
    $file->read( $buffer, 4 );
    $idf->id( unpack('A4', $buffer ) );

    $file->read( $buffer, 8 );
    my @dim = unpack('v*', $buffer );

    $idf->x0( $dim[ 0 ] );
    $idf->y0( $dim[ 1 ] );
    $idf->x1( $dim[ 2 ] );
    $idf->y1( $dim[ 3 ] );

    $file->seek( -48 - 4096, 2 );
    if( $idf->has_sauce ) {
        $file->seek( -128, 1 );
    }

    my $max = $file->tell;

    $file->read( $buffer, 4096 );
    $idf->font(
        Image::TextMode::Font->new_from_raw_data( $buffer, 16 )
    );

    $file->read( $buffer, 48 );
    $idf->palette(
        Image::TextMode::Palette->new_from_raw_data( $buffer ) );

    $file->seek( 12, 0 );
    my ( $x, $y ) = ( 0, 0 );
    while ( $file->tell < $max ) {
        $file->read( $buffer, 2 );
        my $info = unpack( 'v', $buffer );

        my $len;
        if( $info == 1 ) {
            $file->read( $info, 2 );
            $len = unpack( 'v', $info ) & 255 ;
            $file->read( $buffer, 2 );
        }
        else {
            $len = 1;
        }

        my @data = unpack( 'aC', $buffer );            
        for( 1..$len ) {
            $idf->putpixel( $x, $y, @data );
            $x++;
            if ( $x > $dim[ 2 ] ) {
                $x = 0;
                $y++;
            }
        }
    }

    return $idf;
}

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
