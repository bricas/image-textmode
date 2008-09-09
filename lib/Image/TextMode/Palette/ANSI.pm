package Image::TextMode::Palette::ANSI;

use Moose;

extends 'Image::TextMode::Palette';

has '+colors' => (
    default => sub {
        [   [ 0x00, 0x00, 0x00 ],    # black
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
            [ 0xfe, 0xfe, 0xfe ],    # white
        ];
    }
);

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Palette::ANSI - 16-color ANSI palette

=head1 DESCRIPTION

This is the default ANSI palette.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
