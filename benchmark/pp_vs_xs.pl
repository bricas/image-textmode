use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Image::TextMode::Format::ANSI;
use Image::TextMode::Reader::ANSI;
use Image::TextMode::Reader::ANSI::XS;

use Benchmark;

my( $file ) = @ARGV;

my $a_pp = Image::TextMode::Format::ANSI->new;
my $a_xs = Image::TextMode::Format::ANSI->new;

my $pp = Image::TextMode::Reader::ANSI->new;
my $xs = Image::TextMode::Reader::ANSI::XS->new;

open( my $fh, $file );

my $r = Benchmark::timethese(-10, {
    'PP' => sub { $pp->_read( $a_pp, $fh, {} ) },
    'XS' => sub { $xs->_read( $a_xs, $fh, {} ) },
});

close( $fh );

Benchmark::cmpthese( $r );
