use strict;
use warnings;
use Perl6::Autobox;
use Test::More tests => 4;

# L<S32::Str/Str/"=item chop">

my $str = 'foo';
is $str->chop, 'fo',  'o removed';
is $str,       'foo', 'original string unchanged';

is 'bar'->chop, 'ba', 'chop on string literal';
is ''->chop,    '',   'chop on empty string literal';
