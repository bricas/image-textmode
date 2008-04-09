use Test::More tests => 11;

BEGIN {
    use_ok( 'Image::TextMode::XBin' );
}

{
    my $xbin = Image::TextMode::XBin->read( { file => 't/xbin/data/0699MEMB.XB' } );

    isa_ok( $xbin,           'Image::TextMode::XBin' );
    isa_ok( $xbin->font,     'Image::TextMode::Font' );
    isa_ok( $xbin->palette,  'Image::TextMode::Palette' );
    is( $xbin->has_sauce, 1, 'Has SAUCE' );
    is( $xbin->compress, 0,  'Uncompressed XBin' );
}

{
    my $xbin = Image::TextMode::XBin->read( { file => 't/xbin/data/CT-XBIN.XB' } );

    isa_ok( $xbin,           'Image::TextMode::XBin' );
    isa_ok( $xbin->font,     'Image::TextMode::Font' );
    isa_ok( $xbin->palette,  'Image::TextMode::Palette' );
    is( $xbin->has_sauce, 0, 'No SAUCE' );
    is( $xbin->compress, 1,  'Compressed XBin' );
}
