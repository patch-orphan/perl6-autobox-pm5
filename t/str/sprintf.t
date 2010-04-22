use v6;

use Test;

plan 45;

# L<S32::Str/Str/"identical to" "C library sprintf">

is sprintf("Hi"),                 "Hi",     "sprintf() works with zero args";
#?rakudo skip 'calling positional params by name'
is sprintf(:format("RESEARCH => Robots Eagerly Sailing Epic Artificial Rhythmic Cyclical Homonyms")),                 "RESEARCH => Robots Eagerly Sailing Epic Artificial Rhythmic Cyclical Homonyms",     "sprintf() works with named argument";
is sprintf("%%"),                 "%",      "sprintf() escapes % correctly";
is sprintf("%03d",      3),       "003",    "sprintf() works with one arg";
is sprintf("%03d %02d", 3, 1),    "003 01", "sprintf() works with two args";
is sprintf("%d %d %d",  3,1,4),   "3 1 4",  "sprintf() works with three args";
is sprintf("%d%d%d%d",  3,1,4,1), "3141",   "sprintf() works with four args";

ok(eval('sprintf("%b",1)'),                  'eval of sprintf() with %b');

is sprintf("%04b",3),             '0011',   '0-padded sprintf() with %b';
is sprintf("%4b",3),              '  11',   '" "-padded sprintf() with %b';
is sprintf("%b",30),              '11110',  'longer string, no padding';
is sprintf("%2b",30),             '11110',  'padding specified, not needed';
is sprintf("%03b",7),             '111',    '0 padding, longer string';
is sprintf("%b %b",3,3),          '11 11',  'two args %b';

is sprintf('%c', 97),             'a',      '%c test';
is sprintf('%s', 'string'),       'string', '%s test';

is sprintf('%d', 12),             '12',     'simple %d';
is sprintf('%d', -22),            '-22',    'negative %d';
is sprintf('%04d', 32),           '0032',   '0-padded %d';
is sprintf('%04d', -42),          '-042',   '0-padded negative %d';
is sprintf('%i', -22),            '-22',    'negative %i';
is sprintf('%04i', -42),          '-042',   '0-padded negative %i';

is sprintf('%u', 12),             '12',     'simple %u';
is sprintf('%u', 22.01),          '22',     'decimal %u';
is sprintf('%04u', 32),           '0032',   '0-padded %u';
is sprintf('%04u', 42.6),         '0042',   '0-padded decimal %u';

is sprintf('%o', 12),             '14',     'simple %o';
is sprintf('%o', 22.01),          '26',     'decimal %o';
is sprintf('%03o', 32),           '040',    '0-padded %o';
is sprintf('%03o', 42.6),         '052',    '0-padded decimal %o';

is sprintf('%x', 12),             'c',      'simple %x';
is sprintf('%x', 22.01),          '16',     'decimal %x';
is sprintf('%03x', 32),           '020',    '0-padded %x';
is sprintf('%03x', 42.6),         '02a',    '0-padded decimal %x';
# tests for %X
is sprintf('%X', 12),             'C',      'simple %X';
is sprintf('%03X', 42.6),         '02A',    '0-padded decimal %X';

# L<S32::Str/"Str"/"The special directive, %n does not work in Perl 6">
#?rakudo 2 todo "%n and %p doesn't yet throw exception - but should they, or just Failure?"
dies_ok(sub {my $x = sprintf('%n', 1234)}, '%n dies (Perl 5 compatibility)');
dies_ok(sub {my $x = sprintf('%p', 1234)}, '%p dies (Perl 5 compatibility)');

is sprintf('%s', NaN),              NaN,    'sprintf %s handles NaN';
is sprintf('%s', -NaN),             NaN,    'sprintf %s handles NaN';
is sprintf('%s', Inf),              Inf,    'sprintf %s handles Inf';
is sprintf('%s', -Inf),            -Inf,    'sprintf %s handles Inf';

lives_ok {sprintf "%s"}, 'missing sprintf string argument';
ok sprintf("%s") ~~ Failure, 'missing sprintf string argument';

#?rakudo skip 'RT #60672'
{
my $fmtd;
eval q/$fmtd =
    sprintf "%d%C is %d digits long",
        1234,
        sub ($s, @args is rw) { @args[2] = $s.elems },
        0;
/;
is $fmtd, '1234 is 4 digits long', 'Implementation of S29 sprintf %C format'
}

# vim: ft=perl6
