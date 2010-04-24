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
