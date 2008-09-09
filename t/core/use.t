use strict;
use warnings;

use Test::More tests => 8;

use_ok( 'Image::TextMode' );

{
    my $image = Image::TextMode->new;
    isa_ok( $image, 'Image::TextMode' );

    # some defaults
    isa_ok( $image->font, 'Image::TextMode::Font::8x16' );
    isa_ok( $image->palette, 'Image::TextMode::Palette::VGA' );
    isa_ok( $image->canvas, 'Image::TextMode::Canvas' );
    isa_ok( $image->sauce, 'Image::TextMode::SAUCE' );

    is( $image->width, 0, 'default width' );
    is( $image->height, 0, 'default height' );
}
