use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $subscription_type_rs = shift->schema->resultset('SubscriptionType');

    $subscription_type_rs->populate([
        ['description', 'last_update_id', 'subscription_type_id'],
        ['subscription', 'dbseed', 1],
        ['trial', 'dbseed', 2],
        ['gratis', 'dbseed', 3],
    ]);
};
