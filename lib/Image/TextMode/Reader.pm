package Image::TextMode::Reader;

use Moose;

=head1 NAME

Image::TextMode::Reader - A base class for file readers

=head1 METHODS

=head2 new( %args )

Creates a new instance.

=head2 read( $image, $file, \%options )

Reads the contents of C<$file> into C<$image> via the subclass's C<_read()>
method.

=cut

sub read {
    my ( $self, $image, $fh, $options ) = @_;
    $options ||= {};
    $fh = _get_fh( $fh );

    $image->sauce->read( $fh );

    if ( !$options->{ width } && $image->has_sauce ) {
        $options->{ width } = $image->sauce->tinfo1;
    }

    seek( $fh, 0, 0 );

    $self->_read( $image, $fh, $options );
}

sub _get_fh {
    my ( $file ) = @_;

    my $fh = $file;
    if ( !ref $fh ) {
        undef $fh;
        open $fh, $file;
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