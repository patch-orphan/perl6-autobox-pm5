use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 28;

# L<S32::Str/Str/'=item rindex'>

# Simple - with just a single char
is 'Hello World'->rindex('H'),  0,      'One char, at beginning';
is 'Hello World'->rindex('l'),  9,      'One char, in the middle';
is 'Hello World'->rindex('d'), 10,      'One char, in the end';
ok !defined 'Hello World'->rindex('x'), 'One char, no match';

is 'Hello World'->rindex('l', 10), 9,      'One char, first match, pos @ end';
is 'Hello World'->rindex('l',  9), 9,      '- 1. match again, pos @ match';
is 'Hello World'->rindex('l',  8), 3,      '- 2. match';
is 'Hello World'->rindex('l',  2), 2,      '- 3. match';
ok !defined 'Hello World'->rindex('l', 1), '- no more matches';

# Simple - with a string
is 'Hello World'->rindex('Hello'),       0, 'Substr, at beginning';
is 'Hello World'->rindex('o W'),         4, 'Substr, in the middle';
is 'Hello World'->rindex('World'),       6, 'Substr, at the end';
is 'Hello World'->rindex('Hello World'), 0, 'Substr eq Str';
ok !defined 'Hello World'->rindex('low'),   'Substr, no match';

# Empty strings
is 'Hello World'->rindex(''), 11, 'Substr is empty';
is ''->rindex(''),             0, 'Both strings are empty';
is 'Hello'->rindex('',   3),   3, 'Substr is empty, pos within str';
is 'Hello'->rindex('',   5),   5, 'Substr is empty, pos at end of str';
is 'Hello'->rindex('', 999),   5, 'Substr is empty, pos > length of str';
ok !defined ''->rindex('Hello'),  'Only main-string is empty';

# More difficult strings
is 'abcdabcab'->rindex('abcd'), 0, 'Start-of-substr matches several times';

# unicode
is 'uuúuúuùù'->rindex('úuù'),                                     4, 'Accented chars';
is 'Ümlaut'->rindex('Ü'),                                         0, 'Umlaut';
is 'what are these « » unicode characters for ?'->rindex('uni'), 19, 'over unicode characters';

# on scalar variable
my $s = 'Hello World';
is $s->rindex('o'),     7, 'rindex on scalar variable';
is $s->uc->rindex('O'), 7, 'rindex on uc';

# ideas for deeper chained -> calls ?
is $s->lc->ucfirst->rindex('w'), 6, '->lc->ucfirst->rindex';

# rindex on non-strings
SKIP: {
    skip 'int->rindex not implemented', 1;

    ok 3459->rindex(5) == 2, 'rindex on integers';
}
