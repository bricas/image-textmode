use Test::More tests => 3;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/test1.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );
    is( $ansi->as_ascii, "TEST\n" );
}
