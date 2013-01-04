package Image::TextMode::Reader::ANSI;

use Moose;
use charnames ':full';

extends 'Image::TextMode::Reader';

# State definitions
my $S_TXT      = 0;
my $S_CHK_B    = 1;
my $S_WAIT_LTR = 2;
my $S_END      = 3;

has 'tabstop' => ( is => 'rw', isa => 'Int', default => sub { 8 } );

has 'save_x' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'save_y' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'x' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'y' => ( is => 'rw', isa => 'Int', default => sub { 0 } );

has 'attr' => ( is => 'rw', isa => 'Int', default => sub { 7 } );

has 'state' => ( is => 'rw', isa => 'Int', default => sub { $S_TXT } );

has 'image' => ( is => 'rw', isa => 'Object' );

has 'linewrap' => ( is => 'rw', isa => 'Int', default => sub { 80 } );

sub _read {
    my ( $self, $image, $fh, $options ) = @_;

    $self->image( $image );
    if ( $options->{ width } ) {
        $self->linewrap( $options->{ width } );
    }

    if ( $image->has_sauce ) {
        $image->render_options->{ blink_mode } = $image->sauce->flags_id ^ 1;
    }

    seek( $fh, 0, 0 );

    # make sure we reset the state of the parser
    $self->state( $S_TXT );

    my ( $argbuf, $ch );
    while ( read( $fh, $ch, 1 ) ) {
        my $state = $self->state;
        if ( $state == $S_TXT ) {
            if ( $ch eq "\N{SUBSTITUTE}" ) {
                $self->state( $S_END );
            }
            elsif ( $ch eq "\N{ESCAPE}" ) {
                $self->state( $S_CHK_B );
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
        elsif ( $state == $S_CHK_B ) {
            if ( $ch ne '[' ) {
                $self->store( chr( 27 ) );
                $self->store( $ch );
                $self->state( $S_TXT );
            }
            else {
                $self->state( $S_WAIT_LTR );
            }
        }
        elsif ( $state == $S_WAIT_LTR ) {
            if ( $ch =~ /[a-zA-Z]/s ) {
                $argbuf =~ s{\s}{}sg;    # eliminate whitespace from args
                my @args = split( /;/s, $argbuf );

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
                elsif ( $ch eq 'E' ) {
                    $self->move_down( @args );
                    $self->x( 0 );
                }
                elsif ( $ch eq 'F' ) {
                    $self->move_up( @args );
                    $self->x( 0 );
                }
                elsif ( $ch eq 'G' ) {
                    $self->x( ( $args[ 0 ] || 1 ) - 1 );
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
                $self->state( $S_TXT );
            }
            else {
                $argbuf .= $ch;
            }
        }
        elsif ( $state == $S_END ) {
            last;
        }
        else {
            $self->state( $S_TXT );
        }
    }

    return $image;
}

sub set_position {
    my ( $self, $y, $x ) = @_;
    $y = ( $y || 1 ) - 1;
    $x = ( $x || 1 ) - 1;

    $y = 0 if $y < 0;
    $x = 0 if $x < 0;

    $self->x( $x );
    $self->y( $y );
}

sub set_attributes {
    my ( $self, @args ) = @_;

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

sub move_up {
    my $self = shift;
    my $y = $self->y - ( shift || 1 );
    $y = 0 if $y < 0;
    $self->y( $y );
}

sub move_down {
    my $self = shift;
    my $y = shift || 1;

    $self->y( $self->y + $y );
}

sub move_right {
    my $self = shift;
    my $x = $self->x + ( shift || 1 );

    # check $x against $self->linewrap?

    $self->x( $x );
}

sub move_left {
    my $self = shift;
    my $x = $self->x - ( shift || 1 );

    $x = 0 if $x < 0;

    $self->x( $x );
}

sub save_position {
    my $self = shift;

    $self->save_x( $self->x );
    $self->save_y( $self->y );
}

sub restore_position {
    my $self = shift;

    $self->x( $self->save_x );
    $self->y( $self->save_y );
}

sub clear_line {
    my $self = shift;
    my $arg  = shift;

    if ( !$arg ) {    # clear to end of line
        $self->image->clear_line( $self->y, [ $self->x, -1 ] );
    }
    elsif ( $arg == 1 ) {    # clear to start of line
        $self->image->clear_line( $self->y, [ 0, $self->x ] );
    }
    elsif ( $arg == 2 ) {    #clear whole line
        $self->image->clear_line( $self->y );
    }
}

sub clear_screen {
    my $self = shift;
    my $arg  = shift;

    if( !$arg ) { # clear to end of screen, including cursor
        my $next = $self->y + 1;
        $self->image->delete_line( $next ) for 1..$self->image->height - $next + 1;
        $self->image->clear_line( $self->y, [ $self->x, -1 ] );
    }
    elsif( $arg == 1 ) { # clear to start of screen, including cursor
        $self->image->clear_line( $_ ) for 0..$self->y - 1;
        $self->image->clear_line( $self->y, [ 0, $self->x ] );
    }
    elsif( $arg == 2 ) { # clear whole screen
        $self->image->clear_screen;
        $self->x( 0 );
        $self->y( 0 );
    }
}

sub new_line {
    my $self = shift;

    $self->y( $self->y + 1 );
    $self->x( 0 );
}

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

sub store {
    my $self = shift;
    my $char = shift;
    my $x    = shift;
    my $y    = shift;
    my $attr = shift || $self->attr;

    if ( defined $x and defined $y ) {
        $self->image->putpixel( { char => $char, attr => $attr }, $x, $y );
    }
    else {
        $self->image->putpixel( { char => $char, attr => $attr },
            $self->x, $self->y );
        $self->x( $self->x + 1 );
    }

    if ( $self->x >= $self->linewrap ) {
        $self->new_line;
    }
}

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 NAME

Image::TextMode::Reader::ANSI - Reads ANSI files

=head1 DESCRIPTION

Provides reading capabilities for the ANSI format.

=head1 ACCESSORS

=over 4

=item * tabstop - every Nth character will be a tab stop location (default: 8)

=item * save_x - saved x position (default: 0)

=item * save_y - saved y position (default: 0)

=item * x - current x (default: 0)

=item * y - current y (default: 0)

=item * attr - current attribute info (default: 7, gray on black)

=item * state - state of the parser (default: C<$S_TXT>)

=item * image - the image we're parsing into

=item * linewrap - max width before we wrap to the next line (default: 80)

=back

=head1 METHODS

=head2 set_position( [$x, $y] )

Moves the cursor to C<$x, $y>.

=head2 set_attributes( @args )

Sets the default attribute information (fg and bg).

=head2 move_up( $y )

Moves the cursor up C<$y> lines.

=head2 move_down( $y )

Moves the cursor down C<$y> lines.

=head2 move_left( $x )

Moves the cursor left C<$x> columns.

=head2 move_right( $x )

Moves the cursor right C<$x> columns.

=head2 save_position( )

Saves the current cursor position.

=head2 restore_position( )

Restores the saved cursor position.

=head2 clear_screen( )

Clears all data on the canvas.

=head2 clear_line( $y )

Clears the line at C<$y>.

=head2 new_line( )

Simulates a C<\n> character.

=head2 tab( )

Simulates a C<\t> character.

=head2 store( $char, $x, $y [, $attr] )

Stores C<$char> at position C<$x, $y> with either the supplied attribute
or the current attribute setting.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2013 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
