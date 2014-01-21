use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $publication_medium_rs = shift->schema->resultset('PublicationMedium');

    $publication_medium_rs->populate([
        ['publication_medium_id', 'description', 'last_update_id'],
        ['ONLINE', 'Online Only', 'dbseed'],
        ['PRONLINE', 'Print copy and online access', 'dbseed'],
        ['UNK', 'Unknown', 'dbseed'],
    ]);
};
