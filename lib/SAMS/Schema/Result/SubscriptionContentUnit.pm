package SAMS::Schema::Result::SubscriptionContentUnit;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('subscription_content_unit');
__PACKAGE__->result_source_instance->view_definition(
'SELECT s.subs_id, s.acc_id, pe.pe_id, cu.content_unit_id, cu.name, cu.publication_date, cu.price, cu.date_added, cu.last_update_time, cu.last_update_id, cu.content_unit_type_id
        FROM subscription s
            JOIN product_edition pe ON s.pe_id = pe.pe_id
            JOIN product_content pc ON pe.pe_id = pc.pe_id
            JOIN content_unit cu ON pc.content_unit_id = cu.content_unit_id;'
);

__PACKAGE__->add_columns(
    'subs_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'acc_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'pe_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'content_unit_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'publication_date' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'price' => {
        data_type   => 'numeric',
        is_nullable => 1,
        is_numeric  => 1,
        size        => [ 9, 2 ]
    },
    'date_added' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'content_unit_type_id' => {
        data_type   => 'varchar',
        is_nullable => 1,
        size        => 50
    },
);

1;
