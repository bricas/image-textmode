use Test::More tests => 6;

use strict;
use warnings;

use_ok( 'Image::TextMode::Font' );

{
    my $f = Image::TextMode::Font->new(
        width         => 8,
        height        => 8,
        chars         => [ [ ( 255 ) x 8 ], ],
        intensity_map => [ 255, ],
    );

    isa_ok( $f, 'Image::TextMode::Font' );
    is( $f->width,      8, 'width' );
    is( $f->height,     8, 'height' );
    is( $f->characters, 1, 'characters' );
    is_deeply( $f->get( 0 ), [ ( 255 ) x 8 ], 'get' );
}
