package SAMS::Schema::Result::ProductEditionSkuPurchasePrice;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('product_edition_sku_purchase_price');

__PACKAGE__->add_columns(
    'product_edition_sku_purchase_price_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'purchase_price' => {
        data_type   => 'numeric',
        is_numeric  => 1,
        size        => [ 8, 2 ]
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'product_edition_sku_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'currency_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('product_edition_sku_purchase_price_id');

__PACKAGE__->add_unique_constraint(
    'product_edition_sku_purchase_price_uq_pe_sku_id_cur_id',
    [ 'product_edition_sku_id', 'currency_id' ],
);

__PACKAGE__->belongs_to(
    'currency',
    'SAMS::Schema::Result::Currency',
    'currency_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'product_edition_sku',
    'SAMS::Schema::Result::ProductEditionSku',
    'product_edition_sku_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
