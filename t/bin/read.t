use strict;
use warnings;

use Test::More tests => 13;

use_ok( 'Image::TextMode::Format::Bin' );

{
    my $bin = Image::TextMode::Format::Bin->new;
    isa_ok( $bin, 'Image::TextMode::Format::Bin' );

    $bin->read( 't/bin/data/test.bin' );

    ok( !$bin->has_sauce, 'No SAUCE' );

    is( $bin->width,  4, 'width()' );
    is( $bin->height, 1, 'height()' );

    {
        my $pixel = $bin->getpixel( 0, 0 );
        is( $pixel->{ char }, 'T', 'char is T' );
        is( $pixel->{ attr }, 8,   'attr is 8' );
    }
    {
        my $pixel = $bin->getpixel( 1, 0 );
        is( $pixel->{ char }, 'E', 'char is E' );
        is( $pixel->{ attr }, 79,  'attr is 79' );
    }
    {
        my $pixel = $bin->getpixel( 2, 0 );
        is( $pixel->{ char }, 'S', 'char is S' );
        is( $pixel->{ attr }, 68,  'attr is 68' );
    }
    {
        my $pixel = $bin->getpixel( 3, 0 );
        is( $pixel->{ char }, 'T', 'char is T' );
        is( $pixel->{ attr }, 35,  'attr is 35' );
    }
}
