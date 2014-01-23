#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';
use SAMS::Schema;

my $db = SAMS::Schema->connect(
    'dbi:Pg:dbname=mikef-sams-2',
    'mikef',
);

$db->deploy({
    add_drop_table => 1,
});
