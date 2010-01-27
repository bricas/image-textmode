use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Image::TextMode::Renderer::GD;

my @corpus = (
    {   input  => '42_WOLVR.XB',
        class  => 'XBin',
        output => 'xbin',
    },
    {   input      => '0994MEMB.CIA',
        class      => 'ANSI',
        output     => 'ans_ced',
        renderopts => { ced => 1 },
    },
    {   input      => 'AVE-AMI1.ASC',
        class      => 'ANSI',
        output     => 'asc_amiga',
        renderopts => { '_font' => 'Amiga' },
    },
    {   input  => 'bjasc101.asc',
        class  => 'ANSI',
        output => 'asc',
    },
    {   input  => 'dy-reviv.bin',
        class  => 'Bin',
        output => 'bin',
    },
    {   input      => 'HU-ERMAG.BIN',
        class      => 'Bin',
        readopts   => { width => 202 },
        output     => 'bin_icecolor',
        renderopts => { icecolor => 1 },
    },

    {   input  => 'JD-CH01.ANS',
        class  => 'ANSIMation',
        output => 'ansimation',
    },
    {   input  => 'LD-AF1.ANS',
        class  => 'ANSI',
        output => 'ans',
    },
    {   input      => 'LD-AF1.ANS',
        class      => 'ANSI',
        output     => 'ans_9th',
        renderopts => { '9th_bit' => 1 }
    },
    {   input  => 'MD-XMAS.IDF',
        class  => 'IDF',
        output => 'idf',
    },
    {   input  => 'RA-ROUTE.ANS',
        class  => 'ANSI',
        output => 'ans_80x50',
    },
    {   input  => 'US-NCPL1.ADF',
        class  => 'ADF',
        output => 'adf',
    },
    {   input  => 'zv_steve.tnd',
        class  => 'Tundra',
        output => 'tnd',
    },
);

my $renderer = Image::TextMode::Renderer::GD->new;

for my $work ( @corpus ) {
    my $class = 'Image::TextMode::Format::' . $work->{ class };
    eval "require $class;";

    printf "Rendering %s as %s ...\n", $work->{ input }, $work->{ output };

    my $input = $class->new;
    $input->read( 'input/' . $work->{ input }, $work->{ readopts } );

    my $renderopts = $work->{ renderopts } || {};

    if ( my $font = delete $renderopts->{ '_font' } ) {
        $font = 'Image::TextMode::Font::' . $font;
        eval "require $font;";
        $input->font( $font->new );
    }

    my $ext = $work->{ class } eq 'ANSIMation' ? '.gif' : '.png';

    {
        open( my $fh, '>', 'output/' . $work->{ output } . $ext );
        binmode( $fh );
        print $fh $renderer->fullscale( $input, $renderopts );
        close $fh;
    }

    {
        $renderopts->{ zoom } = 2;
        open( my $fh, '>', 'output/' . $work->{ output } . "_t${ext}" );
        binmode( $fh );
        print $fh $renderer->thumbnail( $input, $renderopts );
        close $fh;
    }
}
