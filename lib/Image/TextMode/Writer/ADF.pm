package Image::TextMode::Writer::ADF;

use Moose;

extends 'Image::TextMode::Writer';

sub _write {
    my ( $self, $image, $fh, $options ) = @_;

    print $fh pack( 'C', $self->header->{version} );

    # TODO: write 64 colors, not 16
    print $fh _pack_pal( $self->palette );
   
    print $fh _pack_font( $self->font );

    for my $row ( @{ $self->pixeldata } ) {
        print $fh join( '', map { pack( 'aC', @{ $_ }{ 'char', 'attr' } ) } @$row )
    }
}

sub _pack_font {
    my $font = shift;
    return pack( 'C*', map { @$_ } @{ $font->chars } );
}

sub _pack_pal {
    my $pal = shift;
    return pack( 'C*', map { @$_ } @{ $pal->colors } );
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Writer::ADF - Writes ADF files

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
