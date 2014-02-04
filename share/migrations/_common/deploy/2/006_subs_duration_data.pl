use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $subs_duration_rs = shift->schema->resultset('SubsDuration');

    $subs_duration_rs->populate([
        ['duration', 'grace_period', 'last_update_id', 'subs_duration_id'],
        ['3 years', '1 mon',  'dbseed', 2],
        ['5 years', '1 mon',  'dbseed', 3],
        ['30 days', '7 days', 'dbseed', 4],
    ]);
};
