package Image::TextMode::Reader::ANSIMation;

use Moose;
use Image::TextMode::Canvas;

extends 'Image::TextMode::Reader::ANSI';

sub _read {
    my( $self, $animation ) = ( shift, shift );
    $animation->add_frame( Image::TextMode::Canvas->new );
    $self->SUPER::_read( $animation, @_ );
}

sub set_position {
	my $self = shift;

	if( ( $_[ 0 ] || 1 ) == 1 && ( $_[ 1 ] || 1 ) == 1 ) {
		$self->next_frame;
	}

	$self->SUPER::set_position( @_ );
}

sub next_frame {
	my $self  = shift;
    my $animation = $self->image;

	return unless $animation->frames->[ -1 ]->height > 0;

	$animation->add_frame( Image::TextMode::Canvas->new );
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Reader::ANSIMation - Reads ANSI Animation files

=head1 METHODS

=head2 set_position( [$x, $y] )

We use this method as a clue that we're starting a new frame if $x and $y are
both 1, which is the default.

=head2 next_frame( )

Adds a new frame to the stack.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2009 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
