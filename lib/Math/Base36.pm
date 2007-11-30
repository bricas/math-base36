package Math::Base36;

require 5.005_62;

use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(encode_base36 decode_base36) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw( );

our $VERSION = '0.02';

my $_digits = '0123456789ABCDEFGHIJKLMNOPQRSTUVWZYX';

sub decode_base36 {
	require Math::BigInt;
	use Math::BigInt qw(:constant);
	my ($t, $i)  = 0;
	foreach(split //, reverse uc shift) {
		croak __PACKAGE__ ."::decode_base36 -- invalid base 36 digit: '$_'" unless index($_digits,$_) > 0;
		$_ = ord($_) - 55 unless /\d/; # Assume that 'A' is 65
		$t += $_ * (36 ** $i++);
	}
	return(substr($t,1));
}

sub encode_base36 {
	my $n = shift;
	my $p = shift || 0;
	croak __PACKAGE__ ."::encode_base36 -- non-nunmeric value: '$n'" unless $n =~/^\d+$/;
	croak __PACKAGE__ ."::encode_base36 -- invalid padding length: '$p'" unless $p =~/^\d+$/;
	my $s="";
	return(0) if $n == 0;
	while ( $n ) {
		my $v = $n % 36;
		if($v <= 9) {
			$s .= $v;
		} else {
			$s .= chr(55 + $v); # Assume that 'A' is 65
		}
		$n = int $n / 36;
	}
	return "0" x ($p - length($s)) . reverse($s);
}

1;
__END__

=head1 NAME

Math::Base36 - Encoding and decoding of base36 strings

=head1 SYNOPSIS

  use Math::Base36 ':all';

  $b36 = encode_base36($number);
  $number = decode_base36($b36,$padlength);

=head1 DESCRIPTION

This module converts to and from Base36 numbers (0..9 - A..Z)

It was created because of an article/challenge in "The Perl Review"

=head2 EXPORT

None by default.

=over 4

=item encode_base36($number,[$padlength])

Accepts a unsigned int and returns a Base36 string representation of the number. optionally zero-padded to $padlength.

=item  decode_base36($B36)

Accepts a base36 string and returns a Base10 string representation of the number.

=back

=head1 AUTHOR

Rune Henssel, <perl@henssel.dk>

=head1 COPYRIGHT

Copyright (c) 2002 Rune Henssel. All rights reserved. This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut
