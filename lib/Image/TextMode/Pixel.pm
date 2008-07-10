package Image::TextMode::Pixel;

use Moose;
use Moose::Util::TypeConstraints;

with 'MooseX::Clone';

subtype 'Char' => as 'Str' => where { length( $_ ) == 1 };

# Attribute byte constants
use constant ATTR_BG_NB => 240;
use constant ATTR_BLINK => 128;
use constant ATTR_BG    => 112;
use constant ATTR_FG    => 15;

has 'char' => ( is => 'rw', isa => 'Char' );

has 'fg' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'bg' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'blink' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has 'image' => ( is => 'rw', isa => 'Maybe[Object]', handles => [ 'blink_mode' ] );

=head1 NAME

Image::TextMode::Pixel - A base class to represent a text mode "pixel"

=head1 SYNOPSIS

    # create a new pixel from a char + attribute byte pair
    my $pixel = Image::TextMode::Pixel->new(
        char  => $char,
        attr  => $attr,
        image => $image, # required for blink_mode information
    );
    
    # create a new pixel from a char, blink setting plus
    # bg and fg palette indexes
    my $pixel = Image::TextMode::Pixel->new(
        char  => $char,
        bg    => $bg,
        fg    => $fg,
        blink => $blink,
        image => $image, # this is only needed if you want to serialize it
                         # back to an attribute byte
    );

=head1 DESCRIPTION

Represents a "pixel; i.e. a character plus an attribute byte. This includes
a "blink" bit which will only be used if the blink mode setting, which is
gleamed from the associated image object, is true.

=head1 ACCESSORS

=over 4

=item * char - The character for the pixel

=item * fg - The foreground palette index

=item * bg - The background palette index

=item * blink - The blink bit

=item * image - The associated image object

=item * blink_mode - True or false; delegated to the image object

=back

=head1 METHODS

=head2 new( %args )

Creates a new pixel.

=cut

override 'BUILDARGS' => sub {
    my $class = shift;
    my %args = %{ super( $class, @_ ) };
    my $attr = delete $args{ attr };

    if ( $attr ) {
        if ( !ref $attr ) {
            $attr = $class->_attr_to_components( $attr, $args{ image } );
        }

        %args = ( %args, %$attr );
    }

    return \%args;
};

=head2 attr( [$byte] )

If a byte is passed to this function, it is separated into its fg, bg and
blink parts. Otherwise, it returns an attribute byte generated from existing
data.

=cut

sub attr {
    my $self = shift;
    my ( $attr ) = @_;

    if ( @_ ) {
        $attr = $self->_attr_to_components( $attr ) if !ref $attr;
        $self->$_( $attr->{ $_ } ) for keys %$attr;
    }
    else {
        my $mode = $self->blink_mode;
        $attr = 0;
        $attr |= $self->fg;
        $attr |= ( $self->bg << 4 );
        if ( defined $mode && $mode ) {
            $attr |= ( $self->blink << 7 );
        }
    }

    return $attr;
}

sub _attr_to_components {
    my( $self, $attr, $image ) = @_;
    my %data;

    my $mode = $image ? $image->blink_mode : $self->blink_mode;

    $data{ fg } = $attr & ATTR_FG;

    if ( defined $mode and $mode ) {
        $data{ blink } = ( $attr && ATTR_BLINK ) >> 7;
        $data{ bg } = ( $attr & ATTR_BG ) >> 4;
    }
    else {
        $data{ blink } = 0;
        $data{ bg } = ( $attr & ATTR_BG_NB ) >> 4;
    }

    return \%data;
}

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

no Moose;

1;
