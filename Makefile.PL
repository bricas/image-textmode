use inc::Module::Install 0.95;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Image/TextMode.pm > README' );
}

perl_version '5.008';

name 'Image-TextMode';
all_from 'lib/Image/TextMode.pm';

requires 'Moose' => '0.51';
requires 'GD'    => '2.30';
requires 'Module::Pluggable';
requires 'Getopt::Long';
requires 'Pod::Usage';
requires 'File::ShareDir';

test_requires 'Test::More';
tests_recursive;

install_script 'textmode2png';
install_share;

repository 'http://github.com/bricas/image-textmode';

WriteAll;
