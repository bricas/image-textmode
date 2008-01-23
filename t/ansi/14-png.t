use Test::More tests => 7;

use strict;
use warnings;

use_ok( 'Image::ANSI' );
use_ok( 'Image::ANSI::Parser' );

use GD qw( :cmp );

my $parser = Image::ANSI::Parser->new;
isa_ok( $parser, 'Image::ANSI::Parser' );

{
    my $ansi = $parser->parse( file => 't/data/test1.ans' );
    isa_ok( $ansi, 'Image::ANSI' );

    my $expected = GD::Image->new( 't/data/test1.png' );
    my $generated = GD::Image->new( $ansi->as_png( mode => 'full' ) );
    ok( !( $expected->compare( $generated ) & GD_CMP_IMAGE ) );
}

{
    my $ansi = $parser->parse( file => 't/data/test1.ans' );
    isa_ok( $ansi, 'Image::ANSI' );

    my $expected  = GD::Image->new( 't/data/test1thumbnail.png' );
    my $generated = GD::Image->new( $ansi->as_png );
    ok( !( $expected->compare( $generated ) & GD_CMP_IMAGE ) );
}
