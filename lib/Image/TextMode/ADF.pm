package Image::TextMode::ADF;

=head1 NAME

Image::TextMode::ADF - Load, create, manipulate and save ADF image files

=head1 SYNOPSIS

	use Image::TextMode::ADF;

	# Read in a file...
	my $img = Image::TextMode::ADF->read( { file => 'my.adf' } );
    
	# save the data to a file
	$img->write( { file => 'mynew.adf' } );

=head1 DESCRIPTION

ADF stands for "Artworx Data Format"

ADF file stucture:

	+------------+
	| Version    |
	+------------+
	| Palette    |
	+------------+
	| Font       |
	+------------+
	| Image Data |
	+------------+

=cut

use base qw( Image::TextMode );

use strict;
use warnings;

use Image::TextMode::Palette;
use Image::TextMode::Font;

our $VERSION = '0.01';

__PACKAGE__->mk_classaccessors( 'version' );

my @color_idx = (0,1,2,3,4,5,20,7,56,57,58,59,60,61,62,63 );

=head1 METHODS

=head2 clear(  )

Clears any in-memory data.

=cut

sub clear {
    my $self = shift;

    $self->version( undef );

    $self->SUPER::clear( @_ );
}

=head2 parse( %options )

Reads in an ADF.

=cut

sub parse {
    my $self = shift;
    my ( $file, %options ) = @_;

    seek( $file, 0, 0 );

    my $version;
    $file->read( $version, 1 );
    $version = unpack('C', $version);
    $self->version( $version );

    my $paldata;
    $file->read( $paldata, 192 );

    my @pal = unpack( 'C*', $paldata );
    my @colors;
    for( @color_idx ) {
        my $offset = $_ * 3;
        push @colors, [ map { $_ << 2  } @pal[ $offset..$offset+2 ] ],
    }

    $self->palette(
        Image::TextMode::Palette->new( { colors => \@colors } ) );

    my $fontdata;
    $file->read( $fontdata, 4096 );

    $self->font(
        Image::TextMode::Font->new_from_raw_data( $fontdata, 16 )
    );

    my ( $x, $y ) = ( 0, 0 );
    my $chardata;
    while ( $file->read( $chardata, 2 ) ) {
        my @data = unpack( 'aC', $chardata );
        last if $data[ 0 ] eq chr( 26 );
        $self->putpixel( $x, $y, @data );

        $x++;
        if ( $x == 80 ) {
            $x = 0;
            $y++;
        }
    }

    return $self;
}

=head2 as_string( )

Returns the ADF data as a string - suitable for saving.

=cut

sub as_string {
    my $self = shift;

    my $output;

    $output .= pack( 'C', $self->version );

    ## broken - need 64 colors, not 16
    $output .= $self->palette->as_string;
    ##
    $output .= $self->font->as_string;

    for my $row ( @{ $self->_image } ) {
        $output .= join( '', map { pack( 'aC', @$_ ) } @$row )
    }

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
