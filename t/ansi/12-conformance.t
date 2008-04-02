use Test::More tests => 96;
use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/tab.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    is( $ansi->width,  18 );
    is( $ansi->height, 1 );

    {
        my $pixel = $ansi->getpixel( 7, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    8 );
        is( $pixel->bg,    0 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 15, 0 );
        is( $pixel->char,  'E' );
        is( $pixel->fg,    15 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 1 );
    }
    {
        my $pixel = $ansi->getpixel( 16, 0 );
        is( $pixel->char,  'S' );
        is( $pixel->fg,    4 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 17, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    3 );
        is( $pixel->bg,    2 );
        is( $pixel->blink, 0 );
    }
}

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/move.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

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

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/saverestore.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

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

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/clearscreen.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    is( $ansi->width,  12 );
    is( $ansi->height, 1 );

    {
        my $pixel = $ansi->getpixel( 8, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    8 );
        is( $pixel->bg,    0 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 9, 0 );
        is( $pixel->char,  'E' );
        is( $pixel->fg,    15 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 1 );
    }
    {
        my $pixel = $ansi->getpixel( 10, 0 );
        is( $pixel->char,  'S' );
        is( $pixel->fg,    4 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 11, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    3 );
        is( $pixel->bg,    2 );
        is( $pixel->blink, 0 );
    }
}

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/clearline.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    is( $ansi->width,  12 );
    is( $ansi->height, 1 );

    {
        my $pixel = $ansi->getpixel( 8, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    8 );
        is( $pixel->bg,    0 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 9, 0 );
        is( $pixel->char,  'E' );
        is( $pixel->fg,    15 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 1 );
    }
    {
        my $pixel = $ansi->getpixel( 10, 0 );
        is( $pixel->char,  'S' );
        is( $pixel->fg,    4 );
        is( $pixel->bg,    4 );
        is( $pixel->blink, 0 );
    }
    {
        my $pixel = $ansi->getpixel( 11, 0 );
        is( $pixel->char,  'T' );
        is( $pixel->fg,    3 );
        is( $pixel->bg,    2 );
        is( $pixel->blink, 0 );
    }
}

