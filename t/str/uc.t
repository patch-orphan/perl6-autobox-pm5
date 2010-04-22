use v6;

use Test;

plan 20;

# L<S32::Str/"Str"/=item uc>

is(uc("Hello World"), "HELLO WORLD", "simple");
is(uc(:string("station")), "STATION", "uc with named argument");
is(uc(""), "", "empty string");
{
    is(uc("åäö"), "ÅÄÖ", "some finnish non-ascii chars");
    is(uc("äöü"), "ÄÖÜ", "uc of German Umlauts");
    is(uc("óòúù"), "ÓÒÚÙ", "accented chars");
}
is(uc(lc('HELL..')), 'HELL..', "uc/lc test");

{
    $_ = "Hello World";
    my $x = .uc;
    is $x, "HELLO WORLD", 'uc uses the default $_';
}

{
    my $x = "Hello World";
    is $x.uc, "HELLO WORLD", '$x.uc works';
    is "Hello World".uc, "HELLO WORLD", '"Hello World".uc works';
}

## Bug: GERMAN SHARP S ("ß") should uc() to "SS", but it doesn't
## Compare with: perl -we 'use utf8; print uc "ß"'
#
# XXX newest Unicode release has an upper-case ß codepoint - please
# clarify if this should be used instead. Commenting the test so far.
#
# Unicode 5.1.0 SpecialCasing.txt has 00DF -> 0053 0053
# nothing maps to 1E9E, the new "capital sharp s"
# so I think this is right -rhr
is(uc("ß"), "SS", "uc() of non-ascii chars may result in two chars");

{
    is("áéíöüóűőú".uc, "ÁÉÍÖÜÓŰŐÚ", ".uc on Hungarian vowels");
}

is ~(0.uc),         ~0, '.uc on Int';
is ~(0.ucfirst),    ~0, '.ucfirst on Int';
is ~(0.lc),         ~0, '.lc on Int';
is ~(0.lcfirst),    ~0, '.lcfirst on Int';

#?rakudo todo "uc/lc tests fail on roles"
#?DOES 4
{
    role A {
        has $.thing = 3;
    }
    for <uc lc ucfirst lcfirst> -> $meth {
        my $str = "('Nothing much' but A).$meth eq 'Nothing much'.$meth";
        ok eval($str), $str;
    }
}

# vim: ft=perl6
