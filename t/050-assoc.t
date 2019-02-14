#!perl6

use v6;
use Test;

use JSON::Fast;

use META6;

my IO::Path $data-dir = $*PROGRAM.parent.add("data");

my IO::Path $meta-path = $data-dir.add('META6.json');

my $obj;

lives-ok { $obj = META6.new(file => $meta-path) }, "load META.info";

is $obj.version, '0.0.1', "just check version";
is $obj<version>, '0.0.1', 'Hash get good version';
is $obj<version perl>, '0.0.1 6', 'Hash get list of keys';

is $obj<version>:exists, True, 'Hash key exists';
is $obj<isnthere>:exists, False, 'Hash key does not exist';

lives-ok { $obj<isnthere> = 'foo' }, "set non-existent attribute";

$obj<version> = v0.0.2;
is $obj<version>, '0.0.2', 'Hash set good version';

is $obj<support><source>, 'git://github.com/jonathanstowe/JSON-Marshal.git', 'Support supports assoc too';
$obj<support><source> = 'spicy';
is $obj<support><source>, 'spicy', 'Support is writable';

# doesn't work yet
#$obj<version perl> = v0.0.3, 7;
#is $obj<version perl>, '0.0.3 7', 'Hash set list of keys';

done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
