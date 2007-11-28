package Image::TextMode::Palette::VGA;

use strict;
use warnings;

use base qw( Image::TextMode::Palette );

__PACKAGE__->colors(
    [   [ 0x00, 0x00, 0x00 ],
        [ 0x00, 0x00, 0xa8 ],
        [ 0x00, 0xa8, 0x00 ],
        [ 0x00, 0xa8, 0xa8 ],
        [ 0xa8, 0x00, 0x00 ],
        [ 0xa8, 0x00, 0xa8 ],
        [ 0xa8, 0x54, 0x00 ],
        [ 0xa8, 0xa8, 0xa8 ],
        [ 0x54, 0x54, 0x54 ],
        [ 0x54, 0x54, 0xfc ],
        [ 0x54, 0xfc, 0x54 ],
        [ 0x54, 0xfc, 0xfc ],
        [ 0xfc, 0x54, 0x54 ],
        [ 0xfc, 0x54, 0xfc ],
        [ 0xfc, 0xfc, 0x54 ],
        [ 0xfc, 0xfc, 0xfc ],
    ]
);

=head1 NAME

Image::TextMode::Palette::VGA - 16-color VGA palette

=head1 DESCRIPTION

This is the default VGA palette.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
