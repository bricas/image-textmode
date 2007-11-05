use inc::Module::Install 0.68;

if( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Image/TextMode.pm > README' );
}

name 'Image-TextMode';
all_from 'lib/Image/TextMode.pm';

requires 'Class::Accessor';

test_requires 'Test::More';

auto_install;
WriteAll;
