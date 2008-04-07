use Test::More tests => 61;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );
use_ok( 'Image::ANSIMation' );

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/test1.ans' } );
    my $output;
    $ansi->write( { string => \$output } );
    my $got = Image::TextMode::ANSI->read( { string => \$output } );

    isa_ok( $got, 'Image::TextMode::ANSI' );

    check_results( $got );
}

{
    my $ansimation
        = Image::ANSIMation->new( file => 't/data/ansimation1.ans' );
    my $output;
    $ansimation->write( string => \$output );
    my $got = Image::ANSIMation->new( string => \$output );

    isa_ok( $got, 'Image::ANSIMation' );
    is( $got->width,              4 );
    is( $got->height,             1 );
    is( scalar @{ $got->frames }, 2 );

    check_results( $got->frames->[ 0 ] );
    check_results( $got->frames->[ 1 ] );

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
