package Image::TextMode::Writer;

use Moose;

=head1 NAME

Image::TextMode::Writer - A base class for file writers

=head1 METHODS

=head2 new( %args )

Creates a new instance.

=head2 write( $image, $file, \%options )

Writes the contents of C<$image> to C<$file> via the subclass's C<_write()>
method.

=cut

sub write {
    my ( $self, $image, $fh, $options ) = @_;
    $options ||= {};
    $fh = _get_fh( $fh );

    $self->_write( $image, $fh, $options );

    $image->sauce->write( $fh ) if $image->has_sauce;
}

sub _get_fh {
    my ( $file ) = @_;

    my $fh = $file;
    if ( !ref $fh ) {
        undef $fh;
        open $fh, '>', $file;
    }

    binmode( $fh );
    return $fh;
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
