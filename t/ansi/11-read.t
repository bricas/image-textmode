use Test::More tests => 62;

use strict;
use warnings;

use_ok( 'Image::ANSI' );
use_ok( 'Image::ANSI::Parser' );

my $parser = Image::ANSI::Parser->new;
isa_ok( $parser, 'Image::ANSI::Parser' );

{
    my $ansi = $parser->parse( file => 't/data/test1.ans' );
    isa_ok( $ansi, 'Image::ANSI' );

    check_results( $ansi );
}

{
    my $ansi = $parser->parse( file => 't/data/test2.ans' );
    isa_ok( $ansi, 'Image::ANSI' );

    check_results( $ansi );
}

{
    my $ansi = $parser->parse( file => 't/data/test3.ans' );
    isa_ok( $ansi,        'Image::ANSI' );
    isa_ok( $ansi->sauce, 'File::SAUCE' );
    is( $ansi->sauce->title, 'Test' );

    check_results( $ansi );
}

sub check_results {
    my $ansi = shift;
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
