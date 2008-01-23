package Image::TextMode::Tundra;

=head1 NAME

Image::TextMode::Tundra - Load, create, manipulate and save Tundra image files

=head1 SYNOPSIS

	use Image::TextMode::Tundra;

	# Read in a file...
	my $img = Image::TextMode::Tundra->read( { file => 'my.tnd' } );

	# save the data to a file
	$img->write( { file => 'mynew.tnd' } );

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

use base qw( Image::TextMode );

use strict;
use warnings;

use Carp;

our $VERSION = '0.01';

__PACKAGE__->mk_classaccessors( qw( int_id id ) );

=head1 METHODS

=head2 new( %options )

Creates a new XBin image. Currently only reads in data.

	# filename
	$xbin = Image::XBin->new( file => 'file.xb' );
	
	# file handle
	$xbin = Image::XBin->new( handle => $handle );

	# string
	$xbin = Image::XBin->new( string => $string );

=cut

=head2 read( %options )

Explicitly reads in an XBin.

=cut

sub parse {
    my $self = shift;

    require Image::TextMode::Tundra::Parser;
    Image::TextMode::Tundra::Parser->parse( $self, @_ );

    return $self;
}

sub as_bitmap_full {
    my ( $self, $options ) = ( shift, shift );
    $options->{ truecolor } = 1;
    return $self->SUPER::as_bitmap_full( $options, @_ );
}

=head2 as_string( )

Returns the XBin data as a string - suitable for saving.

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

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
