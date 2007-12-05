use inc::Module::Install 0.68;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Math/Base36.pm > README' );
}

name 'Math-Base36';
perl_version '5.006';
all_from 'lib/Math/Base36.pm';

requires 'Math::BigInt' => '1.60';

test_requires 'Test::More';

auto_install;
WriteAll;
