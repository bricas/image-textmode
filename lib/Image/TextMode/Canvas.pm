package Image::TextMode::Canvas;

use Moose;

use Image::TextMode::Pixel;

=head1 NAME

Image::TextMode::Canvas - A canvas of text mode pixels

=head1 ACCESSORS

=over 4

=item * width - the width of the canvas

=item * height - the height of the canvas

=item * pixeldata - an arrayref of arrayrefs of pixel data

=back

=cut

has 'width' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'height' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'pixeldata' => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

=head1 METHODS

=head2 new( %args )

Creates a new canvas.

=head2 getpixel( $x, $y )

Get raw pixel data at C<$x>, C<$y>.

=cut

sub getpixel {
    my ( $self, $x, $y ) = @_;
    return unless exists $self->pixeldata->[ $y ];    # avoid autovivification
    return $self->pixeldata->[ $y ]->[ $x ];
}

=head2 getpixel_obj( $x, $y, \%options )

Create a pixel object data at C<$x>, C<$y>. Available options include:

=over 4

=item * blink_mode - enabed or disable blink mode for the pixel object

=back

=cut

sub getpixel_obj {
    my ( $self, $x, $y, $options ) = @_;
    my $pixel = $self->getpixel( $x, $y );
    return unless $pixel;
    return Image::TextMode::Pixel->new( %$pixel, $options );
}

=head2 putpixel( \%pixel, $x, $y )

Store pixel data at C<$x>, C<$y>.

=cut

sub putpixel {
    my ( $self, $pixel, $x, $y ) = @_;
    $self->pixeldata->[ $y ]->[ $x ] = $pixel;

    my ( $w, $h ) = ( $x + 1, $y + 1 );
    $self->height( $h ) if $self->height < $h;
    $self->width( $w )  if $self->width < $w;
}

=head2 dimensions( )

returns a list of the width and height of the image.

=cut

sub dimensions {
    my $self = shift;
    return $self->width, $self->height;
}

=head2 clear_screen( )

Clears the canvas pixel data.

=cut

sub clear_screen {
    my $self = shift;
    $self->width( 0 );
    $self->height( 0 );
    $self->pixeldata( [] );
}

=head2 clear_line( $y )

Clears the data at line C<$y>.

=cut

sub clear_line {
    my $self = shift;
    my $y    = shift;

    $self->pixeldata->[ $y ] = [];
    $self->width( $y ) if $y > $self->width;
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
