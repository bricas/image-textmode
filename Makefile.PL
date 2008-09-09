use inc::Module::Install 0.77;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Image/TextMode.pm > README' );
}

perl_version '5.008';

name 'Image-TextMode';
all_from 'lib/Image/TextMode.pm';

requires 'Moose' => '0.51';
requires 'GD'    => '2.30';
requires 'Module::Pluggable';
# add other prereqs

test_requires 'Test::More';

tests 't/*/*.t';
extra_tests;

WriteAll;
