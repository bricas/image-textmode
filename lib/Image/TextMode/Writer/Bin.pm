package Image::TextMode::Writer::Bin;

use Moose;

extends 'Image::TextMode::Writer';

sub _write {
    my ( $self, $image, $fh, $options ) = @_;

    for my $row ( @{ $image->pixeldata } ) {
        print $fh
            join( '', map { pack( 'aC', @{ $_ }{ 'char', 'attr' } ) } @$row );
    }
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Writer::Bin - Writes Bin files

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
