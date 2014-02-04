use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $group_name_rs = shift->schema->resultset('GroupName');

    $group_name_rs->populate([
        ['group_name_id', 'last_update_id', 'privilege_level'],
        ['administrator', 'dbseed', 20],
        ['ip-editor', 'dbseed', 30],
        ['ss-limited', 'dbseed', 10],
        ['public', 'dbseed', 0],
    ]);
};
