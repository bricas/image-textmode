use Test::More tests => 5;

BEGIN {
    use_ok( 'Image::TextMode::XBin' );
}

my $xbin = Image::TextMode::XBin->new;

isa_ok( $xbin, 'Image::TextMode::XBin' );

$xbin->width( 80 );
is( $xbin->width, 80, '$xbin->width' );

$xbin->height( 25 );
is( $xbin->height, 25, '$xbin->height' );

$xbin->compress( 1 );
is( $xbin->compress, 1, '$xbin->compress' );

