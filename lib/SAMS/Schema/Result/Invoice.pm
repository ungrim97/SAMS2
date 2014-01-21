package SAMS::Schema::Result::Invoice;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('invoice');

__PACKAGE__->add_columns(
    'invoice_id' => {
        is_numeric        => 1,
        data_type         => 'integer',
        is_auto_increment => 1,
    },
    'contact_title' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_given_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_family_name'  => { data_type => 'text', },
    'contact_organisation' => { data_type => 'text', },
    'contact_address_1'    => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_address_2' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_city' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_county' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_country_id' => {
        data_type      => 'varchar',
        is_foreign_key => 1,
        size           => 3
    },
    'contact_postcode' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'issue_date' => {
        default_value => \'now()',
        data_type     => 'date',
    },
    'last_update_time' => {

        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        default_value    => \'now()',
        inflate_datetime => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'currency_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    'acc_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    'tax_rate' => {

        data_type     => 'numeric',
        is_numeric    => 1,
        default_value => 0,
        size          => [ 6, 6 ],
    },
    'payment_note' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'subscription_dates' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_department' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_title' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_given_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_family_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_organisation' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_department' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_address_1' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_address_2' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_city' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_county' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ship_to_country_id' => {
        data_type   => 'varchar',
        is_nullable => 1,
        size        => 3
    },
    'ship_to_postcode' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('invoice_id');

__PACKAGE__->belongs_to(
    'acc',
    'SAMS::Schema::Result::Account',
    'acc_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'contact_country',
    'SAMS::Schema::Result::Country',
    'contact_country_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'currency',
    'SAMS::Schema::Result::Currency',
    'currency_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'invoice_line_items', 'SAMS::Schema::Result::InvoiceLineItem',
    'invoice_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'invoice_payments', 'SAMS::Schema::Result::InvoicePayment',
    'invoice_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_invoices', 'SAMS::Schema::Result::SubscriptionInvoice',
    'invoice_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
