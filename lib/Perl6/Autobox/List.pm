package Perl6::Autobox::List;

use 5.008;
use strict;
use warnings;
use List::Util qw( min reduce );

our $VERSION = '0.01';

my %ops = (
    '**'  => sub { $_[0] **  $_[1] },
    '=~'  => sub { $_[0] =~  $_[1] },
    '!~'  => sub { $_[0] !~  $_[1] },
    '*'   => sub { $_[0] *   $_[1] },
    '/'   => sub { $_[0] /   $_[1] },
    '%'   => sub { $_[0] %   $_[1] },
    'x'   => sub { $_[0] x   $_[1] },
    '+'   => sub { $_[0] +   $_[1] },
    '-'   => sub { $_[0] -   $_[1] },
    '.'   => sub { $_[0] .   $_[1] },
    '<'   => sub { $_[0] <   $_[1] },
    '>'   => sub { $_[0] >   $_[1] },
    '<='  => sub { $_[0] <=  $_[1] },
    '>='  => sub { $_[0] >=  $_[1] },
    'lt'  => sub { $_[0] lt  $_[1] },
    'gt'  => sub { $_[0] gt  $_[1] },
    'le'  => sub { $_[0] le  $_[1] },
    'ge'  => sub { $_[0] ge  $_[1] },
    '=='  => sub { $_[0] ==  $_[1] },
    '!='  => sub { $_[0] !=  $_[1] },
    '<=>' => sub { $_[0] <=> $_[1] },
    'eq'  => sub { $_[0] eq  $_[1] },
    'ne'  => sub { $_[0] ne  $_[1] },
    'cmp' => sub { $_[0] cmp $_[1] },
    '&'   => sub { $_[0] &   $_[1] },
    '|'   => sub { $_[0] |   $_[1] },
    '&&'  => sub { $_[0] &&  $_[1] },
    '||'  => sub { $_[0] ||  $_[1] },
    '..'  => sub { $_[0] ..  $_[1] },
    ','   => sub { [ ref $_[0] ? @{$_[0]} : $_[0] ,  $_[1] ] },
    '=>'  => sub { [ ref $_[0] ? @{$_[0]} : $_[0] => $_[1] ] },
    'and' => sub { $_[0] and $_[1] },
    'or'  => sub { $_[0] or  $_[1] },
    'xor' => sub { $_[0] xor $_[1] },
);

sub zip {
    my @lists = map { ref $_ ? $_ : [$_] } @{$_[0]};
    my @zip;

    for my $i (0 .. min map { $#{$_} } @lists) {
        push @zip, map { @{$_}[$i] } @lists;
    }

    return wantarray ? @zip : \@zip;
}

sub zipwith {
    my ($lists, $op) = @_;
    my @lists = map { ref $_ ? $_ : [$_] } @{$lists};
    my @zip;

    return unless $op;

    for my $i (0 .. min map { $#{$_} } @lists) {
        $zip[$i] ||= [];
        push @{$zip[$i]}, map { @{$_}[$i] } @lists;
    }

    for my $list (@zip) {
        $list = reduce { $ops{$op}->($a, $b) } @{$list};
    }

    return wantarray ? @zip : \@zip;
}

1;

__END__

=head1 NAME

Perl6::Autobox::List - XXX

=head1 VERSION

This document describes Perl6::Autobox::List version 0.01.

=head1 SYNOPSIS

    use Perl6::Autobox;

=head1 DESCRIPTION

XXX

=head1 METHODS

=over

=item zip

XXX

=item zipwith

XXX

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
