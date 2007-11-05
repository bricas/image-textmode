use Test::More tests => 15;

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
    is( $pixel->blink, 0,   'blink' );
}

{
    $image->putpixel( 1, 0, 'i', 199 );    # white text on green, w/ blink
    my $pixel = $image->getpixel( 1, 0 );
    isa_ok( $pixel, Image::TextMode::Pixel );
    is( $pixel->char,  'i', 'char' );
    is( $pixel->attr,  199, 'attr' );
    is( $pixel->fg,    7,   'fg' );
    is( $pixel->bg,    4,   'bg' );
    is( $pixel->blink, 1,   'blink' );
}

is( $image->as_ascii, "Hi\n", 'as_ascii' );

