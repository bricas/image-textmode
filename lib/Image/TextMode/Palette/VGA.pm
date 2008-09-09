package Image::TextMode::Palette::VGA;

use Moose;

extends 'Image::TextMode::Palette';

has '+colors' => (
    default => sub {
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
        ];
    }
);

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Palette::VGA - 16-color VGA palette

=head1 DESCRIPTION

This is the default VGA palette.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
