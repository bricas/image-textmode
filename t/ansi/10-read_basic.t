use Test::More tests => 480;

use strict;
use warnings;

use_ok( 'Image::ANSI' );
use_ok( 'Image::ANSI::Parser' );

my $parser = Image::ANSI::Parser->new;
isa_ok( $parser, 'Image::ANSI::Parser' );

my $file = 't/data/test.txt';

# can we use the parser directly?
my $ansi = $parser->parse( file => $file );
isa_ok( $ansi, 'Image::ANSI' );

# indirectly through through our main class?
$ansi = Image::ANSI->new( file => $file );
isa_ok( $ansi, 'Image::ANSI' );

my @results = ( [ qw( t e s t ) ] );
check_results( \@results, $file );

$file = 't/data/test2lines.txt';
@results = ( [ qw( t e s t 2 ) ], [ qw( t e s t 2 ) ] );
check_results( \@results, $file );

$file = 't/data/test81cols.txt';
@results = ( [ ( qw( 1 2 3 4 5 6 7 8 9 0 ) ) x 8, '1' ] );
check_results( \@results, $file );

sub check_results {
    my $results = shift;
    my $file    = shift;

    my $ansi = Image::ANSI->new( file => $file );

    for my $y ( 0 .. @$results - 1 ) {
        for my $x ( 0 .. @{ $results->[ $y ] } - 1 ) {
            my $pixel = $ansi->getpixel( $x, $y );
            isa_ok( $pixel, 'Image::ANSI::Pixel' );
            is( $pixel->char,  $results->[ $y ]->[ $x ] );
            is( $pixel->fg,    7 );
            is( $pixel->bg,    0 );
            is( $pixel->blink, 0 );
        }
    }
}

