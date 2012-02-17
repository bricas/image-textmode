package Image::TextMode::Format;

use Moose;

require Class::MOP;
use Image::TextMode::Font::8x16;
use Image::TextMode::Palette::VGA;
use Image::TextMode::SAUCE;

=head1 NAME

Image::TextMode::Format - A base class for text mode file formats

=head1 DESCRIPTION

This is a base class for all textmode formats. It provides the basic
structure for reading and writing, plus provides some defaults for
common attributes (e.g. font and palette).

=head1 ACCESSORS

=over 4

=item * reader - an instance of a file reader

=item * writer - and instance of a file writer

=item * font - a font instance

=item * palette - a palette instance

=item * sauce - a SAUCE metadata object

=item * render_options - default options for use when rasterizing the data

=back

=cut

has 'reader' => (
    is         => 'ro',
    isa        => 'Image::TextMode::Reader',
    lazy_build => 1,
);

has 'writer' => (
    is         => 'ro',
    isa        => 'Image::TextMode::Writer',
    lazy_build => 1,
);

sub _build_reader {
    my ( $self ) = @_;
    return $self->_xs_or_not( 'Reader' );
}

sub _build_writer {
    my ( $self ) = @_;
    return $self->_xs_or_not( 'Writer' );
}

sub _xs_or_not {
    my ( $class, $type ) = @_;
    ( my $name = ( ref $class || $class ) ) =~ s{\bFormat\b}{$type}s;

    unless ( $ENV{ IMAGE_TEXTMODE_NOXS } ) {
        my $xs = $name . '::XS';
        my $result = eval { Class::MOP::load_class( $xs ); };
        if ( $result && !$@ ) { return $xs->new; }
    }

    Class::MOP::load_class( $name );
    return $name->new;
}

has 'font' => (
    is      => 'rw',
    isa     => 'Object',
    default => sub { Image::TextMode::Font::8x16->new }
);

has 'palette' => (
    is      => 'rw',
    isa     => 'Object',
    default => sub { Image::TextMode::Palette::VGA->new }
);

has 'sauce' => (
    is      => 'rw',
    isa     => 'Object',
    default => sub { Image::TextMode::SAUCE->new },
    handles => [ qw( author title group has_sauce ) ]
);

has 'render_options' =>
    ( is => 'rw', isa => 'HashRef', default => sub { {} } );

=head1 METHODS

=head2 new( %args )

Creates a new instance.

=head2 read( $file, \%options )

Proxies to the reader's C<read()> method.

=cut

sub read {    ## no critic (Subroutines::ProhibitBuiltinHomonyms)
    my ( $self, @rest ) = @_;
    $self->reader->read( $self, @rest );
}

=head2 write( $file, \%options )

Proxies to the writer's C<write()> method.

=cut

sub write {    ## no critic (Subroutines::ProhibitBuiltinHomonyms)
    my ( $self, @rest ) = @_;
    $self->writer->write( $self, @rest );
}

=head1 PROXIED METHODS

The following methods are proxies to C<sauce>.

=over 4

=item * author

=item * title

=item * group

=item * has_sauce

=back

=cut

no Moose;

__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008-2012 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
