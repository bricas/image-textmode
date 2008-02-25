package Image::TextMode::Bin;

=head1 NAME

Image::TextMode::Bin - Load, create, manipulate and save Bin image files

=head1 SYNOPSIS

    use Image::TextMode::Bin;

    # Read in a file...
    my $img = Image::TextMode::Bin->read( { file => 'my.bin' } );

    # save the data to a file
    $img->write( { file => 'mynew.bin' } );

=head1 DESCRIPTION

A bin file is a raw textmode video dump. It contains a character, plus an
attribute byte for each "pixel" on the screen.

=cut

use base qw( Image::TextMode::Base );

use strict;
use warnings;

use Carp;

our $VERSION = '0.01';

=head1 METHODS

=head2 parse( %options )

Reads in a Bin.

=cut

sub parse {
    my ( $self, $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $width = $options{ width } || ( $self->has_sauce ? $self->sauce->tinfo1 : '160' );

    my ( $x, $y ) = ( 0, 0 );
    my $chardata;
    while ( $file->read( $chardata, 2 ) ) {
        my @data = unpack( 'aC', $chardata );
        last if $data[ 0 ] eq chr(26);
        $self->putpixel( $x, $y, @data );

        $x++;
        if ( $x == $width ) {
            $x = 0;
            $y++;
        }
    }

    return $self;
}

=head2 as_string( )

Returns the Bin data as a string - suitable for saving.

=cut

sub as_string {
    my $self = shift;
    my $output = '';
    for my $row ( @{ $self->_image } ) {
        $output .= join( '', map { pack( 'aC', @$_ ) } @$row )
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
