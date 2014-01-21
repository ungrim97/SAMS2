use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $account_type_rs = shift->schema->resultset('AccountType');

    $account_type_rs->populate([
        ['account_type_id', 'description', 'is_account_group', 'is_subscription_group', 'last_update_id'],
        [4, 'Supplier', 1,  1,  'dbseed'],
        [6, 'Other', 1, 1, 'dbseed'],
        [1, 'Institution', 0, 0, 'dbseed'],
        [2, 'Individual', 0, 0, 'dbseed'],
        [3, 'Consortium', 1, 1, 'dbseed'],
        [5, 'Statistics Group', 1, 1, 'dbseed'],
        [7, 'Member', 0, 0, 'dbseed'],
        [8, 'Agent', 0, 0, 'dbseed'],
        [9, 'Corporation', 0, 0, 'dbseed'],
        [10, 'Local Church Missions', 0, 0, 'dbseed'], 
        [11, 'Mission Worker - in field', 0, 0, 'dbseed'],
        [12, 'Missions Agency', 0, 0, 'dbseed'],
        [13, 'Pastor', 0, 0, 'dbseed'],
        [14, 'Press-News Agency', 0, 0, 'dbseed'],
        [15, 'Seminary', 0, 0, 'dbseed'],
        [16, 'Service Agency', 0, 0, 'dbseed'],
    ]);
};
