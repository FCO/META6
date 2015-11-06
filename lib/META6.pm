use v6;

use JSON::Class;

# Need to import here to get the traits
import JSON::Marshal;
import JSON::Unmarshal;

class META6 does JSON::Class {

    multi method new(Str :$file!) {
        self.new(file => $file.IO);
    }

    multi method new(IO::Path :$file!) {
        self.new(file => $file.open);
    }

    multi method new(IO::Handle :$file!) {
        my $json = $file.slurp-rest;
        self.from-json($json);
    }

    class Resource {

    }

    class Support {
    }

    # cope with "v0.0.1"
    sub unmarsh-version(Str() $v) returns Version {
        my $ver = Version.new($v);
        if $ver.parts[0] eq 'v' {
            $ver.parts.shift;
        }
        $ver;
    }


    has Version     $.perl          is rw is marshalled-by('Str') is unmarshalled-by(&unmarsh-version);
    has Str         $.name          is rw;
    has Version     $.version       is rw is marshalled-by('Str') is unmarshalled-by(&unmarsh-version);
    has Str         $.description   is rw;
    has Str         @.authors       is rw;
    has Str         %.provides      is rw;
    has Str         @.depends       is rw;
    has Str         %.emulates      is rw;
    has Str         %.supersedes    is rw;
    has Str         %.superseded-by is rw;
    has Str         %.excludes      is rw;
    has Str         @.build-depends is rw;
    has Str         @.test-depends  is rw;
    has Resource    $.resource      is rw;
    has Support     $.support       is rw;
    has Bool        $.production    is rw;
    has Str         $.license       is rw;
    has Str         @.tags          is rw;

}

# vim: expandtab shiftwidth=4 ft=perl6
