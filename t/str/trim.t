use strict;
use warnings;
use Perl6::Autobox;
use Test::More tests => 14;

# L<S32::Str/Str/=item trim>

{
    my $foo = "foo  \n";
    $foo->trim;;
    is $foo, "foo  \n", 'our variable was not yet trimmed';

    $foo = $foo->trim;
    is $foo, 'foo', 'our variable is trimmed correctly';

    $foo =  "\t   \t  \tfoo   \t\t  \t \n";
    $foo = $foo->trim;
    is $foo, 'foo', 'our variable is trimmed again';
}

is ''->trim,    '',  'trimming an empty string gives an empty string';
is 'a'->trim,   'a', 'trimming one character string, no spaces, works';
is ' a'->trim,  'a', 'trimming one character string preceded by space works';
is 'a '->trim,  'a', 'trimming one character string followed by space works';
is ' a '->trim, 'a', 'trimming one character string surrounded by spaces works';

{
    my $foo = ' foo bar ';
    $foo = $foo->trim;
    is $foo, 'foo bar', 'our variable is trimmed correctly';

    $foo = $foo->trim;
    is $foo, 'foo bar', 'our variable is trimmed again with no effect';
}

{
    my $foo = "foo\n ";
    $foo = $foo->trim;
    $foo = $foo->trim;
    $foo = $foo->trim;
    is $foo, 'foo', 'our variable can be trimmed multiple times';
}

{
    my $foo = "foo\n\n";
    my $trimmed = $foo->trim;
    is $foo,     "foo\n\n", 'trim has no effect on the original string';
    is $trimmed, 'foo',     'trim returns correctly trimmed value';

    $trimmed = $trimmed->trim;
    is $trimmed, 'foo', 'trim returns correctly trimmed value again';
}
