package Math::Base36;

use strict;
use warnings;

use base qw( Exporter );

use Math::BigInt qw(:constant);

our %EXPORT_TAGS = ( 'all' => [ qw(encode_base36 decode_base36) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{ 'all' } } );

our $VERSION = '0.05';

sub decode_base36 {
    my $base36 = uc( shift );
    die 'Invalid base36 number' unless $base36 =~ m{[0-9A-Z]+};

    my ( $result, $digit ) = ( 0, 0 );
    for my $char ( split( //, reverse $base36 ) ) {
        my $value = $char =~ m{\d} ? $char : ord( $char ) - 55;
        $result += $value * ( 36**$digit++ );
    }

    return $result;
}

sub encode_base36 {
    my ( $number, $padlength ) = @_;
    $padlength ||= 0;

    die 'Invalid base10 number'  if $number    =~ m{\D};
    die 'Invalid padding length' if $padlength =~ m{\D};

    return 0 if $number == 0;

    my $result = '';
    while ( $number ) {
        my $remainder = $number % 36;
        $result .= $remainder <= 9 ? $remainder : chr( 55 + $remainder );
        $number = int $number / 36;
    }

    return '0' x ( $padlength - length $result ) . reverse( $result );
}

1;

__END__

=head1 NAME

Math::Base36 - Encoding and decoding of base36 strings

=head1 SYNOPSIS

  use Math::Base36 ':all';

  $b36 = encode_base36( $number );
  $number = decode_base36( $b36, $padlength );

=head1 DESCRIPTION

This module converts to and from Base36 numbers (0..9 - A..Z)

It was created because of an article/challenge in "The Perl Review"

=head1 METHODS

=head2 encode_base36( $number, [$padlength] )

Accepts a unsigned int and returns a Base36 string representation of the
number. optionally zero-padded to $padlength.

=head2 decode_base36( $b36 )

Accepts a base36 string and returns a Base10 string representation of the
number.

=head1 AUTHOR

Rune Henssel E<lt>perl@henssel.dkE<gt>

=head1 MAINTAINER 

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2002 by Rune Henssel

Copyright 2007 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
