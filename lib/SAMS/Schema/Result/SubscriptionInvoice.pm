package SAMS::Schema::Result::SubscriptionInvoice;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_invoice');

__PACKAGE__->add_columns(
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'invoice_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('subs_id');

__PACKAGE__->add_unique_constraint(
    'subscription_invoice_uq_subs_id_invoice_id',
    [ 'subs_id', 'invoice_id' ],
);

__PACKAGE__->belongs_to(
    'invoice',
    'SAMS::Schema::Result::Invoice',
    'invoice_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'sub',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
