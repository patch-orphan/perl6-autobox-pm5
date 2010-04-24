use strict;
use warnings;
use Perl6::Autobox;
use Test::More tests => 12;

# L<S32::Str/Str/=item chomp>

{
    my $foo = "foo\n";
    $foo->chomp;
    is $foo, "foo\n", 'our variable was not yet chomped';

    $foo = $foo->chomp;
    is $foo, 'foo', 'our variable is chomped correctly';

    $foo = $foo->chomp;
    is $foo, 'foo', 'our variable is chomped again with no effect';
}

{
    my $foo = "foo\n\n";
    $foo = $foo->chomp;
    is $foo, "foo\n", 'our variable is chomped correctly';

    $foo = $foo->chomp;
    is $foo, 'foo', 'our variable is chomped again correctly';

    $foo = $foo->chomp;
    is $foo, 'foo', 'our variable is chomped again with no effect';
}

{
    my $foo = "foo\nbar\n";
    $foo = $foo->chomp;
    is $foo, "foo\nbar", 'our variable is chomped correctly';

    $foo = $foo->chomp;
    is $foo, "foo\nbar", 'our variable is chomped again with no effect';
}

{
    my $foo = "foo\n ";
    $foo = $foo->chomp;
    is $foo, "foo\n ", 'our variable is chomped with no effect';
}

{
    my $foo = "foo\n\n";
    my $chomped = $foo->chomp;
    is $foo,     "foo\n\n", 'chomp has no effect on the original string';
    is $chomped, "foo\n",   'chomp returns correctly chomped value';

    $chomped = $chomped->chomp;
    is $chomped, 'foo', 'chomp returns correctly chomped value again';
}
