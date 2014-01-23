use utf8;

package SAMS::Schema::Result::EcommerceTransactionStatus;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('ecommerce_transaction_status');
__PACKAGE__->add_columns(
    'ecommerce_transaction_status_id' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'status'         => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        default_value    => \'now()',
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key('ecommerce_transaction_status_id');
__PACKAGE__->add_unique_constraint( 'ecommerce_transaction_status_uq_status', ['status'] );

__PACKAGE__->has_many(
    'ecommerce_transactions', 'SAMS::Schema::Result::EcommerceTransaction', 'ecommerce_transaction_status_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0
    },
);

1;
