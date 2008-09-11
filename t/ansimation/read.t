use Test::More tests => 17;

use strict;
use warnings;

use_ok( 'Image::TextMode::Format::ANSIMation' );

my @files = qw( ansimation1.ans ansimation2.ans );

for my $file ( @files ) {
    my $ansi = Image::TextMode::Format::ANSIMation->new;
    $ansi->read( "t/ansimation/data/${ file }" );

    isa_ok( $ansi, 'Image::TextMode::Format::ANSIMation' );
    is( $ansi->width,  4, "${ file } width()" );
    is( $ansi->height, 1, "${ file } height()" );

    my @frames = @{ $ansi->frames };
    is( scalar @frames, 2, "${ file } frames()" );

    for my $frame ( @frames ) {
        isa_ok( $frame, 'Image::TextMode::Canvas' );
        is_deeply(
            $frame->pixeldata,
            [   [   { char => 'T', attr => 8 },
                    { char => 'E', attr => 207 },
                    { char => 'S', attr => 68 },
                    { char => 'T', attr => 35 },
                ]
            ],
            "${ file } frame->pixeldata"
        );
    }
}

