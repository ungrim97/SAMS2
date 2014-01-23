use utf8;
package SAMS::Schema::Result::Currency;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('currency');
__PACKAGE__->add_columns(
    'currency_id' => {
        data_type         => 'integer',
        is_auto_increment => 1,
        is_nullable       => 0,
        sequence          => 'currency_seq',
    },
    'name' => {
        data_type => 'varchar',
        size      => 50
    },
    'code' => {
        data_type     => 'varchar',
        size          => 3
    },
    'last_update_id' => {
        data_type     => 'text',
        is_nullable   => 1
    },
    'last_update_time' => {
        data_type           => 'timestamp with time zone',
        is_nullable         => 1,
        default_value       => \'now()',
        inflate_datetime    => 1,
    },
);


__PACKAGE__->set_primary_key('currency_id');
__PACKAGE__->add_unique_constraint('currency_uq_code', ['code']);
__PACKAGE__->add_unique_constraint('currency_uq_name', ['name']);


__PACKAGE__->has_many(
    'invoices', 'SAMS::Schema::Result::Invoice', 'currency_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);


__PACKAGE__->has_many(
    'product_edition_sku_purchase_prices', 'SAMS::Schema::Result::ProductEditionSkuPurchasePrice', 'currency_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

1;
