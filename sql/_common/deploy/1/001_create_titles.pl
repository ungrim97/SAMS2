sub {
    my ($schema, $version) = @_;

    $schema->resultset('ContactTitle')->populate([
            ['title_id', 'description'],
            ['1', 'Mr'],
            ['2', 'Mrs'],
            ['3', 'Miss'],
            ['4', 'Ms'],
            ['5', 'Doctor'],
            ['6', 'Reverend'],
            ['7', 'Sir'],
        ]);
}
