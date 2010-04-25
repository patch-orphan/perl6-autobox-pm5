use strict;
use warnings;
use utf8;
use charnames ':full';
use Perl6::Autobox;
use Test::More tests => 10;

# L<S32::Str/Str/capitalize>

is ''->capitalize,              '',               "''->capitalize works";
is 'puGS Is cOOl!'->capitalize, 'Pugs Is Cool!', "'...'->capitalize works";

my $a = '';
is $a->capitalize,         '',               'capitalize empty string';
$a = 'puGS Is cOOl!';
is $a->capitalize,         'Pugs Is Cool!',  'capitalize string works';
is $a,                     'puGS Is cOOl!',  'original string not touched';
is 'ab cD Ef'->capitalize, 'Ab Cd Ef',       'works on ordinary string';

# Non-ASCII chars:
is 'äöü abcä'->capitalize, 'Äöü Abcä', 'capitalize works on non-ASCII chars';

# graphemes results
is(
    "a\N{COMBINING DIAERESIS}üö abcä"->capitalize,
    "A\N{COMBINING DIAERESIS}üö Abcä",
    'capitalize on string with grapheme without precomposed'
);
is(
    "a\N{COMBINING DOT ABOVE}\N{COMBINING DOT BELOW} bc"->capitalize,
    "A\N{COMBINING DOT ABOVE}\N{COMBINING DOT BELOW} Bc",
    'capitalize on string with grapheme without precomposed'
);
    
SKIP: {
    skip 'int->capitalize not implemented', 1;

    is 0->capitalize, '0', 'capitalize on Int';
}
