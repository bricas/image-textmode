package Image::TextMode::Format::IDF;

use Moose;

extends 'Image::TextMode::Format', 'Image::TextMode::Canvas';

has 'header' => (
    is  => 'rw',
    isa => 'HashRef',
    default =>
        sub { { id => '\x{04}1.4', x0 => 0, y0 => 0, x1 => 0, y1 => 0 } }
);

sub extensions { return 'idf' };

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::IDF - read and write IDF files

=head1 ACCESSORS

=over 4

=item * header - A header hashref containing an id, and x0, y0, x1, y1 canvas info

=back

=head1 METHODS

=head2 new( %args )

Creates a IDF instance.

=head2 extensions( )

Returns 'idf'.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
