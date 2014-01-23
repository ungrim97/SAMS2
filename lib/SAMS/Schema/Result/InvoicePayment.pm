package SAMS::Schema::Result::InvoicePayment;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('invoice_payment');

__PACKAGE__->add_columns(
    'invoice_payment_id' => {
        data_type         => 'integer',
        is_auto_increment => 1,
        is_numeric        => 1,
    },
    'amount' => {
        data_type  => 'numeric',
        is_numeric => 1,
        size       => [ 9, 2 ]
    },
    'payment_date'     => { data_type => 'date', },
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
    'invoice_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    'payment_reference' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'invoice_payment_type_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
    },
    'subs_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_nullable    => 1
    },
);

__PACKAGE__->set_primary_key('invoice_payment_id');

__PACKAGE__->belongs_to(
    'invoice',
    'SAMS::Schema::Result::Invoice',
    'invoice_id',
    {
        is_deferrable => 0,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

__PACKAGE__->belongs_to(
    'invoice_payment_type',
    'SAMS::Schema::Result::InvoicePaymentType',
    'invoice_payment_type_id',
    {
        is_deferrable => 0,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->belongs_to(
    'subscription',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    {
        is_deferrable => 0,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

1;
