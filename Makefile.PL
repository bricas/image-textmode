use inc::Module::Install 0.68;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Image/TextMode.pm > README' );
}

perl_version '5.006';

name 'Image-TextMode';
all_from 'lib/Image/TextMode.pm';

requires 'Class::Data::Accessor';
requires 'File::SAUCE';
requires 'GD';
requires 'IO::File';
requires 'IO::String';

test_requires 'Test::More';

auto_install;
WriteAll;
