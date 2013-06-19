package Image::TextMode::Format::ATASCII;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

use Image::TextMode::Font::Atari;
has '+font' => ( default => sub { Image::TextMode::Font::Atari->new } );

use Image::TextMode::Palette::Atari;
has '+palette' => ( default => sub { Image::TextMode::Palette::Atari->new } );

sub extensions { return 'ata' }

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Format::ATASCII - read ATASCII files

=head1 DESCRIPTION

ATASCII is a variant of ASCII used in Atari 8-bit home computers.

=head1 METHODS

=head2 new( %args )

Creates a ATASCII instance.

=head2 extensions( )

Returns 'ata'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2013 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
