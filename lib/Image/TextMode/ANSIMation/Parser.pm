package Image::TextMode::ANSIMation::Parser;

=head1 NAME

Image::ANSIMation::Parser - Reads in ANSI animation (ANSIMation) files

=head1 SYNOPSIS

	my $parser = Image::ANSIMation::Parser->new;
	my $anim   = $parser->parse( file => 'file.ans' );

=head1 DESCRIPTION

This parser inherits from the regular L<Image::ANSI::Parser>. The only
extra functionality it adds in the ability to store frames.

=cut

use base qw( Image::ANSI::Parser Class::Accessor );

use strict;
use warnings;

use Image::ANSI;
use Image::ANSIMation;

our $VERSION = '0.02';

__PACKAGE__->mk_accessors( qw( ansimation ) );

=head1 METHODS

=head2 set_position( $x, $y )

Sets the cursor position. If we're resetting it to (1, 1)
we consider that a new frame.

=cut

sub set_position {
    my $self = shift;

    if ( $_[ 0 ] == 1 && $_[ 1 ] == 1 ) {
        $self->store_frame;
    }

    $self->SUPER::set_position( @_ );
}

=head2 parse( %options )

Parses a file and returns the ansimation.

=cut

sub parse {
    my $self = shift;
    $self->ansimation( undef );
    $self->SUPER::parse( @_ );
    $self->store_frame;
    return $self->ansimation;
}

=head2 store_frame( )

Stores the value of C<$self-<gt>ansi> as the next frame and resets
the current ansi.

=cut

sub store_frame {
    my $self       = shift;
    my $ansimation = $self->ansimation;

    unless ( defined $ansimation ) {
        $ansimation = Image::ANSIMation->new;
        $self->ansimation( $ansimation );
    }

    return unless $self->ansi->height > 0;

    $ansimation->add_frame( $self->ansi );
    $self->ansi( Image::ANSI->new );
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
