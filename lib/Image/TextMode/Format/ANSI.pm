package Image::TextMode::Format::ANSI;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

use Image::TextMode::Palette::ANSI;

has '+palette' => ( default => sub { Image::TextMode::Palette::ANSI->new } );

sub extensions { return 'ans', 'cia', 'ice' };

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::ANSI - read and write ANSI files

=head1 METHODS

=head2 new( %args )

Creates a ANSI instance.

=head2 extensions( )

Returns 'ans', 'cia', 'ice'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
