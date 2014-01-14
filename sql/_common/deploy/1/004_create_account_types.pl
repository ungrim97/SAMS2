sub {
    my ($schema, $version) = @_;

    $schema->resultset('AccountType')->populate([
            ['account_type_id', 'description', 'last_update_time'],
            ['1', 'Institution', '2014-01-07 15:11:14.648109+00'],
        ]);
}
