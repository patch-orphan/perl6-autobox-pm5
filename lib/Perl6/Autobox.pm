package Perl6::Autobox;

use 5.008;
use strict;
use warnings;

require Perl6::Autobox::Str;

use base 'autobox';

our $VERSION = '0.01';

sub import {
    shift->SUPER::import(
        STRING => 'Perl6::Autobox::Str',
    );
}

1;

__END__

=head1 NAME

Perl6::Autobox - Call Perl 6 inspired methods on native Perl 5 datatypes

=head1 VERSION

This document describes Perl6::Autobox version 0.01.

=head1 SYNOPSIS

    use Perl6::Autobox;

    'foo bar baz'->comb(qr/[aeiou]+/);  # ('oo', 'a', 'a')

    { a => 1, b => 2 }->fmt('%s: %d', '; ');  # "a: 1; b: 2"

    [ ['a', 'b'], [1, 2] ]->crosswith('.');  # ('a1', 'a2', 'b1', 'b2')

=head1 DESCRIPTION

This module provides autoboxed methods inspired by Perl 6.  The goal is to
implement all of the core methods from the Perl 6 specification that would be
practical in Perl 5.  The relevant portions of the Perl 6 test suite are used
by this module with necessary modifications for Perl 5.

=head1 SEE ALSO

L<autobox>, L<autobox::Core>, L<Perl6ish>, L<Moose::Autobox>

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
