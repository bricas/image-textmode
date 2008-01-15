package Image::ANSI::Parser;

=head1 NAME

Image::ANSI::Parser - Reads in ANSI files

=head1 SYNOPSIS

	my $parser = Image::ANSI::Parser->new;
	my $ansi   = $parser->parse( file => 'file.ans' );

=cut

use base qw( Class::Data::Accessor );

use warnings;
use strict;

# State definitions
use constant S_TXT      => 0;
use constant S_CHK_B    => 1;
use constant S_WAIT_LTR => 2;
use constant S_END      => 3;

__PACKAGE__->mk_classaccessor( tabstop => 8 );
__PACKAGE__->mk_classaccessors(
    qw( ansi save_x save_y attr state x y linewrap ) );

our $VERSION = '0.10';

=head1 METHODS

=head2 clear( )

Clears the internal ANSI object.

=cut

sub reset {
    my $self = shift;

    $self->$_( 0 ) for qw( x y save_x save_y );
    $self->attr( 7 );    # default to white on black;
    $self->state( S_TXT );
}

=head2 parse( %options )

Reads in a file, handle or string

	my $parser = Image::ANSI::Parser->new;

	# filename
	$ansi = $parser->parse( file => 'file.ans' );
	
	# file handle
	$ansi = $parser->parse( handle => $handle );

	# string
	$ansi = $parser->parse( string => $string );

=cut

sub parse {
    my $self = shift;
    my ( $ansi, $file, $options ) = @_;
    my ( $argbuf, $ch );

    $self->ansi( $ansi );
    $self->reset;

    my $sauce = $ansi->sauce;
    $self->linewrap( $options->{ linewrap }
            || ( $sauce->has_sauce ? $sauce->tinfo1 : undef ) );

    $ansi->blink_mode( $sauce->has_sauce ? $sauce->flags : 1 );

    seek( $file, 0, 0 );
    while ( $file->read( $ch, 1 ) ) {
        my $state = $self->state;
        if ( $state == S_TXT ) {
            if ( $ch eq "\x1a" ) {
                $self->state( S_END );
            }
            elsif ( $ch eq "\x1b" ) {
                $self->state( S_CHK_B );
            }
            elsif ( $ch eq "\n" ) {
                $self->new_line;
            }
            elsif ( $ch eq "\r" ) {

                # do nothing
            }
            elsif ( $ch eq "\t" ) {
                $self->tab;
            }
            else {
                $self->store( $ch );
            }
        }
        elsif ( $state == S_CHK_B ) {
            if ( $ch ne '[' ) {
                $self->store( chr( 27 ) );
                $self->store( $ch );
                $self->state( S_TXT );
            }
            else {
                $self->state( S_WAIT_LTR );
            }
        }
        elsif ( $state == S_WAIT_LTR ) {
            if ( $ch =~ /[a-zA-Z]/ ) {
                my @args = split( /;/, $argbuf );

                if ( $ch eq 'm' ) {
                    $self->set_attributes( @args );
                }
                elsif ( $ch eq 'H' or $ch eq 'f' ) {
                    $self->set_position( @args );
                }
                elsif ( $ch eq 'A' ) {
                    $self->move_up( @args );
                }
                elsif ( $ch eq 'B' ) {
                    $self->move_down( @args );
                }
                elsif ( $ch eq 'C' ) {
                    $self->move_right( @args );
                }
                elsif ( $ch eq 'D' ) {
                    $self->move_left( @args );
                }
                elsif ( $ch eq 's' ) {
                    $self->save_position( @args );
                }
                elsif ( $ch eq 'u' ) {
                    $self->restore_position( @args );
                }
                elsif ( $ch eq 'J' ) {
                    $self->clear_screen( @args );
                }
                elsif ( $ch eq 'K' ) {
                    $self->clear_line( @args );
                }

                $argbuf = '';
                $self->state( S_TXT );
            }
            else {
                $argbuf .= $ch;
            }
        }
        elsif ( $state == S_END ) {
            last;
        }
        else {
            $self->state( S_TXT );
        }
    }

    return $ansi;
}

=head2 x( [$x] )

stores the current 'x' location.

=cut

sub x {
    my $self = shift;
    my $data = shift;

    $data = 0 if defined $data && $data < 0;
    return $self->x_accessor( defined $data ? $data : () );
}

=head2 y( [$y] )

stores the current 'y' location.

=cut

sub y {
    my $self = shift;
    my $data = shift;

    $data = 0 if defined $data && $data < 0;
    return $self->y_accessor( defined $data ? $data : () );
}

# Handlers

=head2 set_position( [$x, $y] )

sets the x() and y() positions.

=cut

sub set_position {
    my $self = shift;
    my $y    = shift || 1;
    my $x    = shift || 1;

    $self->x( $x - 1 );
    $self->y( $y - 1 );
}

=head2 set_attributes( @attributes )

sets the attributes of the pixel (fg, bg, blinking)

=cut

sub set_attributes {
    my $self = shift;
    my @args = @_;

    foreach ( @args ) {
        if ( $_ == 0 ) {
            $self->attr( 7 );
        }
        elsif ( $_ == 1 ) {
            $self->attr( $self->attr | 8 );
        }
        elsif ( $_ == 5 ) {
            $self->attr( $self->attr | 128 );
        }
        elsif ( $_ >= 30 and $_ <= 37 ) {
            $self->attr( $self->attr & 248 );
            $self->attr( $self->attr | ( $_ - 30 ) );
        }
        elsif ( $_ >= 40 and $_ <= 47 ) {
            $self->attr( $self->attr & 143 );
            $self->attr( $self->attr | ( ( $_ - 40 ) << 4 ) );
        }
    }
}

=head2 move_up( [$number] )

moves y() up by $number (default 1).

=cut

sub move_up {
    my $self = shift;
    my $y = shift || 1;

    $self->y( $self->y - $y );
}

=head2 move_down( [$number] )

moves y() down by $number (default 1).

=cut

sub move_down {
    my $self = shift;
    my $y = shift || 1;

    $self->y( $self->y + $y );
}

=head2 move_right( [$number] )

moves x() right by $number (default 1).

=cut

sub move_right {
    my $self = shift;
    my $x = shift || 1;

    $self->x( $self->x + $x );
}

=head2 move_left( [$number] )

moves x() left by $number (default 1).

=cut

sub move_left {
    my $self = shift;
    my $x = shift || 1;

    $self->x( $self->x - $x );
}

=head2 save_position( )

saves the current x() and y() positions.

=cut

sub save_position {
    my $self = shift;

    $self->save_x( $self->x );
    $self->save_y( $self->y );
}

=head2 restore_position( )

restored the saved x() and y() positions.

=cut

sub restore_position {
    my $self = shift;

    $self->x( $self->save_x );
    $self->y( $self->save_y );
}

=head2 clear_line( )

clears the pixels on the current line.

=cut

sub clear_line {
    my $self = shift;

    $self->ansi->clear_line( $self->y );
}

=head2 clear_screen( )

clears all pixels.

=cut

sub clear_screen {
    my $self = shift;

    $self->ansi->clear_screen;
}

=head2 new_line( )

simulates a newline char.

=cut

sub new_line {
    my $self = shift;

    $self->y( $self->y + 1 );
    $self->x( 0 );
}

=head2 tab( )

simulates a tab char (8 spaces).

=cut

sub tab {
    my $self  = shift;
    my $count = ( $self->x + 1 ) % $self->tabstop;
    if ( $count ) {
        $count = $self->tabstop - $count;
        for ( 1 .. $count ) {
            $self->store( ' ' );
        }
    }
}

=head2 store( $char, $x, $y [, $attr] )

stores $char at position $x, $y using attributes $attr
(or the current attr setting if none are supplied).

=cut

sub store {
    my $self = shift;
    my $char = shift;
    my $x    = shift;
    my $y    = shift;
    my $attr = shift || $self->attr;

    if ( defined $x and defined $y ) {
        $self->putpixel( $x, $y, $char, $attr );
    }
    else {
        $self->putpixel( $self->x, $self->y, $char, $attr );
        $self->x( $self->x + 1 );
    }

    if ( $self->linewrap && $self->x >= $self->linewrap ) {
        $self->new_line;
    }
}

=head2 putpixel( @args )

same as the pixel() method

=cut

*putpixel = \&pixel;

=head2 getpixel( @args )

same as the pixel() method

=cut

*getpixel = \&pixel;

=head2 pixel( $x, $y [, $char, $attr] )

get/sets the pixel at $x, $y.

=cut

sub pixel {
    my $self = shift;
    my $x    = shift;
    my $y    = shift;
    my $char = shift;
    my $attr = shift;

    if ( defined $char ) {
        $self->ansi->putpixel( $x, $y, $char, $attr );
    }

    return $self->ansi->getpixel( $x, $y );
}

=head1 AUTHOR

=over 4 

=item * Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=back

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
