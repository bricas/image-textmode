use Test::More tests => 35;

use_ok( 'Image::TextMode' );

my $image = Image::TextMode->new;
isa_ok( $image, 'Image::TextMode' );

{
    $image->putpixel( 0, 0, 'H', 7 );    # white text on black, no blink
    my $pixel = $image->getpixel( 0, 0 );
    isa_ok( $pixel, Image::TextMode::Pixel );
    is( $pixel->char,  'H', 'char' );
    is( $pixel->attr,  7,   'attr' );
    is( $pixel->fg,    7,   'fg' );
    is( $pixel->bg,    0,   'bg' );
    is( $pixel->blink, undef,   'blink' );
}

{
    $image->putpixel( 1, 0, 'i', 199 );    # white text on green, w/ blink
    my $pixel = $image->getpixel( 1, 0 );
    isa_ok( $pixel, Image::TextMode::Pixel );
    is( $pixel->char,  'i', 'char' );
    is( $pixel->attr,  199, 'attr' );
    is( $pixel->fg,    7,   'fg' );
    is( $pixel->bg,    12,   'bg' );
    is( $pixel->blink, undef,   'blink' );
}

{ # blink mode test
    $image->blink_mode( 1 );
    my $pixel = $image->getpixel( 1, 0 );
    isa_ok( $pixel, Image::TextMode::Pixel );
    is( $pixel->char,  'i', 'char' );
    is( $pixel->attr,  199, 'attr' );
    is( $pixel->fg,    7,   'fg' );
    is( $pixel->bg,    4,   'bg' );
    is( $pixel->blink, 1,   'blink' );

    # turn it off again
    $image->blink_mode( 0 );
}

{
    use_ok( 'Image::TextMode::Pixel' );
    my $pixel = Image::TextMode::Pixel->new(
        {   char  => '!',
            fg    => 0,
            bg    => 7,
        }
    );

    isa_ok( $pixel, 'Image::TextMode::Pixel' );
    is( $pixel->char,  '!', 'char' );
    is( $pixel->attr,  112, 'attr' );
    is( $pixel->fg,    0,   'fg' );
    is( $pixel->bg,    7,   'bg' );
    is( $pixel->blink, undef,   'blink' );

    $image->putpixel( 2, 0, $pixel );

    {
        my $pixel = $image->getpixel( 2, 0 );
        isa_ok( $pixel, 'Image::TextMode::Pixel' );
        is( $pixel->char,  '!', 'char' );
        is( $pixel->attr,  112, 'attr' );
        is( $pixel->fg,    0,   'fg' );
        is( $pixel->bg,    7,   'bg' );
        is( $pixel->blink, undef,   'blink' );
    }
}

is( $image->as_ascii, "Hi!\n", 'as_ascii' );

{
    $image->clear_line( 0 );
    is_deeply( $image->_image->[ 0 ], [], 'clear_line' );
}

