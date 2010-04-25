package Perl6::Autobox::Str;

use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';

sub chop { substr $_[0], 0, -1 }

sub chomp {
    my ($str) = @_;
    $str =~ s{ \n $}{}x;
    return $str;
}

sub lc      { CORE::lc      $_[0] }
sub lcfirst { CORE::lcfirst $_[0] }
sub uc      { CORE::uc      $_[0] }
sub ucfirst { CORE::ucfirst $_[0] }

1;

__END__

=head1 NAME

Perl6::Autobox::Str - XXX

=head1 VERSION

This document describes Perl6::Autobox::Str version 0.01.

=head1 SYNOPSIS

    use Perl6::Autobox;

=head1 DESCRIPTION

XXX

=head1 METHODS

=over

=item chop

Returns string with one Char removed from the end.

=item chomp

Returns string with one newline removed from the end.

=item lc

Returns the input string after converting each character to its lowercase
form, if uppercase.

=item lcfirst

Like C<lc>, but only affects the first character.

=item uc

Returns the input string after converting each character to its uppercase
form, if lowercase. This is not a Unicode "titlecase" operation, but a
full "uppercase".

=item ucfirst

Performs a Unicode "titlecase" operation on the first character of the string.

=back

=head1 SEE ALSO

L<Perl6::Autobox>

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
