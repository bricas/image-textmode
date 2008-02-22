package Image::TextMode::XBin;

=head1 NAME

Image::TextMode::XBin - Load, create, manipulate and save XBin image files

=head1 SYNOPSIS

	use Image::TextMode::XBin;

	# Read in a file...
	my $img = Image::TextMode::XBin->read( { file => 'myxbin.xb' } );

	# Image width and height
	my $w = $img->width;
	my $h = $img->height;

	# get and put "pixels"
	my $pixel = $img->getpixel( $x, $y );
	$img->putpixel( $x, $y, $pixel );

	# font
	my $font = $img->font;

	# palette
	my $palette = $img->palette;

	# save the data to a file
	$img->write( { file => 'x.xb' } );

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

use Image::TextMode::XBin::Parser;

our $VERSION = '0.06';

use constant XBIN_ID => 'XBIN';

# Header byte constants
use constant PALETTE          => 1;
use constant FONT             => 2;
use constant COMPRESSED       => 4;
use constant NON_BLINK        => 8;
use constant FIVETWELVE_CHARS => 16;

my $header_template = 'A4 C S S C C';
my @header_fields   = qw( id eofchar width height fontsize flags );
my $eof_char        = chr( 26 );

__PACKAGE__->mk_classaccessors( @header_fields );

=head1 METHODS

See L<Image::TextMode> for the base API.

=head2 parse( $file, %options )

Calls L<Image::TextMode::XBin::Parser>'s C<parse> method.

=cut

sub parse {
    my $self = shift;

    require Image::TextMode::XBin::Parser;
    Image::TextMode::XBin::Parser->parse( $self, @_ );

    return $self;
}

=head2 as_string( )

Returns the XBin data as a string - suitable for saving.

=cut

sub as_string {
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

    my( $width, $height ) = $self->dimensions;
    # image
    if ( $self->is_compressed ) {

        # RLE compression alg.
    }
    else {
        for my $y ( 0 .. $height - 1 ) {
            for my $x ( 0 .. $width - 1 ) {
                my( $char, $attr ) = $self->getpixel( $x, $y );
                $output .= pack( 'C*', ord( $char ), $attr );
            }
        }
    }

    if ( $self->has_sauce ) {
        $output .= $self->sauce->as_string;
    }

    # set old value
    $self->compress( $compressed );

    return $output;
}

=head2 has_palette( )

Returns true if the file has a custom palette defined.

=cut

sub has_palette {
    return $_[ 0 ]->flags & PALETTE;
}

=head2 has_font( )

Returns true if the file has a custom font defined.

=cut

sub has_font {
    return ( $_[ 0 ]->flags & FONT ) >> 1;
}

=head2 is_compressed( )

Returns true if the data was (or is to be) compressed

=cut

sub is_compressed {
    my $self = shift;
    return $self->compress;
}

=head2 is_nonblink( )

Returns true if the file is in non-blink mode.

=cut

sub is_nonblink {
    return ( $_[ 0 ]->flags & NON_BLINK ) >> 3;
}

=head2 has_512chars( )

Returns true if the font associated with the XBin has 512 characters

=cut

sub has_512chars {
    return ( $_[ 0 ]->flags & FIVETWELVE_CHARS ) >> 4;
}

=head2 font( [$font] )

Gets or sets the font. Must be an object compatible with Image::TextMode::Font.

=cut

sub font {
    my $self = shift;
    my $font = $self->_font_accessor( @_ );

    if( @_ ) {
        $self->flags( $self->flags & ~FIVETWELVE_CHARS );
        $self->flags( $self->flags & ~FONT );

        if( !$font->isa( 'Image::TextMode::Font::8x16' ) ) {
            $self->flags( $self->flags | FONT );
            $self->flags( $self->flags | FIVETWELVE_CHARS )
                if $font->characters == 512;
        }
    }

    return $font;
}

=head2 palette( $palette )

Gets or sets the palette. Must be an object compatible with Image::Textmode::Palette.

=cut

sub palette {
    my $self = shift;
    my $pal = $self->_palette_accessor( @_ );

    if( @_ ) {
        $self->flags( $self->flags & ~PALETTE );

        if( !$pal->isa( 'Image::TextMode::Palette::VGA' ) ) {
            $self->flags( $self->flags | PALETTE );
        }
    }

    return $pal;
}

=head2 compress( $boolean )

Get / sets the compression header value to true or false. Affect the
output from as_string() and write().

=cut

sub compress {
    my $self     = shift;
    my $compress = $_[ 0 ];

    # if $compress is true, set it in the flags. else, unset it
    if ( @_ and $compress ) {
        $self->flags( $self->flags | COMPRESSED );
    }
    elsif ( @_ ) {
        $self->flags( $self->flags & ~COMPRESSED );
    }

    return ( $self->flags & COMPRESSED ) >> 2;
}

=head1 TODO

=over 4

=item * fix write() method to include compression

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
