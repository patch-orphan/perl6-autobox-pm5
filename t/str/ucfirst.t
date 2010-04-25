use strict;
use warnings;
use utf8;
use Perl6::Autobox;
use Test::More tests => 4;

# L<S32::Str/Str/ucfirst>

is 'hello world'->ucfirst, 'Hello world', 'simple';
is ''->ucfirst,            '',            'empty string';
is 'üüüü'->ucfirst,        'Üüüü',        'umlaut';
is 'óóóó'->ucfirst,        'Óóóó',        'accented chars';
