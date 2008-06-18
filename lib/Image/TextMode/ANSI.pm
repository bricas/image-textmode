package Image::TextMode::ANSI;

=head1 NAME

Image::TextMode::ANSI - Load, create, manipulate and save ANSI files

=head1 SYNOPSIS

    use Image::TextMode::ANSI;

    # Read in a file...
    my $img = Image::TextMode::ANSI->read( { file => 'file.ans' } );

    # Image width and height
    my $w = $img->width;
    my $h = $img->height;

    # get and put "pixels"
    my $pixel = $img->getpixel( $x, $y );
    $img->putpixel( $x, $y, $pixel );

    # write the ANSI to a file
    $img->write( { file => 'out.ans' } );

=head1 DESCRIPTION

This module allows you to load, create and manipulate files made up of
ANSI escape codes, aka ANSI art.

=cut

use strict;
use warnings;

use base qw( Image::TextMode::Base );

use Image::TextMode::ANSI::Palette;

=head1 METHODS

=head2 new( %options )

Creates a new ANSI image. Currently only reads in data.

    # filename
    $ansi = Image::TextMode::ANSI->new( file => 'file.ans' );
    
    # file handle
    $ansi = Image::TextMode::ANSI->new( handle => $handle );

    # string
    $ansi = Image::TextMode::ANSI->new( string => $string );

=cut

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new( @_ );
    $self->palette( Image::TextMode::ANSI::Palette->new );
    return $self;
}


=head2 read( %options )

Reads in an ANSI.

=cut

sub _parse {
    my ( $self, $file, %options ) = @_;

    for ( qw( Parser::XS Parser ) ) {
        my $class = __PACKAGE__ . '::' . $_;
        eval "require $class;";
        next if $@;
        $class->parse( $self, $file, \%options );
        last;
    }

    return $self;
}

=head2 write( %options )

Writes the ANSI data to a file, filehandle or string.

=head2 as_string( %options )

Returns the ANSI output as a scalar.

=cut

sub as_string {
    my $self    = shift;
    my %options = @_;
    my $output  = "\x1b[0m";

    my $prevattr = '';
    for my $y ( 0 .. $self->height - 1 ) {
        my $max_x = $self->max_x( $y );
        for my $x ( 0 .. $max_x ) {
            my $pixel = $self->getpixel( $x, $y );
            my ( $char, $attr );
            if ( defined $pixel ) {
                my @args;
                push @args, 5 if $pixel->blink;

                my $fg = $pixel->fg;
                if ( $fg > 7 ) {
                    push @args, 1;
                    $fg -= 8;
                }
                else {
                    push @args, 0;
                }
                push @args, $fg + 30;

                my $bg = $pixel->bg;
                $bg -= 8 if $bg > 7;
                push @args, $bg + 40;

                $attr = join( ';', @args );
                $char = $pixel->char;
            }
            else {
                $attr = 0;
                $char = ' ';
            }

            if ( $attr eq $prevattr ) {
                $output .= $char;
            }
            else {
                $output .= "\x1b[${attr}m$char";
            }

            $prevattr = $attr;
        }
        $output .= "\n" unless $max_x == 79;
    }

    $output .= "\x1b[0m";
    return $output;
}

=head2 max_x( [$y] )

find the largest x on line $y (default 0 ).

=cut

sub max_x {
    my $self = shift;
    my $y = shift || 0;

    my $max = 0;

    for my $x ( 0 .. $self->width - 1 ) {
        $max = $x if $self->getpixel( $x, $y );
    }

    return $max;
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
