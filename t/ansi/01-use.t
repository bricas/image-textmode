use Test::More tests => 10;

use strict;
use warnings;

BEGIN {
    use_ok( 'Image::ANSI' );
    use_ok( 'Image::ANSI::Parser' );
    use_ok( 'Image::ANSI::Pixel' );
    use_ok( 'Image::ANSI::Font' );
    use_ok( 'Image::ANSI::Font::8x16' );
    use_ok( 'Image::ANSI::Font::8x8' );
    use_ok( 'Image::ANSI::Palette' );
    use_ok( 'Image::ANSI::Palette::VGA' );
    use_ok( 'Image::ANSIMation' );
    use_ok( 'Image::ANSIMation::Parser' );
}

