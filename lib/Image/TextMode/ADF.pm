package Image::ADF;

=head1 NAME

Image::ADF - Load, create, manipulate and save ADF image files

=head1 SYNOPSIS

	use Image::ADF;

	# Read in a file...
	my $img = Image::ADF->new( file => 'myADF.xb' );

	# Image width and height
	my $w = $img->width;
	my $h = $img->height;

	# get and put "pixels"
	my $pixel = $img->getpixel( $x, $y );
	$img->putpixel( $x, $y, $pixel );

	# font (ADF::Font)
	my $font = $img->font;

	# palette (ADF::Palette)
	my $palette = $img->palette;

	# save the data to a file
	$img->write( file => 'x.xb' );

=head1 DESCRIPTION

ADF stands for "eXtended BIN" -- an extention to the normal raw-image BIN files.

ADF features:

=over 4 

=item * allows for binary images up to 65536 columns wide, and 65536 lines high

=item * can have an alternate set of palette colors either in blink or in non-blink mode

=item * can have different textmode fonts from 1 to 32 scanlines high, consisting of either 256 or 512 different characters

=item * can be compressed

=back

ADF file stucture:

	+------------+
	| Header     |
	+------------+
	| Palette    |
	+------------+
	| Font       |
	+------------+
	| Image Data |
	+------------+

Note, the only required element is a header. See the ADF specs for for information.
http://www.acid.org/info/xbin/xbin.htm

=head1 INSTALLATION

	perl Makefile.PL
	make
	make test
	make install

=cut

use base qw( Image::TextMode );

use strict;
use warnings;

use Carp;
use Image::ADF::Parser;

our $VERSION = '0.01';

__PACKAGE__->mk_classaccessors( 'version' );

=head1 METHODS

=head2 new( %options )

Creates a new ADF image. Currently only reads in data.

	# filename
	$ADF = Image::ADF->new( file => 'file.xb' );
	
	# file handle
	$ADF = Image::ADF->new( handle => $handle );

	# string
	$ADF = Image::ADF->new( string => $string );

=cut

sub new {
    my $class = shift;
    my $args  = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };
    my $self  = bless $args, $class;
    $self->clear;
    return $self;
}

=head2 clear(  )

Clears any in-memory data.

=cut

sub clear {
    my $self = shift;

    $self->version( undef );

    $self->SUPER::clear( @_ );
}

=head2 read( %options )

Explicitly reads in an ADF.

=cut

sub parse {
    my $self = shift;

    require Image::ADF::Parser;
    Image::ADF::Parser->parse( $self, @_ );

    return $self;
}

=head2 as_string( )

Returns the ADF data as a string - suitable for saving.

=cut
sub as_string {

=pod

    my $self = shift;

    my $output;

# must set header to uncompressed because we don't have a compression alg yet.
# set old value back when done.
# this is temporary!!!
    my $compressed = $self->is_compressed;
    $self->compress( 0 );

    # header
    $output .= pack( $header_template, map { $self->$_ } @header_fields );

    # palette
    if ( $self->has_palette ) {
        $output .= $self->palette->as_string;
    }

    # font
    if ( $self->has_font ) {
        $output .= $self->font->as_string;
    }

    # image
    if ( $self->is_compressed ) {

        # RLE compression alg.
    }
    else {
        for my $y ( 0 .. $self->height - 1 ) {
            for my $x ( 0 .. $self->width - 1 ) {
                my $pixel = $self->getpixel( $x, $y );
                $output .= pack( 'C*', ord( $pixel->char ), $pixel->attr );
            }
        }
    }

    if ( $self->sauce ) {
        $output .= $self->sauce->as_string;
    }

    # set old value
    $self->compress( $compressed );

    return $output;

=cut

}

=head2 width( )

Returns the image width.

=head2 height( )

Returns the image height.

=head1 TODO

=over 4

=item * fix write() method to include compression

=item * use new()'s options to create a new file from scratch

=back

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
