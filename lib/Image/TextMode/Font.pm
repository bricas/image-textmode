package Image::TextMode::Font;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( width  => 0 );
__PACKAGE__->mk_classaccessor( height => 0 );
__PACKAGE__->mk_classaccessor( chars  => [] );

sub get {
    my $self  = shift;
    my $index = shift;

    return $self->chars->[ $index ];
}

sub set {
    my $self = shift;
    my ( $index, $lines ) = @_;

    $self->chars->[ $index ] = $lines;
}

sub clear {
    my $self = shift;

    $self->chars( [] );
    $self->width( 0 );
    $self->height( 0 );
}

sub characters {
    my $self = shift;
    return scalar @{ $self->chars };
}

sub as_gd {
        require GD;
        require File::Temp;

        my $temp = File::Temp->new;

        binmode( $temp );

        print $temp
            pack( 'VVVV', $self->characters, 0, $self->width, $self->height );
        for my $char ( @{ $self->chars } ) {
            print $temp pack( 'C*', split( //, sprintf( '%08b', $_ ) ) )
                for @$char;
        }
        close $temp;

        return GD::Font->load( $temp->filename );
}

1;
