package SAMS::Schema::Result::ContentUnitType;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('content_unit_type');
__PACKAGE__->add_columns(
    content_unit_type_id => {
        data_type     => 'varchar',
        size          => 50,
    },
    description => {
        data_type     => 'text',
    },
    last_update_id => {
        data_type     => 'text',
        is_nullable   => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('content_unit_type_id');
__PACKAGE__->add_unique_constraint('content_unit_type_description_ukey', ['description']);

__PACKAGE__->has_many(
    'content_units', 'SAMS::Schema::Result::ContentUnit', 'content_unit_type_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

1;
