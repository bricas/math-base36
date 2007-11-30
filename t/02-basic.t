use Test::Mode tests => 5;

use strict;
use warnings;

use_ok( 'Math::Base36', qw( :all ) );

my $num = '3297';
my $b36 = '2JL';

ok(encode_base36($num) eq $b36);
ok(decode_base36($b36) == $num);
ok(decode_base36(encode_base36($num)) == $num);
ok(decode_base36('ZZZZZZZZZZZZZZZZZZZZZZZZZ') == 808281277464764060643139600456536293375 );


