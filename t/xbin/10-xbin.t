use Test::More tests => 8;

BEGIN {
    use_ok( 'Image::XBin' );
}

my $xbin = Image::XBin->new;

isa_ok( $xbin, 'Image::XBin' );

$xbin->width( 80 );
is( $xbin->width, 80, '$xbin->width' );

$xbin->height( 25 );
is( $xbin->height, 25, '$xbin->height' );

$xbin->compress( 1 );
is( $xbin->compress, 1, '$xbin->compress' );

$xbin->clear;
is( $xbin->width,    0, '$xbin->width' );
is( $xbin->height,   0, '$xbin->height' );
is( $xbin->compress, 0, '$xbin->compress' );
