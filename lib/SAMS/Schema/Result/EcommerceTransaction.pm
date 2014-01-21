use utf8;

package SAMS::Schema::Result::EcommerceTransaction;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('ecommerce_transaction');
__PACKAGE__->add_columns(
    'ecommerce_transaction_id' => {
        data_type         => 'integer',
        is_numeric => 1,
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'transaction_start_datetime' => {
        data_type => 'timestamp',
        inflate_date => 1,
    },
    'cart_contents'              => { data_type => 'text', },
    'psp_status_message'         => {
        data_type   => 'text',
        is_nullable => 1
    },
    'psp_transaction_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'sams_status_message' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'amount'         => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type     => 'timestamp with time zone',
        is_nullable   => 1,
        default_value => \'now()',
        inflate_datetime => 1,
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
        is_nullable    => 1
    },
    'ecommerce_transaction_status_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('ecommerce_transaction_id');
__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->belongs_to(
    'ecommerce_transaction_status', 'SAMS::Schema::Result::EcommerceTransactionStatus', 'ecommerce_transaction_status_id',
    {
        is_deferrable => 1,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

1;
