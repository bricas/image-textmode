package Image::TextMode;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

use Image::TextMode::Pixel;
use Image::TextMode::Palette::VGA;
use Image::TextMode::Font::8x16;
use File::SAUCE;
use IO::File;
use IO::String;

__PACKAGE__->mk_classaccessors( qw( width height ) );
__PACKAGE__->mk_classaccessor( _image => [] );
__PACKAGE__->mk_classaccessor( blink_mode => 0);
__PACKAGE__->mk_classaccessor( sauce => File::SAUCE->new );
__PACKAGE__->mk_classaccessor( palette => Image::TextMode::Palette::VGA->new );
__PACKAGE__->mk_classaccessor( font => Image::TextMode::Font::8x16->new );

our $VERSION = '0.01';

=head1 NAME

Image::TextMode - A base class for text mode graphics

=head1 SYNOPSIS

    package MyFormat;
    
    use base qw( Image::TextMode );

    sub parse { ... }

    sub as_string { ... }

    1;

=head1 DESCRIPTION

This module provides the basic structure to represent a text mode image such
as an ANSI file.

The basic structure of the image is an array of arrays to represent lines
and "pixels." A "pixel" in this case is a character and attribute byte pair.
With blink_mode on, an attribute byte is repsented as:

    +---+---+---+---+---+---+---+---+
    | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
    +---+---+---+---+---+---+---+---+
    
    bits 0-3: foreground color index
    bits 4-6: background color index
    bit 7: blink on/off

With blink_mode off, byte 7 becomes part of the background color index.

Some textmode formats supply special font and palette data which can be
stored as well. The basic VGA palette and an 8x16 font are available as
defaults.

=head1 ACCESSORS

=over 4

=item * width - The width of the image

=item * height - The height of the image

=item * sauce - The SAUCE metadata

=item * font - A font instance

=item * palette - A palette instance

=item * blink_mode - A boolean for blink mode

=back

=head1 METHODS

=head2 new( \%opts )

Creates a new Image::ANSI instance.

=cut

sub new {
    my $class = shift;
    my $args  = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };
    my $self  = bless $args, $class;
    return $self;
}

=head2 clear_screen( )

Clears the image data plus width and height information.

=cut

sub clear_screen {
    my $self = shift;
    $self->$_( undef ) for qw( width height );
    $self->_image( [] );
}

=head2 read( \%opts )

The public class method for reading file data. Calls the C<parse()> method.

=cut

sub read {
    my ( $class, $options ) = ( shift, shift );
    my $file = $class->_create_io_object( $options );
    my $self = $class->new;

    # attempt to find a sauce record in the file
    $self->sauce->read( handle => $file );

    return $self->parse( $file, @_ );
}

=head2 write( \%opts )

The public method for writing to a file. Calls the C<as_string()> metod.

=cut

sub write {
    my ( $self, $options ) = ( shift, shift );
    my $file = $self->_create_io_object( $options, '>' );

    $file->print( $self->as_string( @_ ) );
}

=head2 getpixel( $x, $y )

Returns the "pixel" at C<$x>, C<$y>. In scalar mode this means a Pixel object,
in list mode it means raw char and attribute bytes.

=cut

sub getpixel {
    my ( $self, $x, $y ) = @_;

    if (    exists $self->_image->[ $y ]
        and exists $self->_image->[ $y ]->[ $x ] )
    {
        my $data = $self->_image->[ $y ]->[ $x ];
        return wantarray
            ? @$data
            : Image::TextMode::Pixel->new(
            {   char       => $data->[ 0 ],
                attr       => $data->[ 1 ],
                blink_mode => $self->blink_mode
            }
            );
    }

    return;
}

=head2 putpixel( $x, $y, ( $char, $attr || $pixel ) )

Sets the pixel at C<$x>, C<$y>. Accepts a Pixel object or a char-attribute
pair.

=cut

sub putpixel {
    my ( $self, $x, $y, $pixel, $attr ) = @_;
    my $char = $pixel;

    if ( ref $pixel ) {
        $char = $pixel->char;
        $attr = $pixel->attr;
    }

    $self->_image->[ $y ]->[ $x ] = [ $char, $attr ];
}

=head2 clear_line( $line )

Clears the specified (0-indexed) line.

=cut

sub clear_line {
    my $self = shift;
    my $y    = shift;

    my $line = $self->_image->[ $y ];

    $self->_image->[ $y ] = [] if defined $line;
}

=head2 as_ascii( )

Returns only the char attributes for the image.

=cut

sub as_ascii {
    my ( $self ) = @_;

    my $output = '';
    for my $row ( @{ $self->_image } ) {
        $output
            .= join( '', map { defined $_->[ 0 ] ? $_->[ 0 ] : ' ' } @$row )
            . "\n";
    }

    return $output;
}

sub _create_io_object {
    my ( $self, $options, $perms ) = @_;

    if ( !ref $options ) {
        $options = { file => $options };
    }

    $perms = '<' unless $perms;

    my $file;

    # use appropriate IO object for what we get in
    if ( exists $options->{ file } ) {
        $file = IO::File->new( $options->{ file }, $perms ) || die "$!";
    }
    elsif ( exists $options->{ string } ) {
        $file = IO::String->new( $options->{ string }, $perms );
    }
    elsif ( exists $options->{ handle } ) {
        $file = $options->{ handle };
    }
    else {
        die
            "No valid read type. Must be one of 'file', 'string' or 'handle'.";
    }

    binmode( $file );
    return $file;
}

=head2 has_sauce( [$bool] )

Returns or sets the status of the SAUCE record (useful for C<read()> and
C<write()> operations).

=cut

sub has_sauce {
    return shift->sauce->has_sauce( @_ );
}

=head2 calculate_and_set_dimensions( )

Calls C<calculate_dimensions> and sets the width and height with those values.

=cut

sub calculate_and_set_dimensions {
    my $self = shift;
    my ( $width, $height ) = $self->calculate_dimensions;
    $self->width( $width );
    $self->height( $height );
}

=head2 calculate_dimensions( )

Finds out the width and height of the image based on the stored data.

=cut

sub calculate_dimensions {
    my $self   = shift;
    my $image  = $self->_image;
    my $height = scalar @$image;
    my $max_x  = 0;
    for ( @$image ) {
        my $x = $_ ? scalar @$_ : 0;
        $max_x = $x if $x > $max_x;
    }
    return $max_x, $height;
}

=head2 dimensions( )

Shortcut to return the width and height.

=cut

sub dimensions {
    my $self = shift;
    return $self->width, $self->height;
}

=head2 as_bitmap_full( \%options )

Outputs a bitmap image of the text mode data. Options include:

=over 4

=item * crop - limit the output to the specified number of text mode lines

=item * format - output this format (default: png)

=item * 9th_bit - use 720px mode which adds a ninth bit to each character (default: off)

=back

=cut

## TODO: custom gd-font

sub as_bitmap_full {
    my ( $self, $options ) = @_;

    my $font = $self->font->as_gd(
        { '9th_bit' => delete $options->{ '9th_bit' } } );
    my $ftheight = $font->height;
    my $ftwidth  = $font->width;

    my ( $width, $height )
        = $self->width ? $self->dimensions : $self->calculate_dimensions;
    $height = $options->{ crop } if $options->{ crop };

    $options->{ truecolor } ||= 0;

    require GD;
    my $image = GD::Image->new( $width * $ftwidth, $height * $ftheight, $options->{ truecolor } );
    my $colors = $self->palette->fill_gd_palette( $image );

    for my $y ( 0 .. $height - 1 ) {
        for my $x ( 0 .. $width - 1 ) {
            my $pixel = $self->getpixel( $x, $y );

            next unless $pixel;

            if ( defined $pixel->bg ) {
                $image->filledRectangle(
                    $x * $ftwidth,
                    $y * $ftheight,
                    ( $x + 1 ) * $ftwidth,
                    ( $y + 1 ) * $ftheight - 1,
                    $colors->[ $pixel->bg ]
                );
            }

            $image->string(
                $font,
                $x * $ftwidth,
                $y * $ftheight,
                $pixel->char, $colors->[ $pixel->fg ]
            );
        }
    }

    my $output = $options->{ format } || 'png';

    return $image->$output;
}

=head2 as_bitmap_thumbnail( \%options )

Outputs a thumbnailed bitmap image of the text mode data. Options are the
same as C<as_bitmap_full()>, except:

=over 4

=item * zoom - a positive integer; it will enlarge the picture by that factor

=back

For images with a non-standard font, it is recommended you take the output of
C<as_bitmap_full()> and resize it instead.

=cut

sub as_bitmap_thumbnail {
    my ( $self, $options ) = @_;

    my $font     = $self->font;
    my $ftheight = int( $font->height / 8 + 0.5 );

    my ( $width, $height )
        = $self->width ? $self->dimensions : $self->calculate_dimensions;
    $height = $options->{ crop } if $options->{ crop };

    require GD;
    my $image     = GD::Image->new( $width, $height * $ftheight, 1 );
    my $intensity = $font->intensity_map;
    my $colors    = $self->palette->fill_gd_palette_8step( $image );

    for my $y ( 0 .. $height - 1 ) {
        for my $x ( 0 .. $width - 1 ) {
            my $pixel = $self->getpixel( $x, $y );
            next unless $pixel;

            my $offset  = $pixel->fg * 8 + $pixel->bg;
            my $charint = $intensity->[ ord( $pixel->char ) ];
            my $color   = $colors->[ $offset ];
            next unless $color;

            unless ( $ftheight == 1 ) {
                $image->setPixel(
                    $x,
                    $y * $ftheight + 1,
                    $color->[ $charint & 15 ]
                );
            }
            $image->setPixel( $x, $y * $ftheight, $color->[ $charint >> 4 ] );
        }
    }

    my $output = $options->{ format } || 'png';
    my $zoom   = $options->{ zoom }   || 1;

    return $image->$output unless $zoom > 1;

    my ( $iwidth, $iheight ) = $image->getBounds;

    my $scalex = $iwidth * $zoom;
    my $scaley = $iheight * $zoom;

    my $image2 = GD::Image->new( $scalex, $scaley );
    $image2->copyResized( $image, 0, 0, 0, 0, $scalex, $scaley, $iwidth,
        $iheight );

    return $image2->$output;
}

=head1 ABSTRACT METHODS

=head2 parse( $fh, @args )

Subclasses should read data from C<$fh>.

=cut

sub parse {
    die 'Abstract method!';
}

=head2 as_string( @args )

Subclasses should serialize the data as a string.

=cut

sub as_string {
    die 'Abstract method!';
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
