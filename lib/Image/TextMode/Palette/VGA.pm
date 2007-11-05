package Image::TextMode::Palette::VGA;

use strict;
use warnings;

use base qw( Image::TextMode::Palette );

__PACKAGE__->mk_classaccessor(
    colors => [
        [ 0x00, 0x00, 0x00 ],    # black
        [ 0xaa, 0x00, 0x00 ],    # red
        [ 0x00, 0xaa, 0x00 ],    # green
        [ 0xaa, 0x55, 0x00 ],    # yellow
        [ 0x00, 0x00, 0xaa ],    # blue
        [ 0xaa, 0x00, 0xaa ],    # magenta
        [ 0x00, 0xaa, 0xaa ],    # cyan
        [ 0xaa, 0xaa, 0xaa ],    # white
                                 # bright
        [ 0x55, 0x55, 0x55 ],    # black
        [ 0xfe, 0x55, 0x55 ],    # red
        [ 0x55, 0xfe, 0x55 ],    # green
        [ 0xfe, 0xfe, 0x55 ],    # yellow
        [ 0x55, 0x55, 0xfe ],    # blue
        [ 0xfe, 0x55, 0xfe ],    # magenta
        [ 0x55, 0xfe, 0xfe ],    # cyan
    ]
);

1;
