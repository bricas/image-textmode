package Image::TextMode::Pixel;

use base qw( Class::Data::Accessor );

use strict;
use warnings;

# Attribute byte constants
use constant ATTR_BG_NB => 240;
use constant ATTR_BLINK => 128;
use constant ATTR_BG    => 112;
use constant ATTR_FG    => 15;

__PACKAGE__->mk_classaccessors( qw( char fg bg blink blink_mode ) );

=head1 NAME

Image::TextMode::Pixel - A base class to represent a text mode "pixel"

=head1 SYNOPSIS

    my $pixel = Image::TextMode::Pixel->new( {
        char => $char,
        attr => $attr,
        blink_mode => $mode,
    } );

=head1 DESCRIPTION

Represent a "pixel, i.e. a character plus an attribute byte. Also includes
a blink_mode setting in order to figure out how to interpret the attribute
byte data.

=head1 ACCESSORS

=over 4

=item * char - The character for the pixel

=item * fg - The foreground palette index

=item * bg - The background palette index

=item * blink - The blink bit

=item * blink_mode - Boolean for blink mode

=back

=head1 METHODS

=head2 new( \%opts )

Creates a new pixel.

=cut

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $attr = delete $options->{ attr };
    my $self = bless $options, $class;

    $self->attr( $attr ) if defined $attr;

    return $self;
}

=head2 attr( [$byte] )

If a byte is passed to this function, it is separated into its fg, bg and
blink parts. Returns the data otherwise.

=cut

sub attr {
    my $self     = shift;
    my ( $attr ) = @_;
    my $mode     = $self->blink_mode;

    if ( @_ ) {
        $self->fg( $attr & ATTR_FG );
        if ( defined $mode && $mode ) {
            $self->bg(    ( $attr & ATTR_BG ) >> 4 );
            $self->blink( ( $attr & ATTR_BLINK ) >> 7 );
        }
        else {
            $self->bg( ( $attr & ATTR_BG_NB ) >> 4 );
        }
    }
    else {
        $attr = 0;
        $attr |= $self->fg;
        $attr |= ( $self->bg << 4 );
        if ( defined $mode && $mode ) {
            $attr |= ( $self->blink << 7 );
        }
    }

    return $attr;
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
