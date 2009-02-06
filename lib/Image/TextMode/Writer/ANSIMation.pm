package Image::TextMode::Writer::ANSIMation;

use Moose;

extends 'Image::TextMode::Writer';

sub _write {
    my ( $self, $anim, $fh, $options ) = @_;

    # clear screen
    print $fh "\x1b[2J";

    for my $image ( @{ $anim->frames } ) {
        my( $width, $height ) = $image->dimensions;

        for my $y ( 0..$height - 1 ) {
            for my $x ( 0..79 ) {
                my $pixel = $image->getpixel( $x, $y ) || { char => ' ', attr => 7 };
                print $fh "\x1b[0;", _gen_args( $pixel->{ attr } ), 'm', $pixel->{ char }; 
            }
        }

        # set position
        if( $image ne $anim->frames->[ -1 ] ) {
            print $fh "\x1b[H";
        }
    }
}

sub _gen_args {
    my $attr = shift;
    my $fg = 30 + ( $attr & 7 );
    my $bg = 40 + ( ( $attr & 112 ) >> 4 );
    my $bl = ( $attr & 128 ) ? 5 : '';
    my $in = ( $attr & 8 ) ? 1 : '';
    return join ( ';', grep { length } ( $bl, $in, $fg, $bg ) ); 
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Writer::ANSIMation - Writes ANSIMation files

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2009 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
