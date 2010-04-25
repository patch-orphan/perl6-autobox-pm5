use strict;
use warnings;
use utf8;
use charnames ':full';
use Perl6::Autobox;
use Test::More tests => 13;

# handle utf8 output
my $builder = Test::More->builder;
binmode $builder->output,         ':utf8';
binmode $builder->failure_output, ':utf8';
binmode $builder->todo_output,    ':utf8';

# L<S32::Str/Str/=item flip>

is 'Pugs'->flip,          'sguP',          'as a function';
is ''->flip,              '',              'empty string';
is 'Hello World !'->flip, '! dlroW olleH', 'literal';

# On a variable
my $a = 'Hello World !';
is $a->flip,      '! dlroW olleH', 'with a Str variable';
is $a,            'Hello World !', 'flip should not be in-place';
is $a = $a->flip, '! dlroW olleH', 'after a = ->flip';

# Multiple iterations :
is 'Hello World !'->flip->flip, 'Hello World !', 'two flip in a row.';

# flip with unicode :
is 'ä€»«'->flip, '«»€ä', 'some unicode characters';

# graphemes
TODO: {
    local $TODO = '$grapheme->flip not implemented';

    is "a\N{COMBINING DIAERESIS}b"->flip, 'bä', 'grapheme precomposed';

    is(
        "a\N{COMBINING DOT ABOVE}\N{COMBINING DOT BELOW}b"->flip,
        "ba\N{COMBINING DOT ABOVE}\N{COMBINING DOT BELOW}",
        'grapheme without precomposed'
    );
}

SKIP: {
    skip 'int->flip not implemented', 2;

    is 234->flip, '432', 'flip on non-string';
    is 123->flip, '321', 'flip on non-strings';
}

{
    my $x = 'abc';
    $x = $x->flip;
    is $x, 'cba', 'in-place flip';
}
