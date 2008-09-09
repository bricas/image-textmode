use strict;
use warnings;

use Test::More tests => 9;

use_ok( 'Image::TextMode::Format::Bin' );

{
    my $bin = Image::TextMode::Format::Bin->new;
    isa_ok( $bin, 'Image::TextMode::Format::Bin' );

    open( my $fh, 't/bin/data/test.bin' );
    $bin->read( $fh );
    close( $fh );

    ok( !$bin->has_sauce, 'No SAUCE' );

    is( $bin->width,  4, 'width()' );
    is( $bin->height, 1, 'height()' );

    {
        my $pixel = $bin->getpixel( 0, 0 );
        is( $pixel->{char},  'T', 'char is T' );
    }
    {
        my $pixel = $bin->getpixel( 1, 0 );
        is( $pixel->{char},  'E', 'char is E' );
    }
    {
        my $pixel = $bin->getpixel( 2, 0 );
        is( $pixel->{char},  'S', 'char is S' );
    }
    {
        my $pixel = $bin->getpixel( 3, 0 );
        is( $pixel->{char},  'T', 'char is T' );
   }
}
