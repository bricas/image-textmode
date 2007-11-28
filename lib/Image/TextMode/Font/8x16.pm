package Image::TextMode::Font::8x16;

use strict;
use warnings;

use base qw( Image::TextMode::Font );

__PACKAGE__->width( 8 );
__PACKAGE__->height( 16 );
__PACKAGE__->chars(
    [   [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7e, 0x81, 0xa5, 0x81, 0x81, 0xbd,
            0x99, 0x81, 0x81, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7e, 0xff, 0xdb, 0xff, 0xff, 0xc3,
            0xe7, 0xff, 0xff, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x6c, 0xfe, 0xfe, 0xfe,
            0xfe, 0x7c, 0x38, 0x10, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x10, 0x38, 0x7c, 0xfe,
            0x7c, 0x38, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x18, 0x3c, 0x3c, 0xe7, 0xe7,
            0xe7, 0x99, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x18, 0x3c, 0x7e, 0xff, 0xff,
            0x7e, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x3c,
            0x3c, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xe7, 0xc3,
            0xc3, 0xe7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x3c, 0x66, 0x42,
            0x42, 0x66, 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0xff, 0xff, 0xff, 0xff, 0xff, 0xc3, 0x99, 0xbd,
            0xbd, 0x99, 0xc3, 0xff, 0xff, 0xff, 0xff, 0xff
        ],
        [   0x00, 0x00, 0x1e, 0x0e, 0x1a, 0x32, 0x78, 0xcc,
            0xcc, 0xcc, 0xcc, 0x78, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x66, 0x66, 0x66, 0x66, 0x3c,
            0x18, 0x7e, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3f, 0x33, 0x3f, 0x30, 0x30, 0x30,
            0x30, 0x70, 0xf0, 0xe0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7f, 0x63, 0x7f, 0x63, 0x63, 0x63,
            0x63, 0x67, 0xe7, 0xe6, 0xc0, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x18, 0x18, 0xdb, 0x3c, 0xe7,
            0x3c, 0xdb, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfe, 0xf8,
            0xf0, 0xe0, 0xc0, 0x80, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x02, 0x06, 0x0e, 0x1e, 0x3e, 0xfe, 0x3e,
            0x1e, 0x0e, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x3c, 0x7e, 0x18, 0x18, 0x18,
            0x18, 0x7e, 0x3c, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
            0x66, 0x00, 0x66, 0x66, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7f, 0xdb, 0xdb, 0xdb, 0x7b, 0x1b,
            0x1b, 0x1b, 0x1b, 0x1b, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x7c, 0xc6, 0x60, 0x38, 0x6c, 0xc6, 0xc6,
            0x6c, 0x38, 0x0c, 0xc6, 0x7c, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0xfe, 0xfe, 0xfe, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x3c, 0x7e, 0x18, 0x18, 0x18,
            0x18, 0x7e, 0x3c, 0x18, 0x7e, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x3c, 0x7e, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
            0x18, 0x7e, 0x3c, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x0c, 0xfe,
            0x0c, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x60, 0xfe,
            0x60, 0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xc0, 0xc0,
            0xc0, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x6c, 0xfe,
            0x6c, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x10, 0x38, 0x38, 0x7c,
            0x7c, 0xfe, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0xfe, 0xfe, 0x7c, 0x7c,
            0x38, 0x38, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x3c, 0x3c, 0x3c, 0x18, 0x18,
            0x18, 0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x66, 0x66, 0x66, 0x24, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x6c, 0x6c, 0xfe, 0x6c, 0x6c,
            0x6c, 0xfe, 0x6c, 0x6c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x18, 0x7c, 0xc6, 0xc2, 0xc0, 0x7c, 0x06,
            0x86, 0xc6, 0x7c, 0x18, 0x18, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0xc2, 0xc6, 0x0c, 0x18,
            0x30, 0x60, 0xc6, 0x86, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x6c, 0x6c, 0x38, 0x76, 0xdc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x30, 0x30, 0x30, 0x60, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x0c, 0x18, 0x30, 0x30, 0x30, 0x30,
            0x30, 0x30, 0x18, 0x0c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x30, 0x18, 0x0c, 0x0c, 0x0c, 0x0c,
            0x0c, 0x0c, 0x18, 0x30, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x3c, 0xff,
            0x3c, 0x66, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x7e,
            0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x18, 0x18, 0x18, 0x30, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x02, 0x06, 0x0c, 0x18,
            0x30, 0x60, 0xc0, 0x80, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xce, 0xd6, 0xd6,
            0xe6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x38, 0x78, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0x06, 0x0c, 0x18, 0x30,
            0x60, 0xc0, 0xc6, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0x06, 0x06, 0x3c, 0x06,
            0x06, 0x06, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x0c, 0x1c, 0x3c, 0x6c, 0xcc, 0xfe,
            0x0c, 0x0c, 0x0c, 0x1e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0xc0, 0xc0, 0xc0, 0xfc, 0x0e,
            0x06, 0x06, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x60, 0xc0, 0xc0, 0xfc, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0xc6, 0x06, 0x06, 0x0c, 0x18,
            0x30, 0x30, 0x30, 0x30, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xc6, 0x7c, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xc6, 0x7e, 0x06,
            0x06, 0x06, 0x0c, 0x78, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00,
            0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x00,
            0x00, 0x18, 0x18, 0x30, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x06, 0x0c, 0x18, 0x30, 0x60,
            0x30, 0x18, 0x0c, 0x06, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0x00,
            0x00, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x60, 0x30, 0x18, 0x0c, 0x06,
            0x0c, 0x18, 0x30, 0x60, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0x0c, 0x18, 0x18,
            0x18, 0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xde, 0xde,
            0xde, 0xdc, 0xc0, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x10, 0x38, 0x6c, 0xc6, 0xc6, 0xfe,
            0xc6, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfc, 0x66, 0x66, 0x66, 0x7c, 0x66,
            0x66, 0x66, 0x66, 0xfc, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x66, 0xc2, 0xc0, 0xc0, 0xc0,
            0xc0, 0xc2, 0x66, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xf8, 0x6c, 0x66, 0x66, 0x66, 0x66,
            0x66, 0x66, 0x6c, 0xf8, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0x66, 0x62, 0x68, 0x78, 0x68,
            0x60, 0x62, 0x66, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0x66, 0x62, 0x68, 0x78, 0x68,
            0x60, 0x60, 0x60, 0xf0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x66, 0xc2, 0xc0, 0xc0, 0xde,
            0xc6, 0xc6, 0x66, 0x3a, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0xc6, 0xc6, 0xfe, 0xc6,
            0xc6, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x18, 0x18, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x1e, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
            0xcc, 0xcc, 0xcc, 0x78, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xe6, 0x66, 0x6c, 0x6c, 0x78, 0x78,
            0x6c, 0x66, 0x66, 0xe6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xf0, 0x60, 0x60, 0x60, 0x60, 0x60,
            0x60, 0x62, 0x66, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xee, 0xfe, 0xfe, 0xd6, 0xc6,
            0xc6, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xe6, 0xf6, 0xfe, 0xde, 0xce,
            0xc6, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x6c, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0x6c, 0x38, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfc, 0x66, 0x66, 0x66, 0x7c, 0x60,
            0x60, 0x60, 0x60, 0xf0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0xd6, 0xde, 0x7c, 0x0c, 0x0e, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfc, 0x66, 0x66, 0x66, 0x7c, 0x6c,
            0x66, 0x66, 0x66, 0xe6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7c, 0xc6, 0xc6, 0x60, 0x38, 0x0c,
            0x06, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x7e, 0x7e, 0x5a, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0x6c, 0x38, 0x10, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0xc6, 0xc6, 0xc6, 0xd6,
            0xd6, 0xfe, 0x6c, 0x6c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0x6c, 0x6c, 0x38, 0x38,
            0x6c, 0x6c, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x66, 0x66, 0x66, 0x66, 0x3c, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0xc6, 0x86, 0x0c, 0x18, 0x30,
            0x60, 0xc2, 0xc6, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x30, 0x30, 0x30, 0x30, 0x30,
            0x30, 0x30, 0x30, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x80, 0xc0, 0xe0, 0x70, 0x38,
            0x1c, 0x0e, 0x06, 0x02, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c,
            0x0c, 0x0c, 0x0c, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x10, 0x38, 0x6c, 0xc6, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00
        ],
        [   0x30, 0x30, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xe0, 0x60, 0x60, 0x78, 0x6c, 0x66,
            0x66, 0x66, 0x66, 0xdc, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7c, 0xc6, 0xc0,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x1c, 0x0c, 0x0c, 0x3c, 0x6c, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7c, 0xc6, 0xfe,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x6c, 0x64, 0x60, 0xf0, 0x60,
            0x60, 0x60, 0x60, 0xf0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x7c, 0x0c, 0xcc, 0x78, 0x00
        ],
        [   0x00, 0x00, 0xe0, 0x60, 0x60, 0x6c, 0x76, 0x66,
            0x66, 0x66, 0x66, 0xe6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x18, 0x00, 0x38, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x06, 0x06, 0x00, 0x0e, 0x06, 0x06,
            0x06, 0x06, 0x06, 0x06, 0x66, 0x66, 0x3c, 0x00
        ],
        [   0x00, 0x00, 0xe0, 0x60, 0x60, 0x66, 0x6c, 0x78,
            0x78, 0x6c, 0x66, 0xe6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x18, 0x18, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xec, 0xfe, 0xd6,
            0xd6, 0xd6, 0xd6, 0xd6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xdc, 0x66, 0x66,
            0x66, 0x66, 0x66, 0x66, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7c, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xdc, 0x66, 0x66,
            0x66, 0x66, 0x66, 0x7c, 0x60, 0x60, 0xf0, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x7c, 0x0c, 0x0c, 0x1e, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xdc, 0x76, 0x62,
            0x60, 0x60, 0x60, 0xf0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7c, 0xc6, 0x60,
            0x38, 0x0c, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x10, 0x30, 0x30, 0xfc, 0x30, 0x30,
            0x30, 0x30, 0x36, 0x1c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x66,
            0x66, 0x66, 0x3c, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0xc6, 0xc6,
            0xd6, 0xd6, 0xfe, 0x6c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0x6c, 0x38,
            0x38, 0x38, 0x6c, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0xf8, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0xcc, 0x18,
            0x30, 0x60, 0xc6, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x0e, 0x18, 0x18, 0x18, 0x70, 0x18,
            0x18, 0x18, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x18, 0x18, 0x18, 0x00, 0x18,
            0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x70, 0x18, 0x18, 0x18, 0x0e, 0x18,
            0x18, 0x18, 0x18, 0x70, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x76, 0xdc, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x10, 0x38, 0x6c, 0xc6,
            0xc6, 0xc6, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3c, 0x66, 0xc2, 0xc0, 0xc0, 0xc0,
            0xc2, 0x66, 0x3c, 0x0c, 0x06, 0x7c, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xcc, 0xcc, 0x00, 0xcc, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x0c, 0x18, 0x30, 0x00, 0x7c, 0xc6, 0xfe,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x10, 0x38, 0x6c, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xcc, 0xcc, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x60, 0x30, 0x18, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x38, 0x6c, 0x38, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x3c, 0x66, 0x60, 0x60,
            0x66, 0x3c, 0x0c, 0x06, 0x3c, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x10, 0x38, 0x6c, 0x00, 0x7c, 0xc6, 0xfe,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0x00, 0x7c, 0xc6, 0xfe,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x60, 0x30, 0x18, 0x00, 0x7c, 0xc6, 0xfe,
            0xc0, 0xc0, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x66, 0x66, 0x00, 0x38, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x18, 0x3c, 0x66, 0x00, 0x38, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x60, 0x30, 0x18, 0x00, 0x38, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0xc6, 0xc6, 0x10, 0x38, 0x6c, 0xc6, 0xc6,
            0xfe, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x38, 0x6c, 0x38, 0x00, 0x38, 0x6c, 0xc6, 0xc6,
            0xfe, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x30, 0x60, 0x00, 0xfe, 0x66, 0x60, 0x7c,
            0x60, 0x60, 0x66, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0x76, 0x36,
            0x7e, 0xd8, 0xd8, 0x6e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x3e, 0x6c, 0xcc, 0xcc, 0xfe, 0xcc,
            0xcc, 0xcc, 0xcc, 0xce, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x10, 0x38, 0x6c, 0x00, 0x7c, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0x00, 0x7c, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x60, 0x30, 0x18, 0x00, 0x7c, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x30, 0x78, 0xcc, 0x00, 0xcc, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x60, 0x30, 0x18, 0x00, 0xcc, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xc6, 0xc6, 0x00, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7e, 0x06, 0x0c, 0x78, 0x00
        ],
        [   0x00, 0xc6, 0xc6, 0x00, 0x38, 0x6c, 0xc6, 0xc6,
            0xc6, 0xc6, 0x6c, 0x38, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0xc6, 0xc6, 0x00, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x18, 0x18, 0x3c, 0x66, 0x60, 0x60, 0x60,
            0x66, 0x3c, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x38, 0x6c, 0x64, 0x60, 0xf0, 0x60, 0x60,
            0x60, 0x60, 0xe6, 0xfc, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x66, 0x66, 0x3c, 0x18, 0x7e, 0x18,
            0x7e, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0xf8, 0xcc, 0xcc, 0xf8, 0xc4, 0xcc, 0xde,
            0xcc, 0xcc, 0xcc, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x0e, 0x1b, 0x18, 0x18, 0x18, 0x7e, 0x18,
            0x18, 0x18, 0x18, 0x18, 0xd8, 0x70, 0x00, 0x00
        ],
        [   0x00, 0x18, 0x30, 0x60, 0x00, 0x78, 0x0c, 0x7c,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x0c, 0x18, 0x30, 0x00, 0x38, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x18, 0x30, 0x60, 0x00, 0x7c, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x18, 0x30, 0x60, 0x00, 0xcc, 0xcc, 0xcc,
            0xcc, 0xcc, 0xcc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x76, 0xdc, 0x00, 0xdc, 0x66, 0x66,
            0x66, 0x66, 0x66, 0x66, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x76, 0xdc, 0x00, 0xc6, 0xe6, 0xf6, 0xfe, 0xde,
            0xce, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x3c, 0x6c, 0x6c, 0x3e, 0x00, 0x7e, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x38, 0x6c, 0x6c, 0x38, 0x00, 0x7c, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x30, 0x30, 0x00, 0x30, 0x30, 0x60,
            0xc0, 0xc6, 0xc6, 0x7c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0xc0,
            0xc0, 0xc0, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0x06,
            0x06, 0x06, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0xc0, 0xc0, 0xc2, 0xc6, 0xcc, 0x18, 0x30,
            0x60, 0xce, 0x93, 0x06, 0x0c, 0x1f, 0x00, 0x00
        ],
        [   0x00, 0xc0, 0xc0, 0xc2, 0xc6, 0xcc, 0x18, 0x30,
            0x66, 0xce, 0x9a, 0x3f, 0x06, 0x0f, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x18,
            0x3c, 0x3c, 0x3c, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x33, 0x66, 0xcc,
            0x66, 0x33, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xcc, 0x66, 0x33,
            0x66, 0xcc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x11, 0x44, 0x11, 0x44, 0x11, 0x44, 0x11, 0x44,
            0x11, 0x44, 0x11, 0x44, 0x11, 0x44, 0x11, 0x44
        ],
        [   0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa,
            0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa
        ],
        [   0xdd, 0x77, 0xdd, 0x77, 0xdd, 0x77, 0xdd, 0x77,
            0xdd, 0x77, 0xdd, 0x77, 0xdd, 0x77, 0xdd, 0x77
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0xf8,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0xf8, 0x18, 0xf8,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0xf6,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0x18, 0xf8,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0xf6, 0x06, 0xf6,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0x06, 0xf6,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0xf6, 0x06, 0xfe,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0xfe,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0xf8, 0x18, 0xf8,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf8,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x1f,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x1f,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0xff,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x1f, 0x18, 0x1f,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x37,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x37, 0x30, 0x3f,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x30, 0x37,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0xf7, 0x00, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0xf7,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x37, 0x30, 0x37,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0xf7, 0x00, 0xf7,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0xff, 0x00, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0xff,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0xff,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x3f,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x1f, 0x18, 0x1f,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0x18, 0x1f,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3f,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0xff,
            0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36, 0x36
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0xff, 0x18, 0xff,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0xf8,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1f,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
            0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff,
            0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
        ],
        [   0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0,
            0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0, 0xf0
        ],
        [   0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
            0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f
        ],
        [   0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xdc, 0xd8,
            0xd8, 0xd8, 0xdc, 0x76, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0xfc, 0xc6, 0xfc,
            0xc6, 0xc6, 0xfc, 0xc0, 0xc0, 0xc0, 0x00, 0x00
        ],
        [   0x00, 0x00, 0xfe, 0xc6, 0xc6, 0xc0, 0xc0, 0xc0,
            0xc0, 0xc0, 0xc0, 0xc0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x80, 0xfe, 0x6c, 0x6c,
            0x6c, 0x6c, 0x6c, 0x6c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0xfe, 0xc6, 0x60, 0x30, 0x18,
            0x30, 0x60, 0xc6, 0xfe, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7e, 0xd8, 0xd8,
            0xd8, 0xd8, 0xd8, 0x70, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x66, 0x66, 0x66, 0x66,
            0x66, 0x7c, 0x60, 0x60, 0xc0, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x76, 0xdc, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x7e, 0x18, 0x3c, 0x66, 0x66,
            0x66, 0x3c, 0x18, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x38, 0x6c, 0xc6, 0xc6, 0xfe,
            0xc6, 0xc6, 0x6c, 0x38, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x38, 0x6c, 0xc6, 0xc6, 0xc6, 0x6c,
            0x6c, 0x6c, 0x6c, 0xee, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x1e, 0x30, 0x18, 0x0c, 0x3e, 0x66,
            0x66, 0x66, 0x66, 0x3c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x7e, 0xdb, 0xdb,
            0xdb, 0x7e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x03, 0x06, 0x7e, 0xcf, 0xdb,
            0xf3, 0x7e, 0x60, 0xc0, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x1c, 0x30, 0x60, 0x60, 0x7c, 0x60,
            0x60, 0x60, 0x30, 0x1c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x7c, 0xc6, 0xc6, 0xc6, 0xc6,
            0xc6, 0xc6, 0xc6, 0xc6, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0xfe, 0x00, 0x00, 0xfe,
            0x00, 0x00, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x7e, 0x18,
            0x18, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x30, 0x18, 0x0c, 0x06, 0x0c,
            0x18, 0x30, 0x00, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x0c, 0x18, 0x30, 0x60, 0x30,
            0x18, 0x0c, 0x00, 0x7e, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x0e, 0x1b, 0x1b, 0x18, 0x18, 0x18,
            0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
        ],
        [   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
            0xd8, 0xd8, 0xd8, 0x70, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x18, 0x18, 0x00, 0x7e,
            0x00, 0x18, 0x18, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0xdc, 0x00,
            0x76, 0xdc, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x38, 0x6c, 0x6c, 0x38, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18,
            0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x18, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x0f, 0x0c, 0x0c, 0x0c, 0x0c, 0x0c, 0xec,
            0x6c, 0x6c, 0x3c, 0x1c, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0xd8, 0x6c, 0x6c, 0x6c, 0x6c, 0x6c, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x70, 0x98, 0x30, 0x60, 0xc8, 0xf8, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x7c, 0x7c, 0x7c, 0x7c,
            0x7c, 0x7c, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
        [   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ],
    ]
);
__PACKAGE__->intensity_map(
    [   0,  50, 83, 49,  16, 33,  32, 0,   136, 0,  119, 18,
        32, 18, 35, 33,  99, 16,  16, 33,  48,  66, 4,   17,
        16, 0,  16, 16,  33, 16,  18, 48,  0,   16, 16,  34,
        50, 17, 34, 0,   0,  0,   16, 0,   0,   16, 0,   1,
        67, 16, 19, 17,  32, 65,  66, 32,  66,  48, 0,   0,
        0,  17, 0,  32,  51, 51,  50, 50,  50,  50, 50,  50,
        83, 0,  2,  50,  34, 83,  83, 50,  50,  67, 50,  34,
        16, 66, 65, 66,  34, 32,  35, 16,  32,  0,  16,  1,
        0,  18, 50, 34,  18, 34,  34, 36,  50,  0,  1,   50,
        0,  35, 17, 34,  19, 35,  18, 17,  16,  34, 17,  35,
        17, 36, 18, 0,   0,  0,   16, 18,  50,  66, 34,  18,
        34, 18, 18, 16,  50, 50,  50, 16,  16,  16, 51,  51,
        50, 18, 67, 34,  50, 34,  66, 50,  67,  50, 66,  32,
        50, 16, 99, 17,  18, 0,   34, 50,  49,  99, 16,  16,
        18, 18, 16, 66,  66, 0,   16, 17,  17,  68, 85,  0,
        16, 32, 33, 17,  32, 49,  17, 33,  48,  32, 32,  16,
        0,  16, 16, 0,   16, 16,  0,  17,  16,  1,  48,  33,
        17, 32, 49, 32,  32, 32,  17, 16,  0,   0,  1,   33,
        32, 16, 0,  136, 24, 119, 0,  112, 35,  37, 83,  33,
        34, 35, 18, 16,  17, 50,  50, 17,  33,  34, 17,  51,
        33, 1,  0,  0,   0,  3,   0,  17,  16,  0,  0,   17,
        48, 48, 33, 0
    ]
);

=head1 NAME

Image::TextMode::Font::8x16 - 8 x 16 text mode font

=head1 DESCRIPTION

The default 8x16 font.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
