use Test::More tests => 5;

use strict;
use warnings;

use_ok( 'Image::ANSI' );
use_ok( 'Image::ANSI::Parser' );

my $parser = Image::ANSI::Parser->new;
isa_ok( $parser, 'Image::ANSI::Parser' );

{
    my $ansi = $parser->parse( file => 't/data/test1.ans' );
    isa_ok( $ansi, 'Image::ANSI' );

    is( $ansi->as_ascii, "TEST\n" );
}
