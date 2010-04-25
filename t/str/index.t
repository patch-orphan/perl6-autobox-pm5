use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 31;

# L<S32::Str/Str/"=item index">

# Type of return value
ok !defined 'abc'->index('d'), 'index failure is undef';

# Simple - with just a single char
is 'Hello World'->index('H'),  0,      'One char, at beginning';
is 'Hello World'->index('l'),  2,      'One char, in the middle';
is 'Hello World'->index('d'), 10,      'One char, in the end';
ok !defined 'Hello World'->index('x'), 'One char, no match';

is 'Hello World'->index('l', 0), 2,        'One char, find first match, pos = 0';
is 'Hello World'->index('l', 2), 2,        '- 1. match again, pos @ match';
is 'Hello World'->index('l', 3), 3,        '- 2. match';
is 'Hello World'->index('l', 4), 9,        '- 3. match';
ok !defined 'Hello World'->index('l', 10), '- no more matches';

# Simple - with a string
is 'Hello World'->index('Hello'),       0, 'Substr, at beginning';
is 'Hello World'->index('o W'),         4, 'Substr, in the middle';
is 'Hello World'->index('World'),       6, 'Substr, at the end';
is 'Hello World'->index('Hello World'), 0, 'Substr eq Str';
ok !defined 'Hello World'->index('low'),   'Substr, no match';

# Empty strings
is 'Hello World'->index(''), 0, 'Substr is empty';
is ''->index(''),            0, 'Both strings are empty';
is 'Hello'->index('',   3),  3, 'Substr is empty, pos within str';
is 'Hello'->index('',   5),  5, 'Substr is empty, pos at end of str';
is 'Hello'->index('', 999),  5, 'Substr is empty, pos > length of str';
ok !defined ''->index('Hello'), 'Only main-string is empty';

# More difficult strings
is 'ababcabcd'->index('abcd'), 5, 'Start-of-substr matches several times';

# unicode
is 'uuúuúuùù'->index('úuù'), 4, 'Accented chars';
is 'Ümlaut'->index('Ü'),     0, 'Umlaut';

# work on variables
my $a = 'word';
is $a->index('o'), 1, 'index on scalar variable';

my @a = qw< Hello World >;
is $a[0]->index('l'), 2, 'index on array element';

# index on junctions, maybe this should be moved to t/junctions/ ?
SKIP: {
    skip '@list->any not implemented', 2;

    my $j = [qw< Hello World >]->any;
    ok $j->index('l') == 2, 'index on junction';
    ok $j->index('l') == 3, 'index on junction';
}

SKIP: {
    skip 'int->index not implemented', 1;

    ok 1234->index(3) == 2, 'index on non-strings (here: Int)';
}

{
    my $s = '1023';
    is substr( $s, $s->index('0') ), '023', "Str->index('0') works";
    is substr( $s, $s->index(0)   ), '023', 'Str->index(0) works';
}
