package Image::TextMode::Font;

use strict;
use warnings;

use base qw( Class::Data::Accessor );

__PACKAGE__->mk_classaccessor( width         => 0 );
__PACKAGE__->mk_classaccessor( height        => 0 );
__PACKAGE__->mk_classaccessor( chars         => [] );
__PACKAGE__->mk_classaccessor( intensity_map => [] );

sub new {
    my $class = shift;
    my $options = ( @_ == 1 && ref $_[ 0 ] eq 'HASH' ) ? $_[ 0 ] : { @_ };

    my $self = bless $options, $class;

    return $self;
}

sub new_from_raw_data {
    my ( $class, $data, $height ) = @_;
    my @chars;

    for ( 0 .. ( length( $data ) / $height ) - 1 ) {
        push @chars,
            [ unpack( 'C*', substr( $data, $_ * $height, $height ) ) ];
    }

    return $class->new(
        {   width         => 8,
            height        => $height,
            chars         => \@chars,
            intensity_map => []
        }
    );
}

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
    my $self = shift;
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
