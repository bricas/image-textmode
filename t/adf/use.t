use strict;
use warnings;

use Test::More tests => 2;

use_ok( 'Image::TextMode::Format::ADF' );
is_deeply( [ sort Image::TextMode::Format::ADF->extensions ],
    [ 'adf' ], 'extensions' );
