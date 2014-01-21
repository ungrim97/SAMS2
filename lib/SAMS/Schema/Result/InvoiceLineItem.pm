package SAMS::Schema::Result::InvoiceLineItem;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('invoice_line_item');

__PACKAGE__->add_columns(
    'invoice_line_item_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'description' => { data_type => 'text', },
    'amount'      => {
        data_type  => 'numeric',
        is_numeric => 1,
        size       => [ 9, 2 ]
    },
    'position' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'invoice_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'tax' => {

        data_type     => 'numeric',
        default_value => 0,
        is_numeric    => 1,
        size          => [ 9, 2 ],
    },
);

__PACKAGE__->set_primary_key('invoice_line_item_id');

__PACKAGE__->add_unique_constraint( 'invoice_line_item_uq_position_invoice_id',
    [ 'position', 'invoice_id' ] );

__PACKAGE__->belongs_to(
    'invoice',
    'SAMS::Schema::Result::Invoice',
    'invoice_id',
    {
        is_deferrable => 0,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

1;
