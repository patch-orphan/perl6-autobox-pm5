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

Perl6::Autobox - XXX

=head1 VERSION

This document describes Perl6::Autobox version 0.01.

=head1 SYNOPSIS

    use Perl6::Autobox;

=head1 DESCRIPTION

XXX

=head1 SEE ALSO

L<autobox>, L<autobox::Core>, L<Perl6ish>, L<Moose::Autobox>

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
