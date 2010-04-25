use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 14;

# L<S32::Str/"Str"/=item uc>

is 'Hello World'->uc, 'HELLO WORLD', 'simple';
is ''->uc,            '',            'empty string';
is 'åäö'->uc,         'ÅÄÖ',         'some finnish non-ascii chars';
is 'äöü'->uc,         'ÄÖÜ',         'uc of German Umlauts';
is 'óòúù'->uc,        'ÓÒÚÙ',        'accented chars';
is 'HELL..'->lc->uc,  'HELL..',      'lc/uc test';

{
    my $x = 'Hello World';
    is $x->uc,            'HELLO WORLD', '$x->uc works';
    is 'Hello World'->uc, 'HELLO WORLD', "'Hello World'->uc works";
}

is 'ß'->uc,         'SS',        'uc of non-ascii chars may result in two chars';
is 'áéíöüóűőú'->uc, 'ÁÉÍÖÜÓŰŐÚ', 'uc on Hungarian vowels';

SKIP: {
    skip 'int->uc not implemented', 4;

    is 0->uc,      '0', 'uc on Int';
    is 0->ucfirst, '0', 'ucfirst on Int';
    is 0->lc,      '0', 'lc on Int';
    is 0->lcfirst, '0', 'lcfirst on Int';
}
