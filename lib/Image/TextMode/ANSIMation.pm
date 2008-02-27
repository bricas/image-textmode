package Image::TextMode::ANSIMation;

=head1 NAME

Image::ANSIMation - Load, create, manipulate and save ANSI animation (ANSIMation) files

=head1 SYNOPSIS

	use Image::ANSI::ANSIMation;

	# Read in a file...
	my $anim = Image::ANSIMation->new( file => 'file.ans' );

	# Image width and height
	my $w = $anim->width;
	my $h = $anim->height;

	# export it as a gif animation
	my $gif = $anim->as_gif;

=head1 DESCRIPTION

This module allows you to load, create and manipulate files made up of
ANSI escape codes, much like Image::ANSI, except that it can be composed
of many frames creating an animation.

=cut

use base qw( Class::Accessor );

use strict;
use warnings;

use GD;

our $VERSION = '0.03';

__PACKAGE__->mk_accessors( qw( frames current_frame ) );

=head1 METHODS

=head2 new( %options )

Creates a new ANSIMation. Currently only reads in data.

	# filename
	$anim = Image::ANSIMation->new( file => 'file.ans' );
	
	# file handle
	$anim = Image::ANSIMation->new( handle => $handle );

	# string
	$anim = Image::ANSIMation->new( string => $string );

=cut

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    $self->frames( [] );
    $self->current_frame( 0 );

    my %options = @_;
    if (   exists $options{ file }
        or exists $options{ string }
        or exists $options{ handle } )
    {
        return $self->read( @_ );
    }

    return $self;
}

=head2 read( %options )

Reads in ANSI data.

=cut

sub parse {
    my $self = shift;

    require Image::ANSIMation::Parser;
    Image::ANSIMation::Parser->parse( $self, @_ );

    return $self;
}


=head2 as_string( %options )

Returns the ANSI output as a scalar.

=cut

sub as_string {
    my $self    = shift;
    my %options = @_;

    return join( "\x1b[1;1H", map { $_->as_string } @{ $self->frames } );
}

=head2 add_frame( $frame )

Adds another frame to the animation

=cut

sub add_frame {
    my $self   = shift;
    my $frame  = shift;
    my $frames = $self->frames;

    push @$frames, $frame;
    $self->current_frame( scalar( @$frames ) - 1 );
}

=head2 frames( )

Returns an array ref of frames.

=head2 current_frame( )

Returns an integer of the current position in the array of frames.

=head2 next_frame( )

Return the next frame in the sequence and add 1 to the C<current_frame>.

=cut

sub next_frame {
    my $self   = shift;
    my $frames = $self->frames;
    my $next   = $self->current_frame + 1;

    if ( $next > @$frames - 1 ) {
        $next = 0;
    }

    $self->current_frame( $next );
    return $self->frames->[ $next ];
}

=head2 width( )

Returns the width of the animation.

=cut

sub width {
    my $self = shift;

    return $self->frames->[ 0 ]->width;
}

=head2 height( )

Returns the height of the animation.

=cut

sub height {
    my $self = shift;
    my $max  = 0;

    for my $frame ( @{ $self->frames } ) {
        my $height = $frame->height;
        $max = $height if $height > $max;
    }

    return $max;
}

=head2 as_gif( )

Return the animation as an animated gif.

=cut

sub as_bitmap_full {
    my $self   = shift;
    my $frames = $self->frames;

    my $first = GD::Image->new( $frames->[ 0 ]->as_bitmap_full );
    my $animation = GD::Image->new( $self->width * 8, $self->height * 16 );

    for ( 0 .. 255 ) {
        $animation->colorAllocate( $first->rgb( $_ ) );
    }

    my $gif = $animation->gifanimbegin( 1 );

    for ( @$frames ) {
        my $frame = GD::Image->new( $animation->getBounds );

        for ( 0 .. 255 ) {
            $frame->colorAllocate( $animation->rgb( $_ ) );
        }

        my $image = GD::Image->newFromPngData( $_->as_png_full );

        $frame->copy( $image, 0, 0, 0, 0, $animation->getBounds );
        $gif .= $frame->gifanimadd( 0, 0, 0, 15, 1 );
    }

    $gif .= $animation->gifanimend;

    return $gif;
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
