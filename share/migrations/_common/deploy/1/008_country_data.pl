use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $country_rs = shift->schema->resultset('Country');

    $country_rs->populate([
        ['country_id', 'last_update_id', 'name', 'territory'],
        ['gb', 'dbseed', 'United Kingdom', 'ROW'],
    ]);
};
