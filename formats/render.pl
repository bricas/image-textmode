use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

my( $format, $file ) = @ARGV;

my $package = "Image\::TextMode\::Format\::${format}";
eval "use $package;";
use Image::TextMode::Renderer::GD;

my $img = $package->new;
$img->read( $file );

#$img->read( $file, { width => 202 } );
#use Data::Dumper; print Dumper $img->sauce; exit;
my $gd = Image::TextMode::Renderer::GD->new;
print $gd->fullscale( $img );
#print $gd->thumbnail( $img, { zoom => 2 } );
