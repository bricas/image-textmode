package Image::TextMode::Format::ANSI;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

use Image::TextMode::Palette::ANSI;

has '+palette' => ( default => sub { Image::TextMode::Palette::ANSI->new } );

sub extensions { return 'ans', 'cia', 'ice' }

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Format::ANSI - read and write ANSI files

=head1 DESCRIPTION

ANSI is a text-based image format that uses escape sequences to give the
parser a particular command.

=head1 METHODS

=head2 new( %args )

Creates a ANSI instance.

=head2 extensions( )

Returns 'ans', 'cia', 'ice'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2011 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
