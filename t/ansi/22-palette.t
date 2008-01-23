use Test::More tests => 14;

use strict;
use warnings;

use_ok( 'Image::ANSI::Palette' );
use_ok( 'Image::ANSI::Palette::VGA' );

{
    my $palette = Image::ANSI::Palette->new;
    isa_ok( $palette, 'Image::ANSI::Palette' );

    is( scalar @{ $palette->colors }, 0 );

    $palette->set( 0, [ 255, 255, 255 ] );
    is_deeply( $palette->get( 0 ), [ 255, 255, 255 ] );
    is( scalar @{ $palette->colors }, 1 );

    $palette->clear;
    is( scalar @{ $palette->colors }, 0 );

    $palette->colors( [ [ 1, 1, 1 ] ] );
    is( scalar @{ $palette->colors }, 1 );
}

{
    my $palette = Image::ANSI::Palette::VGA->new;
    isa_ok( $palette, 'Image::ANSI::Palette::VGA' );
    isa_ok( $palette, 'Image::ANSI::Palette' );

    is( scalar @{ $palette->colors }, 16 );
    is_deeply( $palette->get( 0 ), [ 0, 0, 0 ] );

    $palette->set( 0, [ 255, 255, 255 ] );
    is_deeply( $palette->get( 0 ), [ 255, 255, 255 ] );

    $palette->clear;
    is( scalar @{ $palette->colors }, 0 );
}
