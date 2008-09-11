use Test::More tests => 9;

use strict;
use warnings;

use_ok( 'Image::TextMode::Format::XBin' );

{
    my $file = 'test1.xb';
    my $xbin  = Image::TextMode::Format::XBin->new;
    $xbin->read( "t/xbin/data/${file}" );

    isa_ok( $xbin, 'Image::TextMode::Format::XBin' );
    is( $xbin->width,  80, "${ file } width()" );
    is( $xbin->height, 1,  "${ file } height()" );

    my $font = $xbin->font;
    isa_ok( $font, 'Image::TextMode::Font' );

    # modified 't' char
    is_deeply(
        $font->chars->[ ord( 't' ) ],
        [ 255, 255, ( 0 ) x 14 ],
        'font: modified t'
    );

    my $pal = $xbin->palette;
    isa_ok( $pal, 'Image::TextMode::Palette' );

    # modified 'brown' color
    is_deeply( $pal->colors->[ 6 ], [ 252, 252, 252 ],
        'pal: modified brown' );

    is_deeply(
        $xbin->pixeldata,
        [   [   { char => 't', attr => 7 },
                { char => 'e', attr => 6 },
                { char => 's', attr => 5 },
                { char => 't', attr => 4 },
                ( { char => ' ', attr => 7 } ) x 76,
            ]
        ],
        "${ file } pixeldata"
    );

}

