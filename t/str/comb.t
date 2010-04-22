use v6;

use Test;

plan *;

# L<S32::Str/Str/=item comb>

# comb Str
is "".comb, (), 'comb on empty string';
is "a".comb, <a>, 'default matcher on single character';
is "abcd".comb, <a b c d>, 'default matcher and limit';

is "a\tb".comb, ('a', "\t", 'b'), 'comb on string with \t';
is "a\nb".comb, ('a', "\n", 'b'), 'comb on string with \n';

is "äbcd".comb, <ä b c d>, 'comb on string with non-ASCII letter';

#?rakudo todo 'graphemes not implemented'
is "a\c[COMBINING DIAERESIS]b".comb, ("ä", "b",), 'comb on string with grapheme precomposed';
#?rakudo skip 'graphemes really not implemented'
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]b".comb,
    ("a\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "b", ),
    "comb on string with grapheme non-precomposed");

#?pugs todo 'feature'
is "abcd".comb(:limit(2)), <a b>, 'default matcher with supplied limit';

#?pugs skip "todo: Str.comb"
{
    my Str $hair = "Th3r3 4r3 s0m3 numb3rs 1n th1s str1ng";
    is $hair.comb(/\d+/), <3 3 4 3 0 3 3 1 1 1>, 'no limit returns all matches';
    #?rakudo skip 'calling positional args by name'
    is comb(:input($hair), /\d+/), <3 3 4 3 0 3 3 1 1 1>, 'comb works with named argument for input';
    is $hair.comb(/\d+/, -10), (), 'negative limit returns no matches';
    is $hair.comb(/\d+/, 0), (), 'limit of 0 returns no matches';
    is $hair.comb(/\d+/, 1), <3>, 'limit of 1 returns 1 match';
    is $hair.comb(/\d+/, 3), <3 3 4>, 'limit of 3 returns 3 matches';
    is $hair.comb(/\d+/, 1000000000), <3 3 4 3 0 3 3 1 1 1>, 'limit of 1 billion returns all matches quickly';
}

#?rakudo skip "Null PMC in Rakudo-ng"
{
    is "a ab bc ad ba".comb(/«a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

{
    is "a ab bc ad ba".comb(/<< a\S*/), <a ab ad>,
        'match for any a* words';
    is "a ab bc ad ba".comb(/\S*a\S*/), <a ab ad ba>,
        'match for any *a* words';
}

#?pugs todo 'feature'
is "a ab bc ad ba".comb(/\S*a\S*/, 2), <a ab>, 'matcher and limit';

is "forty-two".comb().join('|'), 'f|o|r|t|y|-|t|w|o', q{Str.comb(/./)};

ok("forty-two".comb() ~~ Positional, '.comb() returns something Positional' );

# comb a list

#?pugs todo 'feature'
#?rakudo skip "bad all around in Rakudo-ng"
is (<a ab>, <bc ad ba>).comb(m:Perl5/\S*a\S*/), <a ab ad ba>,
     'comb a list';

# needed: comb a filehandle

#?rakudo skip '.comb regressions'
{
    my @l = 'a23 b c58'.comb(/\w(\d+)/);
    is @l.join('|'), 'a23|c58', 'basic comb-without-matches sanity';
    isa_ok(@l[0], Str, 'first item is a Str');
    isa_ok(@l[1], Str, 'second item is a Str');
}

#?rakudo skip '.comb regressions'
{
    my @l = 'a23 b c58'.comb(/\w(\d+)/, :match);
    is @l.join('|'), 'a23|c58', 'basic comb-with-matches sanity';
    #?rakudo 2 skip "Type is incorrectly named Regex::Match in Rakudo-ng"
    isa_ok(@l[0], Match, 'first item is a Match');
    isa_ok(@l[1], Match, 'second item is a Match');
    is @l[0].from, 0, '.from of the first item is correct';
    is @l[0].to, 3, '.to of the first item is correct';
    is @l[1].from, 6, '.from of the second item is correct';
    is @l[1].to, 9, '.to of the second item is correct';    
}

# RT #66340
#?rakudo skip "bad all around in Rakudo-ng"
{
    my $expected_reason = rx/^'No applicable candidates '/;
    
    try { 'RT 66340'.comb( 1 ) };
    ok $! ~~ Exception, '.comb(1) dies';
    ok "$!" ~~ $expected_reason, '.comb(1) dies for the expected reason';

    my $calls = 0;
    try { 'RT 66340'.comb( { $calls++ } ) };
    is $calls, 0, 'code passed to .comb is not called';
    ok $! ~~ Exception, '.comb({...}) dies';
    ok "$!" ~~ $expected_reason, '.comb({...}) dies for the expected reason';
}

done_testing;

# vim: ft=perl6
