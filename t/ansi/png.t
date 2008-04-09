use Test::More tests => 5;

use strict;
use warnings;

use_ok( 'Image::TextMode::ANSI' );

use GD qw( :cmp );

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/test1.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    my $expected = GD::Image->new( 't/ansi/data/test1.png' );
    my $generated = GD::Image->new( $ansi->as_bitmap_full );
    ok( !( $expected->compare( $generated ) & GD_CMP_IMAGE ), 'full-size png output' );
}

{
    my $ansi = Image::TextMode::ANSI->read( { file => 't/ansi/data/test1.ans' } );
    isa_ok( $ansi, 'Image::TextMode::ANSI' );

    my $expected  = GD::Image->new( 't/ansi/data/test1thumbnail.png' );
    my $generated = GD::Image->new( $ansi->as_bitmap_thumbnail );
    ok( !( $expected->compare( $generated ) & GD_CMP_IMAGE ), 'thumbnail-size png output' );
}
