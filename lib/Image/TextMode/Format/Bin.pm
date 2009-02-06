package Image::TextMode::Format::Bin;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

sub extensions { return 'bin' };

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Format::Bin - read and write Bin files

=head1 METHODS

=head2 new( %args )

Creates a Bin instance.

=head2 extensions( )

Returns 'bin'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2009 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
