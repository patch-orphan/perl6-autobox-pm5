use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 6;

# L<S32::Str/Str/lcfirst>

is 'HELLO WORLD'->lcfirst, 'hELLO WORLD', 'simple';
is ''->lcfirst,            '',            'empty string';
is 'ÜÜÜÜ'->lcfirst,        'üÜÜÜ',        'umlaut';
is 'ÓÓÓÓŃ'->lcfirst,       'óÓÓÓŃ',       'accented chars';

my $str = 'Some String';
is $str->lcfirst,           'some String',  'simple lcfirst on scalar variable';
is 'Other String'->lcfirst, 'other String', 'lcfirst on literal string';
