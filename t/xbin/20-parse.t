use Test::More qw( no_plan );

BEGIN {
    use_ok( 'Image::XBin::Parser' );
}

my $parser = Image::XBin::Parser->new;

isa_ok( $parser, 'Image::XBin::Parser' );

my $xbin;

$xbin = $parser->parse( file => 't/data/0699MEMB.XB' );

isa_ok( $xbin,          'Image::XBin' );
isa_ok( $xbin->font,    'Image::XBin::Font' );
isa_ok( $xbin->palette, 'Image::XBin::Palette' );
isa_ok( $xbin->sauce,   'File::SAUCE' );
is( $xbin->compress, 0, 'Uncompressed XBin' );

$xbin = $parser->parse( file => 't/data/CT-XBIN.XB' );

isa_ok( $xbin,          'Image::XBin' );
isa_ok( $xbin->font,    'Image::XBin::Font' );
isa_ok( $xbin->palette, 'Image::XBin::Palette' );
is( $xbin->sauce,    undef, 'No SAUCE' );
is( $xbin->compress, 1,     'Compressed XBin' );
