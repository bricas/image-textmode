use Test::More tests => 1;

BEGIN {
    use_ok( 'Image::TextMode' );
    use_ok( 'Image::TextMode::Font' );
    use_ok( 'Image::TextMode::Palette' );
    use_ok( 'Image::TextMode::Pixel' );
    use_ok( 'Image::TextMode::Palette::VGA' );
    use_ok( 'Image::TextMode::Font::8x8' );
    use_ok( 'Image::TextMode::Font::8x16' );
}
