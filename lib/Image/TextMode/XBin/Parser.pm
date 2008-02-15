package Image::TextMode::XBin::Parser;

=head1 NAME

Image::TextMode::XBin::Parser - Reads in XBin image files

=head1 SYNOPSIS

    # This module is used by Image::TextMode::XBin's read()
    my $xbin = Image::TextMode::XBin-read( { file => 'xbin.xb' } );

=cut

use base qw( Class::Data::Accessor );

use strict;
use warnings;

# Compression type constants
use constant NO_COMPRESSION        => 0;
use constant CHARACTER_COMPRESSION => 64;
use constant ATTRIBUTE_COMPRESSION => 128;
use constant FULL_COMPRESSION      => 192;

# Compression byte constants
use constant COMPRESSION_TYPE    => 192;
use constant COMPRESSION_COUNTER => 63;

our $VERSION = '0.06';

__PACKAGE__->mk_classaccessors( qw( xbin ) );

my $eof_char        = chr( 26 );
my $header_template = 'A4 C S S C C';
my @header_fields   = qw( id eofchar width height fontsize flags );

=head1 METHODS

=head2 parse( $xbin, $file, %options )

Reads in the XBin data.

=cut

sub parse {
    my $self = shift;
    my ( $xbin, $file, %options ) = @_;

    $self->xbin( $xbin );

    seek( $file, 0, 0 );

    my $headerdata;
    my $headerlength = $file->read( $headerdata, 11 );

    # does it start with the right data?
    die 'Not an XBin file.'
        unless $headerlength == 11 and $headerdata =~ /^XBIN$eof_char/;

    # parse header data
    $self->_parse_header( $headerdata );

    # read palette if it has one
    if ( $xbin->has_palette ) {
        my $paldata;
        $file->read( $paldata, 48 );
        $xbin->palette(
            Image::TextMode::Palette->new_from_raw_data( $paldata ) );
    }

    # read font if it has one
    if ( $xbin->has_font ) {
        my $fontsize = $xbin->fontsize;
        my $chars = $fontsize * ( $xbin->has_512chars ? 512 : 256 );
        my $fontdata;
        $file->read( $fontdata, $chars );

        $xbin->font(
            Image::TextMode::Font->new_from_raw_data( $fontdata, $fontsize )
        );
    }

    # read compressed or uncompressed data
    if ( $xbin->is_compressed ) {
        $self->_parse_compressed( $file );
    }
    else {
        $self->_parse_uncompressed( $file );
    }

    return $xbin;
}

=head2 xbin( [$xbin] )

Gets / sets the internal XBin object.

=cut

sub _parse_header {
    my $self    = shift;
    my $content = shift;

    my %header;

    @header{ @header_fields } = unpack( $header_template, $content );

    $self->xbin->$_( $header{ $_ } ) for @header_fields;
}

sub _parse_compressed {
    my ( $self, $file ) = @_;

    my $x = 0;
    my $y = 0;

    my $xbin = $self->xbin;
    my $info;
    while ( $file->read( $info, 1 ) ) {
        $info = unpack( 'C', $info );
        last if $info eq $eof_char;

        my $type    = $info & COMPRESSION_TYPE;
        my $counter = ( $info & COMPRESSION_COUNTER ) + 1;

        my ( $char, $attr );

        while ( $counter ) {
            if ( $type == NO_COMPRESSION ) {
                $file->read( $char, 1 );
                $file->read( $attr, 1 );
            }
            elsif ( $type == CHARACTER_COMPRESSION ) {
                $file->read( $char, 1 ) if !defined $char;
                $file->read( $attr, 1 );
            }
            elsif ( $type == ATTRIBUTE_COMPRESSION ) {
                $file->read( $attr, 1 ) if !defined $attr;
                $file->read( $char, 1 );
            }
            else {    # FULL_COMPRESSION
                $file->read( $char, 1 ) if !defined $char;
                $file->read( $attr, 1 ) if !defined $attr;
            }

            $xbin->putpixel(
                $x, $y,
                unpack( 'A', $char ),
                unpack( 'C', $attr )
            );

            $x++;
            if ( $x == $xbin->width ) {
                $x = 0;
                $y++;
            }

            $counter--;
        }
    }
}

sub _parse_uncompressed {
    my ( $self, $file ) = @_;

    my ( $x, $y ) = ( 0, 0 );
    my $xbin = $self->xbin;
    my $chardata;
    while ( $file->read( $chardata, 2 ) ) {
        my @data = unpack( 'aC', $chardata );
        last if $data[ 0 ] eq $eof_char;

        $xbin->putpixel( $x, $y, @data );

        $x++;
        if ( $x == $xbin->width ) {
            $x = 0;
            $y++;
        }
    }
}

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
