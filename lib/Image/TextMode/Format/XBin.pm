package Image::TextMode::Format::XBin;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

has 'header' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub {
        {   id      => 'XBIN',
            eofchar => chr( 26 ),
            map { $_ => 0 } qw( width height fontsize flags )
        };
    }
);

sub extensions { return 'xb', 'xbin' };

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::XBin - read and write XBin files

=head1 DESCRIPTION

XBin stands for "eXtended BIN" -- an extention to the normal raw-image BIN files.

XBin features:

=over 4 

=item * allows for binary images up to 65536 columns wide, and 65536 lines high

=item * can have an alternate set of palette colors either in blink or in non-blink mode

=item * can have different textmode fonts from 1 to 32 scanlines high, consisting of either 256 or 512 different characters

=item * can be compressed

=back

XBin file stucture:

    +------------+
    | Header     |
    +------------+
    | Palette    |
    +------------+
    | Font       |
    +------------+
    | Image Data |
    +------------+

Note, the only required element is a header. See the XBin specs for for information.
http://www.acid.org/info/xbin/xbin.htm

=head1 ACCESSORS

=over 4

=item * header - A header hashref containing an id, width, height, font size and any extra flags

=back

=head1 METHODS

=head2 new( %args )

Creates a XBin instance.

=head2 extensions( )

Returns 'xb', 'xbin'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;