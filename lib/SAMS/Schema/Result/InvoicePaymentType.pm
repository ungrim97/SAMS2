package SAMS::Schema::Result::InvoicePaymentType;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('invoice_payment_type');

__PACKAGE__->add_columns(
    'invoice_payment_type_id' => {
        data_type  => 'integer',
        is_numeric => 1,
        is_auto_increment => 1,
    },
    'name'             => { data_type => 'text', },
    'last_update_time' => {
        inflate_datetime => 1,
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('invoice_payment_type_id');

__PACKAGE__->add_unique_constraint( 'invoice_payment_type_uq_name', ['name'] );

__PACKAGE__->has_many(
    'invoice_payments',
    'SAMS::Schema::Result::InvoicePayment',
    'invoice_payment_type_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

1;
