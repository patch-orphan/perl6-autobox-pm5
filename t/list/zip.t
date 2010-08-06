use strict;
use warnings;
use Test::More tests => 8;

is_deeply [[qw< a b >], [qw< 1 2 >]]->zip,          [qw< a 1 b 2 >], 'non-meta zip produces expected result';
is_deeply [[1, 2, 3], [2, 4]]->zipwith('**'),       [1, 16],         'zip-power works';
is_deeply [[qw< a b >], [qw< 1 2 >]]->zipwith('.'), [qw< a1 b2 >],   'zip-concat produces expected result';
is_deeply [[1, 2], [3, 4]]->zipwith('*'),           [3, 8],          'zip-product works';
is_deeply [[1, 2], [3, 2, 0]]->zipwith('<=>'),      [-1, 0],         'zip-spaceship works';

# tests for non-list arguments
is_deeply [1, [3, 4]]->zipwith('*'), [3], 'zip-product works with scalar left side';
is_deeply [[1, 2], 3]->zipwith('*'), [3], 'zip-product works with scalar right side';
is_deeply [1,      3]->zipwith('*'), [3], 'zip-product works with scalar both sides';
