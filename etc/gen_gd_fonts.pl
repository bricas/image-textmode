#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Image::TextMode::Renderer::GD;
use Module::Pluggable search_path => 'Image::TextMode::Font', instantiate => 'new';

for my $font ( plugins() ) {
    my $name = lc( ( split( /\::/s, ref $font ) )[ -1 ] );
    for my $opt ( '', '_9b' ) {
        open( my $fh, '>', "$FindBin::Bin/../share/${name}${opt}.fnt" );
        Image::TextMode::Renderer::GD::_save_gd_font( $font, { '9th_bit' => !!length( $opt ) }, $fh );
        close( $fh );
    }
}
