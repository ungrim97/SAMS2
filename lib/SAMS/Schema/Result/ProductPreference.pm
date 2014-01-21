package SAMS::Schema::Result::ProductPreference;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('product_preference');

__PACKAGE__->add_columns(
    'product_preference_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'name'  => { data_type => 'text', },
    'value' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'pe_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
);

__PACKAGE__->set_primary_key('product_preference_id');

__PACKAGE__->add_unique_constraint( 'prodcut_pref_uniq_name_pe_id',
    [ 'name', 'pe_id' ] );

__PACKAGE__->belongs_to(
    'product_edition',
    'SAMS::Schema::Result::ProductEdition',
    'pe_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
