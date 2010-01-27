use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Image::TextMode::Renderer::GD;

my @corpus = (
    {
        input  => '42_WOLVR.XB',
        class  => 'XBin',
        output => 'xbin',
    },
    
);

my $renderer = Image::TextMode::Renderer::GD->new;

for my $work ( @corpus ) {
    my $class = 'Image::TextMode::Format::' . $work->{ class };
    eval "require $class;";
    
    my $input = $class->new;
    $input->read( 'input/' . $work->{ input }, $work->{ readopts } );

    {
        open( my $fh, '>', 'output/' . $work->{ output } . '.png' );
        $renderer->fullscale( $input, $work->{ renderopts } );
        close $fh;
    }

    {
        open( my $fh, '>', 'output/' . $work->{ output } . '_t.png' );
        $renderer->thumbnail( $input, $work->{ renderopts } );
        close $fh;
    }
}
