use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $org_size_rs = shift->schema->resultset('OrgSize');

    $org_size_rs->populate([
        ['description', 'last_update_id', 'org_size_id'],
        ['Other', 'dbseed', 1],
        ['Academic Libraries: FTE 5-12.5k', 'dbseed', 2],
        ['Public Libraries: Pop. 25-50k', 'dbseed', 3],
        ['Academic Libraries: FTE 0-5k', 'dbseed', 4],
        ['Public Libraries: Pop. 0-25k', 'dbseed', 5],
        ['Academic Libraries: FTE 50k+', 'dbseed', 6],
        ['Academic Libraries: FTE 5-10k', 'dbseed', 8],
        ['Academic Libraries: FTE 10-30k', 'dbseed', 9],
        ['Academic Libraries: FTE 30-50k', 'dbseed', 10],
        ['Public Libraries: Pop. 0-250k', 'dbseed', 11],
        ['Public Libraries: Pop. 0-500k', 'dbseed', 12],
        ['Public Libraries: Pop. 250-500k', 'dbseed', 13],
        ['Public Libraries: Pop. 500k-1m', 'dbseed', 14],
        ['Public Libraries: Pop. 1m+', 'dbseed', 15],
        ['All High Schools and Jr. Colleges', 'dbseed', 16],
        ['Academic Libraries: FTE 12.5-50k', 'dbseed', 17],
    ]);
};
