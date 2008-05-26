use Test::More tests => 21;

use strict;
use warnings;

use_ok( 'Image::TextMode::Bin' );

{
    my $bin = Image::TextMode::Bin->read( { file => "t/bin/data/test.bin" } );
    isa_ok( $bin, 'Image::TextMode::Bin' );

    ok( !$bin->has_sauce, 'No SAUCE' );

    is( $bin->width,  4 );
    is( $bin->height, 1 );

    {
        my $pixel = $bin->getpixel( 0, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    8 );
        is( $pixel->bg,    0 );
        ok( !defined $pixel->blink );
    }
    {
        my $pixel = $bin->getpixel( 1, 0 );
        is( $pixel->char,  'E' );
        is( $pixel->fg,    15 );
        is( $pixel->bg,    4 );
        ok( !defined $pixel->blink );
    }
    {
        my $pixel = $bin->getpixel( 2, 0 );
        is( $pixel->char,  'S' );
        is( $pixel->fg,    4 );
        is( $pixel->bg,    4 );
        ok( !defined $pixel->blink );
    }
    {
        my $pixel = $bin->getpixel( 3, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    3 );
        is( $pixel->bg,    2 );
         ok( !defined $pixel->blink );
   }
}
