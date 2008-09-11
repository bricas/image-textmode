package Image::TextMode::Format;

use Moose;

require Class::MOP;
use Image::TextMode::Font::8x16;
use Image::TextMode::Palette::VGA;
use Image::TextMode::SAUCE;
use Image::TextMode::Canvas;

=head1 NAME

Image::TextMode::Format - A base class for text mode file formats

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
    is      => 'ro',
    isa     => 'Image::TextMode::Reader',
    default => sub { shift->_xs_or_not( 'Reader' ) }
);

has 'writer' => (
    is      => 'ro',
    isa     => 'Image::TextMode::Writer',
    default => sub { shift->_xs_or_not( 'Writer' ) }
);

sub _xs_or_not {
    my ( $class, $type ) = @_;
    ( my $result = ( ref $class || $class ) ) =~ s{\bFormat\b}{$type};

    my $xs = $result . '::XS';
    eval { Class::MOP::load_class( $xs ); };
    return $xs->new if !$@;

    Class::MOP::load_class( $result );
    return $result->new;
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

sub read {
    my ( $self, @rest ) = @_;
    $self->reader->read( $self, @rest );
}

=head2 write( $file, \%options )

Proxies to the writer's C<write()> method.

=cut

sub write {
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

Copyright 2008 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;
