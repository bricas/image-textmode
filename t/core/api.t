use strict;
use warnings;

use Test::More tests => 6;

use_ok( 'Image::TextMode' );

{
    my $image = Image::TextMode->new;
    isa_ok( $image, 'Image::TextMode' );

    my $pixel = { char => 'X', fg => 7, bg => 0 };
    $image->putpixel( $pixel, 0, 0 );

    is_deeply( $image->canvas->pixeldata, [ [ $pixel ] ], 'putpixel() ok' );
    is_deeply( $image->getpixel( 0, 0 ), $pixel, 'getpixel() ok' );

    is( $image->width, 1, 'width() ok' );
    is( $image->height, 1, 'height() ok' );
}
