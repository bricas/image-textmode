package Image::TextMode::Tundra::Parser;

=head1 NAME

Image::XBin::Parser - Reads in XBin image files

=head1 SYNOPSIS

	my $parser = Image::XBin::Parser->new;
	my $xbin   = $parser->parse( file => 'xbin.xb' );

=cut

use strict;
use warnings;

use constant WRAP => 80;

our $VERSION = '0.01';

=head1 METHODS

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
    my ( $tnd, $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $buffer;
    $file->read( $buffer, 1 );
    $tnd->int_id( unpack('C', $buffer ) );

    $file->read( $buffer, 8 );
    $tnd->id( unpack('A8', $buffer ) );

    my $pal = Image::TextMode::Palette->new;
    my $sauce = $tnd->sauce;
    my $wrap = $options{ linewrap } || ( $sauce->has_sauce ? $sauce->tinfo1 : WRAP );

    my( $x, $y, $attr, $fg, $bg, $pal_index ) = ( 0 ) x 6;
    $pal->set( $pal_index++, [ 0, 0, 0 ] );

    while( $file->read( $buffer, 1 ) ) {
        my $command = ord( $buffer );

        if( $command == 1 ) { # position
            $file->read( $buffer, 8 );
            ( $y, $x ) = unpack( 'N*', $buffer );
            next;
        }

        my $char;

        if( $command == 2 ) { # fg
            $file->read( $char, 1 );
            $file->read( $buffer, 4 );
            my $rgb = unpack(  'N', $buffer );
            $fg = $pal_index++;
            $pal->set( $fg, [ ( $rgb >> 16 ) & 0x000000ff,( $rgb >> 8 ) & 0x000000ff, $rgb & 0x000000ff, ] );
        }
        elsif( $command == 4 ) { # bg
            $file->read( $char, 1 );
            $file->read( $buffer, 4 );
            my $rgb = unpack(  'N', $buffer );
            $bg = $pal_index++;
            $pal->set( $bg, [ ( $rgb >> 16 ) & 0x000000ff,( $rgb >> 8 ) & 0x000000ff, $rgb & 0x000000ff, ] );
        }
        elsif( $command == 6 ) { # fg + bg
            $file->read( $char, 1 );
            $file->read( $buffer, 8 );
            my @rgb = unpack(  'N*', $buffer );
            $fg = $pal_index++;
            $pal->set( $fg, [ ( $rgb[ 0 ] >> 16 ) & 0x000000ff,( $rgb[ 0 ] >> 8 ) & 0x000000ff, $rgb[ 0 ] & 0x000000ff, ] );
            $bg = $pal_index++;
            $pal->set( $bg, [ ( $rgb[ 1 ] >> 16 ) & 0x000000ff,( $rgb[ 1 ] >> 8 ) & 0x000000ff, $rgb[ 1 ] & 0x000000ff, ] );
        }

        if( !$char ) {
            $char = chr( $command );
        }

        $tnd->putpixel( $x, $y, $char, { fg => $fg, bg => $bg } );
        $x++;

        if( $x == $wrap ) {
            $x = 0;
            $y++;
        }
    }

    $tnd->palette( $pal );
    return $tnd;
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
