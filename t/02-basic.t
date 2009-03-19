use Test::More tests => 6;

use strict;
use warnings;

use_ok( 'Math::Base36', qw( :all ) );

use Math::BigInt;

my $num = '3297';
my $b36 = '2JL';

is( encode_base36( $num ),                  $b36, 'encode' );
is( decode_base36( $b36 ),                  $num, 'decode' );
is( decode_base36( encode_base36( $num ) ), $num, 'eat our own dogfood' );
is( decode_base36( 'ZZZZZZZZZZZZZZZZZZZZZZZZZ' ),
    Math::BigInt->new( '808281277464764060643139600456536293375' ),
    'large number'
);

eval { decode_base36( '(INVALID)' ); };
ok( $@, 'invalid base36 numbers throw errors' );

