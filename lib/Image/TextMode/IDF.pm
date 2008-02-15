package Image::TextMode::IDF;

=head1 NAME

Image::TextMode::IDF - Load, create, manipulate and save IDF image files

=head1 SYNOPSIS

	use Image::TextMode::IDF;

	# Read in a file...
	my $img = Image::TextMode::IDF->read( { file => 'my.idf' } );

	# save the data to a file
	$img->write( { file => 'mynew.idf' } );

=head1 DESCRIPTION

XBin stands for "eXtended BIN" -- an extention to the normal raw-image BIN files.

XBin features:

=over 4 

=item * allows for binary images up to 65536 columns wide, and 65536 lines high

=item * can have an alternate set of palette colors either in blink or in non-blink mode

=item * can have different textmode fonts from 1 to 32 scanlines high, consisting of either 256 or 512 different characters

=item * can be compressed

=back

XBin file stucture:

	+------------+
	| Header     |
	+------------+
	| Palette    |
	+------------+
	| Font       |
	+------------+
	| Image Data |
	+------------+

Note, the only required element is a header. See the XBin specs for for information.
http://www.acid.org/info/xbin/xbin.htm

=cut

use base qw( Image::TextMode::Base );

use strict;
use warnings;

use Carp;
use Image::TextMode::IDF::Parser;

our $VERSION = '0.01';

__PACKAGE__->mk_classaccessors( qw( id x0 y0 x1 y1 ) );

=head1 METHODS

=head2 clear(  )

Clears any in-memory data.

=cut

sub clear {
    my $self = shift;

    $self->id( undef );
    $self->x0( undef );
    $self->y0( undef );
    $self->x1( undef );
    $self->y1( undef );

    $self->SUPER::clear( @_ );
}

=head2 read( %options )

Explicitly reads in an IDF.

=cut

sub parse {
    my $self = shift;
    my ( $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $buffer;
    $file->read( $buffer, 4 );
    $self->id( unpack('A4', $buffer ) );

    $file->read( $buffer, 8 );
    my @dim = unpack('v*', $buffer );

    $self->x0( $dim[ 0 ] );
    $self->y0( $dim[ 1 ] );
    $self->x1( $dim[ 2 ] );
    $self->y1( $dim[ 3 ] );

    $file->seek( -48 - 4096, 2 );
    if( $self->has_sauce ) {
        $file->seek( -128, 1 );
    }

    my $max = $file->tell;

    $file->read( $buffer, 4096 );
    $self->font(
        Image::TextMode::Font->new_from_raw_data( $buffer, 16 )
    );

    $file->read( $buffer, 48 );
    $self->palette(
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
            $self->putpixel( $x, $y, @data );
            $x++;
            if ( $x > $dim[ 2 ] ) {
                $x = 0;
                $y++;
            }
        }
    }

    return $self;
}

=head2 as_string( )

Returns the IDF data as a string - suitable for saving.

=cut
sub as_string {
    my $self = shift;

    my $output;
    $output .= pack( 'A4', $self->id );
    $output .= pack( 'v*', map { $self->$_ } qw( x0 y0 x1 y1 ) );

###

    if ( $self->sauce ) {
        $output .= $self->sauce->as_string;
    }

    return $output;
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
