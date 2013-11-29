package Image::TextMode::Font::Atari;

use Moose;

extends 'Image::TextMode::Font';

has '+width' => ( default => 8 );

has '+height' => ( default => 8 );

has '+chars' => (
    default => sub {
        [   [ 0x00, 0x36, 0x7f, 0x7f, 0x3e, 0x1c, 0x08, 0x00 ],
            [ 0x18, 0x18, 0x18, 0x1f, 0x1f, 0x18, 0x18, 0x18 ],
            [ 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03 ],
            [ 0x18, 0x18, 0x18, 0xf8, 0xf8, 0x00, 0x00, 0x00 ],
            [ 0x18, 0x18, 0x18, 0xf8, 0xf8, 0x18, 0x18, 0x18 ],
            [ 0x00, 0x00, 0x00, 0xf8, 0xf8, 0x18, 0x18, 0x18 ],
            [ 0x03, 0x07, 0x0e, 0x1c, 0x38, 0x70, 0xe0, 0xc0 ],
            [ 0xc0, 0xe0, 0x70, 0x38, 0x1c, 0x0e, 0x07, 0x03 ],
            [ 0x01, 0x03, 0x07, 0x0f, 0x1f, 0x3f, 0x7f, 0xff ],
            [ 0x00, 0x00, 0x00, 0x00, 0x0f, 0x0f, 0x0f, 0x0f ],
            [ 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff ],
            [ 0x0f, 0x0f, 0x0f, 0x0f, 0x00, 0x00, 0x00, 0x00 ],
            [ 0xf0, 0xf0, 0xf0, 0xf0, 0x00, 0x00, 0x00, 0x00 ],
            [ 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff ],
            [ 0x00, 0x00, 0x00, 0x00, 0xf0, 0xf0, 0xf0, 0xf0 ],
            [ 0x00, 0x1c, 0x1c, 0x77, 0x77, 0x08, 0x1c, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x1f, 0x1f, 0x18, 0x18, 0x18 ],
            [ 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00 ],
            [ 0x18, 0x18, 0x18, 0xff, 0xff, 0x18, 0x18, 0x18 ],
            [ 0x00, 0x00, 0x3c, 0x7e, 0x7e, 0x7e, 0x3c, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff ],
            [ 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0 ],
            [ 0x00, 0x00, 0x00, 0xff, 0xff, 0x18, 0x18, 0x18 ],
            [ 0x18, 0x18, 0x18, 0xff, 0xff, 0x00, 0x00, 0x00 ],
            [ 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0 ],
            [ 0x18, 0x18, 0x18, 0x1f, 0x1f, 0x00, 0x00, 0x00 ],
            [ 0x78, 0x60, 0x78, 0x60, 0x7e, 0x18, 0x1e, 0x00 ],
            [ 0x00, 0x18, 0x3c, 0x7e, 0x18, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x18, 0x18, 0x18, 0x7e, 0x3c, 0x18, 0x00 ],
            [ 0x00, 0x18, 0x30, 0x7e, 0x30, 0x18, 0x00, 0x00 ],
            [ 0x00, 0x18, 0x0c, 0x7e, 0x0c, 0x18, 0x00, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x18, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x66, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x66, 0xff, 0x66, 0x66, 0xff, 0x66, 0x00 ],
            [ 0x18, 0x3e, 0x60, 0x3c, 0x06, 0x7c, 0x18, 0x00 ],
            [ 0x00, 0x66, 0x6c, 0x18, 0x30, 0x66, 0x46, 0x00 ],
            [ 0x1c, 0x36, 0x1c, 0x38, 0x6f, 0x66, 0x3b, 0x00 ],
            [ 0x00, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x0e, 0x1c, 0x18, 0x18, 0x1c, 0x0e, 0x00 ],
            [ 0x00, 0x70, 0x38, 0x18, 0x18, 0x38, 0x70, 0x00 ],
            [ 0x00, 0x66, 0x3c, 0xff, 0x3c, 0x66, 0x00, 0x00 ],
            [ 0x00, 0x18, 0x18, 0x7e, 0x18, 0x18, 0x00, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x30 ],
            [ 0x00, 0x00, 0x00, 0x7e, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x06, 0x0c, 0x18, 0x30, 0x60, 0x40, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x6e, 0x76, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x18, 0x38, 0x18, 0x18, 0x18, 0x7e, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x0c, 0x18, 0x30, 0x7e, 0x00 ],
            [ 0x00, 0x7e, 0x0c, 0x18, 0x0c, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x0c, 0x1c, 0x3c, 0x6c, 0x7e, 0x0c, 0x00 ],
            [ 0x00, 0x7e, 0x60, 0x7c, 0x06, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x3c, 0x60, 0x7c, 0x66, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x7e, 0x06, 0x0c, 0x18, 0x30, 0x30, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x3c, 0x66, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x3e, 0x06, 0x0c, 0x38, 0x00 ],
            [ 0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x30 ],
            [ 0x06, 0x0c, 0x18, 0x30, 0x18, 0x0c, 0x06, 0x00 ],
            [ 0x00, 0x00, 0x7e, 0x00, 0x00, 0x7e, 0x00, 0x00 ],
            [ 0x60, 0x30, 0x18, 0x0c, 0x18, 0x30, 0x60, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x0c, 0x18, 0x00, 0x18, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x6e, 0x6e, 0x60, 0x3e, 0x00 ],
            [ 0x00, 0x18, 0x3c, 0x66, 0x66, 0x7e, 0x66, 0x00 ],
            [ 0x00, 0x7c, 0x66, 0x7c, 0x66, 0x66, 0x7c, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x60, 0x60, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x78, 0x6c, 0x66, 0x66, 0x6c, 0x78, 0x00 ],
            [ 0x00, 0x7e, 0x60, 0x7c, 0x60, 0x60, 0x7e, 0x00 ],
            [ 0x00, 0x7e, 0x60, 0x7c, 0x60, 0x60, 0x60, 0x00 ],
            [ 0x00, 0x3e, 0x60, 0x60, 0x6e, 0x66, 0x3e, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x7e, 0x66, 0x66, 0x66, 0x00 ],
            [ 0x00, 0x7e, 0x18, 0x18, 0x18, 0x18, 0x7e, 0x00 ],
            [ 0x00, 0x06, 0x06, 0x06, 0x06, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x66, 0x6c, 0x78, 0x78, 0x6c, 0x66, 0x00 ],
            [ 0x00, 0x60, 0x60, 0x60, 0x60, 0x60, 0x7e, 0x00 ],
            [ 0x00, 0x63, 0x77, 0x7f, 0x6b, 0x63, 0x63, 0x00 ],
            [ 0x00, 0x66, 0x76, 0x7e, 0x7e, 0x6e, 0x66, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x66, 0x66, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x7c, 0x66, 0x66, 0x7c, 0x60, 0x60, 0x00 ],
            [ 0x00, 0x3c, 0x66, 0x66, 0x66, 0x6c, 0x36, 0x00 ],
            [ 0x00, 0x7c, 0x66, 0x66, 0x7c, 0x6c, 0x66, 0x00 ],
            [ 0x00, 0x3c, 0x60, 0x3c, 0x06, 0x06, 0x3c, 0x00 ],
            [ 0x00, 0x7e, 0x18, 0x18, 0x18, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x66, 0x66, 0x66, 0x7e, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x66, 0x66, 0x3c, 0x18, 0x00 ],
            [ 0x00, 0x63, 0x63, 0x6b, 0x7f, 0x77, 0x63, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x3c, 0x3c, 0x66, 0x66, 0x00 ],
            [ 0x00, 0x66, 0x66, 0x3c, 0x18, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x7e, 0x0c, 0x18, 0x30, 0x60, 0x7e, 0x00 ],
            [ 0x00, 0x1e, 0x18, 0x18, 0x18, 0x18, 0x1e, 0x00 ],
            [ 0x00, 0x40, 0x60, 0x30, 0x18, 0x0c, 0x06, 0x00 ],
            [ 0x00, 0x78, 0x18, 0x18, 0x18, 0x18, 0x78, 0x00 ],
            [ 0x00, 0x08, 0x1c, 0x36, 0x63, 0x00, 0x00, 0x00 ],
            [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00 ],
            [ 0x00, 0x18, 0x3c, 0x7e, 0x7e, 0x3c, 0x18, 0x00 ],
            [ 0x00, 0x00, 0x3c, 0x06, 0x3e, 0x66, 0x3e, 0x00 ],
            [ 0x00, 0x60, 0x60, 0x7c, 0x66, 0x66, 0x7c, 0x00 ],
            [ 0x00, 0x00, 0x3c, 0x60, 0x60, 0x60, 0x3c, 0x00 ],
            [ 0x00, 0x06, 0x06, 0x3e, 0x66, 0x66, 0x3e, 0x00 ],
            [ 0x00, 0x00, 0x3c, 0x66, 0x7e, 0x60, 0x3c, 0x00 ],
            [ 0x00, 0x0e, 0x18, 0x3e, 0x18, 0x18, 0x18, 0x00 ],
            [ 0x00, 0x00, 0x3e, 0x66, 0x66, 0x3e, 0x06, 0x7c ],
            [ 0x00, 0x60, 0x60, 0x7c, 0x66, 0x66, 0x66, 0x00 ],
            [ 0x00, 0x18, 0x00, 0x38, 0x18, 0x18, 0x3c, 0x00 ],
            [ 0x00, 0x06, 0x00, 0x06, 0x06, 0x06, 0x06, 0x3c ],
            [ 0x00, 0x60, 0x60, 0x6c, 0x78, 0x6c, 0x66, 0x00 ],
            [ 0x00, 0x38, 0x18, 0x18, 0x18, 0x18, 0x3c, 0x00 ],
            [ 0x00, 0x00, 0x66, 0x7f, 0x7f, 0x6b, 0x63, 0x00 ],
            [ 0x00, 0x00, 0x7c, 0x66, 0x66, 0x66, 0x66, 0x00 ],
            [ 0x00, 0x00, 0x3c, 0x66, 0x66, 0x66, 0x3c, 0x00 ],
            [ 0x00, 0x00, 0x7c, 0x66, 0x66, 0x7c, 0x60, 0x60 ],
            [ 0x00, 0x00, 0x3e, 0x66, 0x66, 0x3e, 0x06, 0x06 ],
            [ 0x00, 0x00, 0x7c, 0x66, 0x60, 0x60, 0x60, 0x00 ],
            [ 0x00, 0x00, 0x3e, 0x60, 0x3c, 0x06, 0x7c, 0x00 ],
            [ 0x00, 0x18, 0x7e, 0x18, 0x18, 0x18, 0x0e, 0x00 ],
            [ 0x00, 0x00, 0x66, 0x66, 0x66, 0x66, 0x3e, 0x00 ],
            [ 0x00, 0x00, 0x66, 0x66, 0x66, 0x3c, 0x18, 0x00 ],
            [ 0x00, 0x00, 0x63, 0x6b, 0x7f, 0x3e, 0x36, 0x00 ],
            [ 0x00, 0x00, 0x66, 0x3c, 0x18, 0x3c, 0x66, 0x00 ],
            [ 0x00, 0x00, 0x66, 0x66, 0x66, 0x3e, 0x0c, 0x78 ],
            [ 0x00, 0x00, 0x7e, 0x0c, 0x18, 0x30, 0x7e, 0x00 ],
            [ 0x00, 0x18, 0x3c, 0x7e, 0x7e, 0x18, 0x3c, 0x00 ],
            [ 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18 ],
            [ 0x00, 0x7e, 0x78, 0x7c, 0x6e, 0x66, 0x06, 0x00 ],
            [ 0x08, 0x18, 0x38, 0x78, 0x38, 0x18, 0x08, 0x00 ],
            [ 0x10, 0x18, 0x1c, 0x1e, 0x1c, 0x18, 0x10, 0x00 ],
            [ 0xff, 0xc9, 0x80, 0x80, 0xc1, 0xe3, 0xf7, 0xff ],
            [ 0xe7, 0xe7, 0xe7, 0xe0, 0xe0, 0xe7, 0xe7, 0xe7 ],
            [ 0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc, 0xfc ],
            [ 0xe7, 0xe7, 0xe7, 0x07, 0x07, 0xff, 0xff, 0xff ],
            [ 0xe7, 0xe7, 0xe7, 0x07, 0x07, 0xe7, 0xe7, 0xe7 ],
            [ 0xff, 0xff, 0xff, 0x07, 0x07, 0xe7, 0xe7, 0xe7 ],
            [ 0xfc, 0xf8, 0xf1, 0xe3, 0xc7, 0x8f, 0x1f, 0x3f ],
            [ 0x3f, 0x1f, 0x8f, 0xc7, 0xe3, 0xf1, 0xf8, 0xfc ],
            [ 0xfe, 0xfc, 0xf8, 0xf0, 0xe0, 0xc0, 0x80, 0x00 ],
            [ 0xff, 0xff, 0xff, 0xff, 0xf0, 0xf0, 0xf0, 0xf0 ],
            [ 0x7f, 0x3f, 0x1f, 0x0f, 0x07, 0x03, 0x01, 0x00 ],
            [ 0xf0, 0xf0, 0xf0, 0xf0, 0xff, 0xff, 0xff, 0xff ],
            [ 0x0f, 0x0f, 0x0f, 0x0f, 0xff, 0xff, 0xff, 0xff ],
            [ 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00 ],
            [ 0xff, 0xff, 0xff, 0xff, 0x0f, 0x0f, 0x0f, 0x0f ],
            [ 0xff, 0xe3, 0xe3, 0x88, 0x88, 0xf7, 0xe3, 0xff ],
            [ 0xff, 0xff, 0xff, 0xe0, 0xe0, 0xe7, 0xe7, 0xe7 ],
            [ 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0xff, 0xff ],
            [ 0xe7, 0xe7, 0xe7, 0x00, 0x00, 0xe7, 0xe7, 0xe7 ],
            [ 0xff, 0xff, 0xc3, 0x81, 0x81, 0x81, 0xc3, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00 ],
            [ 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f, 0x3f ],
            [ 0xff, 0xff, 0xff, 0x00, 0x00, 0xe7, 0xe7, 0xe7 ],
            [ 0xe7, 0xe7, 0xe7, 0x00, 0x00, 0xff, 0xff, 0xff ],
            [ 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f ],
            [ 0xe7, 0xe7, 0xe7, 0xe0, 0xe0, 0xff, 0xff, 0xff ],
            [ 0x87, 0x9f, 0x87, 0x9f, 0x81, 0xe7, 0xe1, 0xff ],
            [ 0xff, 0xe7, 0xc3, 0x81, 0xe7, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0xe7, 0xe7, 0xe7, 0x81, 0xc3, 0xe7, 0xff ],
            [ 0xff, 0xe7, 0xcf, 0x81, 0xcf, 0xe7, 0xff, 0xff ],
            [ 0xff, 0xe7, 0xf3, 0x81, 0xf3, 0xe7, 0xff, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff ],
            [ 0xff, 0xe7, 0xe7, 0xe7, 0xe7, 0xff, 0xe7, 0xff ],
            [ 0xff, 0x99, 0x99, 0x99, 0xff, 0xff, 0xff, 0xff ],
            [ 0xff, 0x99, 0x00, 0x99, 0x99, 0x00, 0x99, 0xff ],
            [ 0xe7, 0xc1, 0x9f, 0xc3, 0xf9, 0x83, 0xe7, 0xff ],
            [ 0xff, 0x99, 0x93, 0xe7, 0xcf, 0x99, 0xb9, 0xff ],
            [ 0xe3, 0xc9, 0xe3, 0xc7, 0x90, 0x99, 0xc4, 0xff ],
            [ 0xff, 0xe7, 0xe7, 0xe7, 0xff, 0xff, 0xff, 0xff ],
            [ 0xff, 0xf1, 0xe3, 0xe7, 0xe7, 0xe3, 0xf1, 0xff ],
            [ 0xff, 0x8f, 0xc7, 0xe7, 0xe7, 0xc7, 0x8f, 0xff ],
            [ 0xff, 0x99, 0xc3, 0x00, 0xc3, 0x99, 0xff, 0xff ],
            [ 0xff, 0xe7, 0xe7, 0x81, 0xe7, 0xe7, 0xff, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xe7, 0xe7, 0xcf ],
            [ 0xff, 0xff, 0xff, 0x81, 0xff, 0xff, 0xff, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0xf9, 0xf3, 0xe7, 0xcf, 0x9f, 0xbf, 0xff ],
            [ 0xff, 0xc3, 0x99, 0x91, 0x89, 0x99, 0xc3, 0xff ],
            [ 0xff, 0xe7, 0xc7, 0xe7, 0xe7, 0xe7, 0x81, 0xff ],
            [ 0xff, 0xc3, 0x99, 0xf3, 0xe7, 0xcf, 0x81, 0xff ],
            [ 0xff, 0x81, 0xf3, 0xe7, 0xf3, 0x99, 0xc3, 0xff ],
            [ 0xff, 0xf3, 0xe3, 0xc3, 0x93, 0x81, 0xf3, 0xff ],
            [ 0xff, 0x81, 0x9f, 0x83, 0xf9, 0x99, 0xc3, 0xff ],
            [ 0xff, 0xc3, 0x9f, 0x83, 0x99, 0x99, 0xc3, 0xff ],
            [ 0xff, 0x81, 0xf9, 0xf3, 0xe7, 0xcf, 0xcf, 0xff ],
            [ 0xff, 0xc3, 0x99, 0xc3, 0x99, 0x99, 0xc3, 0xff ],
            [ 0xff, 0xc3, 0x99, 0xc1, 0xf9, 0xf3, 0xc7, 0xff ],
            [ 0xff, 0xff, 0xe7, 0xe7, 0xff, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0xff, 0xe7, 0xe7, 0xff, 0xe7, 0xe7, 0xcf ],
            [ 0xf9, 0xf3, 0xe7, 0xcf, 0xe7, 0xf3, 0xf9, 0xff ],
            [ 0xff, 0xff, 0x81, 0xff, 0xff, 0x81, 0xff, 0xff ],
            [ 0x9f, 0xcf, 0xe7, 0xf3, 0xe7, 0xcf, 0x9f, 0xff ],
            [ 0xff, 0xc3, 0x99, 0xf3, 0xe7, 0xff, 0xe7, 0xff ],
            [ 0xff, 0xc3, 0x99, 0x91, 0x91, 0x9f, 0xc1, 0xff ],
            [ 0xff, 0xe7, 0xc3, 0x99, 0x99, 0x81, 0x99, 0xff ],
            [ 0xff, 0x83, 0x99, 0x83, 0x99, 0x99, 0x83, 0xff ],
            [ 0xff, 0xc3, 0x99, 0x9f, 0x9f, 0x99, 0xc3, 0xff ],
            [ 0xff, 0x87, 0x93, 0x99, 0x99, 0x93, 0x87, 0xff ],
            [ 0xff, 0x81, 0x9f, 0x83, 0x9f, 0x9f, 0x81, 0xff ],
            [ 0xff, 0x81, 0x9f, 0x83, 0x9f, 0x9f, 0x9f, 0xff ],
            [ 0xff, 0xc1, 0x9f, 0x9f, 0x91, 0x99, 0xc1, 0xff ],
            [ 0xff, 0x99, 0x99, 0x81, 0x99, 0x99, 0x99, 0xff ],
            [ 0xff, 0x81, 0xe7, 0xe7, 0xe7, 0xe7, 0x81, 0xff ],
            [ 0xff, 0xf9, 0xf9, 0xf9, 0xf9, 0x99, 0xc3, 0xff ],
            [ 0xff, 0x99, 0x93, 0x87, 0x87, 0x93, 0x99, 0xff ],
            [ 0xff, 0x9f, 0x9f, 0x9f, 0x9f, 0x9f, 0x81, 0xff ],
            [ 0xff, 0x9c, 0x88, 0x80, 0x94, 0x9c, 0x9c, 0xff ],
            [ 0xff, 0x99, 0x89, 0x81, 0x81, 0x91, 0x99, 0xff ],
            [ 0xff, 0xc3, 0x99, 0x99, 0x99, 0x99, 0xc3, 0xff ],
            [ 0xff, 0x83, 0x99, 0x99, 0x83, 0x9f, 0x9f, 0xff ],
            [ 0xff, 0xc3, 0x99, 0x99, 0x99, 0x93, 0xc9, 0xff ],
            [ 0xff, 0x83, 0x99, 0x99, 0x83, 0x93, 0x99, 0xff ],
            [ 0xff, 0xc3, 0x9f, 0xc3, 0xf9, 0xf9, 0xc3, 0xff ],
            [ 0xff, 0x81, 0xe7, 0xe7, 0xe7, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0x99, 0x99, 0x99, 0x99, 0x99, 0x81, 0xff ],
            [ 0xff, 0x99, 0x99, 0x99, 0x99, 0xc3, 0xe7, 0xff ],
            [ 0xff, 0x9c, 0x9c, 0x94, 0x80, 0x88, 0x9c, 0xff ],
            [ 0xff, 0x99, 0x99, 0xc3, 0xc3, 0x99, 0x99, 0xff ],
            [ 0xff, 0x99, 0x99, 0xc3, 0xe7, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0x81, 0xf3, 0xe7, 0xcf, 0x9f, 0x81, 0xff ],
            [ 0xff, 0xe1, 0xe7, 0xe7, 0xe7, 0xe7, 0xe1, 0xff ],
            [ 0xff, 0xbf, 0x9f, 0xcf, 0xe7, 0xf3, 0xf9, 0xff ],
            [ 0xff, 0x87, 0xe7, 0xe7, 0xe7, 0xe7, 0x87, 0xff ],
            [ 0xff, 0xf7, 0xe3, 0xc9, 0x9c, 0xff, 0xff, 0xff ],
            [ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0xff ],
            [ 0xff, 0xe7, 0xc3, 0x81, 0x81, 0xc3, 0xe7, 0xff ],
            [ 0xff, 0xff, 0xc3, 0xf9, 0xc1, 0x99, 0xc1, 0xff ],
            [ 0xff, 0x9f, 0x9f, 0x83, 0x99, 0x99, 0x83, 0xff ],
            [ 0xff, 0xff, 0xc3, 0x9f, 0x9f, 0x9f, 0xc3, 0xff ],
            [ 0xff, 0xf9, 0xf9, 0xc1, 0x99, 0x99, 0xc1, 0xff ],
            [ 0xff, 0xff, 0xc3, 0x99, 0x81, 0x9f, 0xc3, 0xff ],
            [ 0xff, 0xf1, 0xe7, 0xc1, 0xe7, 0xe7, 0xe7, 0xff ],
            [ 0xff, 0xff, 0xc1, 0x99, 0x99, 0xc1, 0xf9, 0x83 ],
            [ 0xff, 0x9f, 0x9f, 0x83, 0x99, 0x99, 0x99, 0xff ],
            [ 0xff, 0xe7, 0xff, 0xc7, 0xe7, 0xe7, 0xc3, 0xff ],
            [ 0xff, 0xf9, 0xff, 0xf9, 0xf9, 0xf9, 0xf9, 0xc3 ],
            [ 0xff, 0x9f, 0x9f, 0x93, 0x87, 0x93, 0x99, 0xff ],
            [ 0xff, 0xc7, 0xe7, 0xe7, 0xe7, 0xe7, 0xc3, 0xff ],
            [ 0xff, 0xff, 0x99, 0x80, 0x80, 0x94, 0x9c, 0xff ],
            [ 0xff, 0xff, 0x83, 0x99, 0x99, 0x99, 0x99, 0xff ],
            [ 0xff, 0xff, 0xc3, 0x99, 0x99, 0x99, 0xc3, 0xff ],
            [ 0xff, 0xff, 0x83, 0x99, 0x99, 0x83, 0x9f, 0x9f ],
            [ 0xff, 0xff, 0xc1, 0x99, 0x99, 0xc1, 0xf9, 0xf9 ],
            [ 0xff, 0xff, 0x83, 0x99, 0x9f, 0x9f, 0x9f, 0xff ],
            [ 0xff, 0xff, 0xc1, 0x9f, 0xc3, 0xf9, 0x83, 0xff ],
            [ 0xff, 0xe7, 0x81, 0xe7, 0xe7, 0xe7, 0xf1, 0xff ],
            [ 0xff, 0xff, 0x99, 0x99, 0x99, 0x99, 0xc1, 0xff ],
            [ 0xff, 0xff, 0x99, 0x99, 0x99, 0xc3, 0xe7, 0xff ],
            [ 0xff, 0xff, 0x9c, 0x94, 0x80, 0xc1, 0xc9, 0xff ],
            [ 0xff, 0xff, 0x99, 0xc3, 0xe7, 0xc3, 0x99, 0xff ],
            [ 0xff, 0xff, 0x99, 0x99, 0x99, 0xc1, 0xf3, 0x87 ],
            [ 0xff, 0xff, 0x81, 0xf3, 0xe7, 0xcf, 0x81, 0xff ],
            [ 0xff, 0xe7, 0xc3, 0x81, 0x81, 0xe7, 0xc3, 0xff ],
            [ 0xe7, 0xe7, 0xe7, 0xe7, 0xe7, 0xe7, 0xe7, 0xe7 ],
            [ 0xff, 0x81, 0x87, 0x83, 0x91, 0x99, 0xf9, 0xff ],
            [ 0xf7, 0xe7, 0xc7, 0x87, 0xc7, 0xe7, 0xf7, 0xff ],
            [ 0xef, 0xe7, 0xe3, 0xe1, 0xe3, 0xe7, 0xef, 0xff ]
        ];
    }
);

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Font::Atari - Atari text mode font for ATASCII

=head1 DESCRIPTION

An Atari style font.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2013 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;