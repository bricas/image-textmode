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

The "Tundra" format was created for the Tundra Draw program. It allows for
a 24 bit palette.

Tundra file stucture:

    +----------------------+
    |        Header        |
    +----------------------+
    | Palette / Image Data |
    +----------------------+

=cut

use base qw( Image::TextMode::Base );

use strict;
use warnings;

use constant WRAP => 80;

our $VERSION = '0.01';

__PACKAGE__->mk_accessors( qw( int_id id ) );

=head1 METHODS

=head2 _parse( %options )

Does the heavy lifting for reading in a Tundra file.

=cut

sub _parse {
    my $self = shift;
    my ( $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $buffer;
    $file->read( $buffer, 1 );
    $self->int_id( unpack('C', $buffer ) );

    $file->read( $buffer, 8 );
    $self->id( unpack('A8', $buffer ) );

    my $pal = Image::TextMode::Palette->new;
    my $sauce = $self->sauce;
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

        $self->putpixel( $x, $y, $char, { fg => $fg, bg => $bg } );
        $x++;

        if( $x == $wrap ) {
            $x = 0;
            $y++;
        }
    }

    $self->palette( $pal );

    return $self;
}

=head2 as_bitmap_full( \%options )

Truns on "truecolor" before calling the superclass' method.

=cut

sub as_bitmap_full {
    my ( $self, $options ) = ( shift, shift );
    $options->{ truecolor } = 1;
    return $self->SUPER::as_bitmap_full( $options, @_ );
}

=head2 as_string( )

Returns the Tundra data as a string - suitable for saving.

=cut

sub as_string {
    my $self = shift;

    my $output;

    if ( $self->sauce ) {
        $output .= $self->sauce->as_string;
    }

    return $output;
}

=head1 TODO

=over 4

=item * Finish the as_string() method.

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
