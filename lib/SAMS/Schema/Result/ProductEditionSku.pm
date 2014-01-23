package SAMS::Schema::Result::ProductEditionSku;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('product_edition_sku');

__PACKAGE__->add_columns(
    'product_edition_sku_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'description'    => { data_type => 'text', },
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
    'subs_duration_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'pe_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('product_edition_sku_id');

__PACKAGE__->belongs_to(
    'product_edition',
    'SAMS::Schema::Result::ProductEdition',
    'pe_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'product_edition_sku_purchase_prices',
    'SAMS::Schema::Result::ProductEditionSkuPurchasePrice',
    'product_edition_sku_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'subs_duration',
    'SAMS::Schema::Result::SubsDuration',
    'subs_duration_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
