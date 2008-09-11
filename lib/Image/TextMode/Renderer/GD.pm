package Image::TextMode::Renderer::GD;

use Moose;
use GD;
use Image::TextMode::Palette::ANSI;

=head1 NAME

Image::TextMode::Renderer::GD - A GD-based renderer for text mode images

=head1 DESCRIPTION

=head1 METHODS

=head2 new( %args )

Creates a new instance.

=head2 thumbnail( $source, \%options )

Renders a thumbnail-sized version of the image. This is mostly a pass-through to
C<fullscale()> with the resulting image being scaled down to 1 pixel width per
1 character column. Options specific to this method are:

=over 4

=item * zoom - a zoom factor for the thumbnail (default: n/a)

=back

See C<fullscale> for all of the other available options.

=cut

sub thumbnail {
    my ( $self, $source, $options ) = @_;

    $options = { %{ $source->render_options }, $options ? %$options : () };

    if( $source->can('frames') ) {
        return $self->_render_animated_thumbnail( $source, $options );
    }

    my $image_l = do {
        local $options->{ format } = 'object';
        $self->fullscale( $source, $options );
    };

    my ( $width, $height ) = _thumbnail_size( $source, $image_l, $options );

    my $image = GD::Image->new( $width, $height, 1 );
    $image->copyResampled( $image_l, 0, 0, 0, 0, $width, $height,
        $image_l->getBounds );

    my $output = $options->{ format } || 'png';

    return $image->$output;
}

sub _render_animated_thumbnail {
    my ( $self, $source, $options ) = @_;
    my @frames = @{ $source->frames };
    $options->{ format } = 'object';
    $self->_prepare_options( $source, $options );
    my $frame = $self->_render_frame( $frames[ 0 ], $options );
    my( $width, $height ) = _thumbnail_size( $source, $frame, $options );
    my $master = GD::Image->new( $width, $height, 1 );

    $master->copyResampled( $frame, 0, 0, 0, 0, $width, $height, $frame->getBounds );
    my $output = $master->gifanimbegin( 0 );
    $output .= $master->gifanimadd( 1, 0, 0, 15, 1 );

    shift @frames;
    for my $canvas ( @frames ) {
        $frame = $self->_render_frame( $canvas, $options );
        $master->copyResampled( $frame, 0, 0, 0, 0, $width, $height, $frame->getBounds );
        $output .= $master->gifanimadd( 1, 0, 0, 15, 1 );
    }

    $output .= $master->gifanimend;
 
    return $output;   
}

sub _thumbnail_size {
    my( $source, $image, $options ) = @_;

    my ( $width, $height ) = $source->dimensions;
    $height = $image->height / int( $image->width / $width + 0.5 );

    if ( my $zoom = $options->{ zoom } ) {
        $width  *= $zoom;
        $height *= $zoom;
    }

    return( $width, $height );
}

=head2 fullscale( $source, \%options )

Renders a pixel-by-pixel representation of the text mode image. You may use the
following options to change the output:

=over 4

=item * crop - limit the display to this may characters (default: n/a)

=item * blink_mode - disables the 8th bit of an attribute byte to be used with the background color (aka iCEColor) (default: false)

=item * true_color - set this to true to enable true color image output (default: false)

=item * 9th_bit - compatibility option to enable a ninth column in the font (default: false)

=item * ced - CED mode (black text on gray background) (default: false)

=item * format - the output format (default: png)

=back

=cut

sub fullscale {
    my ( $self, $source, $options ) = @_;

    $options = { %{ $source->render_options }, $options ? %$options : () };

    $self->_prepare_options( $source, $options );

    if( $source->can('frames') ) {
        $options->{ format } = 'object';
        my $master = GD::Image->new( @{ $options->{ full_dimensions } } );
        my $output = $master->gifanimbegin( 0 );
        for my $canvas ( @{ $source->frames } ) {
            my $obj = $self->_render_frame( $canvas, $options );

            $output.= $obj->gifanimadd( 1, 0, 0, 15, 1 );
        }
        $output .= $master->gifanimend;
        return $output;
    }

    return $self->_render_frame( $source, $options );
}

sub _prepare_options {
    my( $self, $source, $options ) = @_;

    my $font = _font_to_gd( $source->font,
        { '9th_bit' => delete $options->{ '9th_bit' } } );

    $options->{ truecolor } ||= 0;
    $options->{ font } = $font;
    $options->{ palette } = $options->{ ced } ? Image::TextMode::Palette::ANSI->new : $source->palette;
    $options->{ format } ||= 'png';

    my ( $width, $height ) = $source->dimensions;
    $height = $options->{ crop } if $options->{ crop };
    $options->{ full_dimensions } = [ $width * $font->width, $height * $font->height ];

}


sub _render_frame {
    my ( $self, $canvas, $options ) = @_;

    my ( $width, $height ) = $canvas->dimensions;
    $height = $options->{ crop } if $options->{ crop };

    my $font = $options->{ font };
    my $ftwidth = $font->width;
    my $ftheight = $font->height;
    my $ced = $options->{ ced };

    my $image = GD::Image->new(
        @{ $options->{ full_dimensions } },
        $options->{ truecolor }
    );

    my $colors = _fill_gd_palette( $options->{ palette }, $image );

    $image->fill( 0, 0, 7 ) if $ced;

    for my $y ( 0 .. $height - 1 ) {
        for my $x ( 0 .. $width - 1 ) {
            my $pixel = $canvas->getpixel_obj( $x, $y, $options );

            next unless $pixel;

            if ( defined $pixel->bg ) {
                $image->filledRectangle(
                    $x * $ftwidth,
                    $y * $ftheight,
                    ( $x + 1 ) * $ftwidth,
                    ( $y + 1 ) * $ftheight - 1,
                    $colors->[ $ced ? 7 : $pixel->bg ]
                );
            }

            $image->string(
                $font,
                $x * $ftwidth,
                $y * $ftheight,
                $pixel->char, $colors->[ $ced ? 0 : $pixel->fg ]
            );
        }
    }

    my $output = $options->{ format };

    return $image if $output eq 'object';
    return $image->$output;
}

sub _font_to_gd {
    my ( $font, $options ) = @_;

    require File::Temp;
    my $temp = File::Temp->new;

    binmode( $temp );

    my $ninth     = $options->{ '9th_bit' };
    my $chars     = $font->chars;
    my $font_size = @$chars;

    print $temp pack( 'VVVV',
        $font_size, 0, $font->width + ( $ninth ? 1 : 0 ),
        $font->height );

    for my $charval ( 0 .. $font_size ) {
        my $char = $chars->[ $charval ];
        for ( @$char ) {
            my @binary = split( //, sprintf( '%08b', $_ ) );

            if ( $ninth ) {
                push @binary,
                    (       $charval >= 0xc0
                        and $charval <= 0xdf ? $binary[ -1 ] : 0 );
            }

            print $temp pack( 'C*', @binary );
        }
    }
    close $temp;

    return GD::Font->load( $temp->filename );
}

sub _fill_gd_palette {
    my ( $palette, $image ) = @_;
    my @allocations
        = map { $image->colorAllocate( @$_ ) } @{ $palette->colors };
    return \@allocations;
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