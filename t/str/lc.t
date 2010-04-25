use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 11;

# L<S32::Str/Str/lc>

is 'hello world'->lc, 'hello world', 'lowercasing string which is already lowercase';
is 'Hello World'->lc, 'hello world', 'simple lc test';
is ''->lc,            '',            'empty string';
is 'ÅÄÖ'->lc,         'åäö',         'some finnish non-ascii chars';
is 'ÄÖÜ'->lc,         'äöü',         'lc of German Umlauts';
is 'ÓÒÚÙ'->lc,        'óòúù',        'accented chars';

SKIP: {
    skip '@list->lc not implemented', 1;

    is_deeply ['A'..'C']->lc, [qw< a b c >], 'lowercasing char-range';
}

{
    # test invocant syntax for lc
    my $x = 'Hello World';
    is $x->lc,            'hello world', '$x->lc works';
    is $x,                'Hello World', 'Invocant unchanged';
    is 'Hello World'->lc, 'hello world', "'Hello World'->lc works";
}

is 'ÁÉÍÖÜÓŰŐÚ'->lc, 'áéíöüóűőú', 'lc on Hungarian vowels';
