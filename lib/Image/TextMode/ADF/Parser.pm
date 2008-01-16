package Image::TextMode::ADF::Parser;

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

my @color_idx = (0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63 );

sub parse {
    my $self = shift;
    my ( $adf, $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $version;
    $file->read( $version, 1 );
    $version = unpack('C', $version);
    $adf->version( $version );

    my $paldata;
    $file->read( $paldata, 192 );

    my @pal = unpack( 'C*', $paldata );
    my @colors;
    for( @color_idx ) {
        my $offset = $_ * 3;
        push @colors, [ map { $_ << 2  } @pal[ $offset..$offset+2 ] ],
    }

    $adf->palette(
        Image::TextMode::Palette->new( { colors => \@colors } ) );

    my $fontdata;
    $file->read( $fontdata, 4096 );

    $adf->font(
        Image::TextMode::Font->new_from_raw_data( $fontdata, 16 )
    );

    my ( $x, $y ) = ( 0, 0 );
    my $chardata;
    while ( $file->read( $chardata, 2 ) ) {
        my @data = unpack( 'aC', $chardata );
        last if $data[ 0 ] eq chr( 26 );
        $adf->putpixel( $x, $y, @data );

        $x++;
        if ( $x == 80 ) {
            $x = 0;
            $y++;
        }
    }

    return $adf;
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
