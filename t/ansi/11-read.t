use Test::More tests => 60;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );

for( 1..3 ) {
    check_results( Image::TextMode::ANSI->read( { file => "t/ansi/data/test${_}.ans" } ) );
}

sub check_results {
    my $ansi = shift;
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    if( $ansi->has_sauce ) {
        isa_ok( $ansi->sauce, 'File::SAUCE' );
        is( $ansi->sauce->title, 'Test' );
    }

    is( $ansi->width,  4 );
    is( $ansi->height, 1 );

    {
        my $pixel = $ansi->getpixel( 0, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    8 );
        is( $pixel->bg,    0 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 1, 0 );
        is( $pixel->char,  'E' );
        is( $pixel->fg,    15 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 1 );
    }
    {
        my $pixel = $ansi->getpixel( 2, 0 );
        is( $pixel->char,  'S' );
        is( $pixel->fg,    4 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 3, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    3 );
        is( $pixel->bg,    2 );
        is( $pixel->blink, 0 );
    }
}
