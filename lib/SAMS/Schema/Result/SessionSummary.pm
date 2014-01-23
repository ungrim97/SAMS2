package SAMS::Schema::Result::SessionSummary;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('session_summary');
__PACKAGE__->result_source_instance->view_definition(
    'SELECT session.client_id, count(*) AS count
        FROM session
            GROUP BY session.client_id;'
);

__PACKAGE__->add_columns(
    'client_id' => { data_type => 'text',   is_nullable => 1 },
    'count'     => { data_type => 'bigint', is_nullable => 1 },
);

1;
