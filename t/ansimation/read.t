use Test::More tests => 85;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSIMation' );

use GD qw( :cmp );

eval { my $image = GD::Image->new; $image->gifanimbegin; };
my $cananim = $@ ? 0 : 1;

{
    my $ansimation = Image::TextMode::ANSIMation->read( { file => 't/ansimation/data/ansimation1.ans' } );
    isa_ok( $ansimation, 'Image::TextMode::ANSIMation' );
    is( $ansimation->width,              4 );
    is( $ansimation->height,             1 );
    is( scalar @{ $ansimation->frames }, 2 );

    check_results( $ansimation->frames->[ 0 ] );
    check_results( $ansimation->frames->[ 1 ] );

    for ( qw( 0 1 0 ) ) {
        my $frame = $ansimation->next_frame;
        is( $frame, $ansimation->frames->[ $_ ] );
    }

SKIP: {
        skip 'libgd 2.0.33 or higher required for ansimation support', 1,
            unless $cananim;
        my $expected  = GD::Image->new( 't/ansimation/data/ansimation1.gif' );
        my $generated = GD::Image->new( $ansimation->as_gif );
        ok( !( $expected->compare( $generated ) & GD_CMP_IMAGE ) );
    }
}

{
    my $ansimation = Image::TextMode::ANSIMation->read( { file => 't/ansimation/data/ansimation2.ans' } );
    isa_ok( $ansimation, 'Image::TextMode::ANSIMation' );
    is( $ansimation->width,              4 );
    is( $ansimation->height,             1 );
    is( scalar @{ $ansimation->frames }, 2 );

    check_results( $ansimation->frames->[ 0 ] );
    check_results( $ansimation->frames->[ 1 ] );
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
