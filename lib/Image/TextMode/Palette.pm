package Image::TextMode::Palette;

use Moose;

has 'colors' => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Palette - A base class for text mode palettes

=head1 DESCRIPTION

Represents a palette in text mode. That is, an array of RGB triples.

=head1 ACCESSORS

=over 4

=item * colors - An array of RGB triples

=back

=head1 METHODS

=head2 new( %args )

Creates a new palette object.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
