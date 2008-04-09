use Test::More tests => 477;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );

{
    my $file = 't/ansi/data/test.txt';
    my $ansi = Image::TextMode::ANSI->read( { file => $file } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );
}

{
    my $file = 't/ansi/data/test.txt';
    my @results = ( [ qw( t e s t ) ] );
    check_results( \@results, $file );
}

{
    my $file = 't/ansi/data/test2lines.txt';
    my @results = ( [ qw( t e s t 2 ) ], [ qw( t e s t 2 ) ] );
    check_results( \@results, $file );
}

{
    my $file = 't/ansi/data/test81cols.txt';
    my @results = ( [ ( qw( 1 2 3 4 5 6 7 8 9 0 ) ) x 8, '1' ] );
    check_results( \@results, $file );
}

sub check_results {
    my $results = shift;
    my $file    = shift;

    my $ansi = Image::TextMode::ANSI->read( { file => $file } );

    for my $y ( 0 .. @$results - 1 ) {
        for my $x ( 0 .. @{ $results->[ $y ] } - 1 ) {
            my $pixel = $ansi->getpixel( $x, $y );
            isa_ok( $pixel, 'Image::TextMode::Pixel' );
            is( $pixel->char,  $results->[ $y ]->[ $x ] );
            is( $pixel->fg,    7 );
            is( $pixel->bg,    0 );
            is( $pixel->blink, 0 );
        }
    }
}

