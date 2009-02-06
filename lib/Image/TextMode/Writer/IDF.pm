package Image::TextMode::Writer::IDF;

use Moose;

extends 'Image::TextMode::Writer';

my $header_template = 'A4 v v v v';

sub _write {
    my ( $self, $image, $fh, $options ) = @_;

    my( $max_x, $max_y ) = map { $_ - 1 } $image->dimensions;

    print $fh pack( $header_template, "\x041.4", 0, 0, $max_x, $max_y);

    # Don't bother with RLE compression for now
    for my $y ( 0..$max_y ) {
        for my $x ( 0..$max_x ) {
            my $pixel = $image->getpixel( $x, $y );
            print $fh pack( 'aC', $pixel->{ char }, $pixel->{ attr } );
        }
    }

    for my $char ( @{ $image->font->chars } ) {
        print $fh pack( 'C*', @$char );
    }

    for my $color ( @{ $image->palette->colors } ) {
        print $fh pack( 'C*', map { $_ >> 2 } @$color );
    }
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Writer::IDF - Writes IDF files

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2009 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
