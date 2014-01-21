package SAMS::Schema::Result::AccountAttribute;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('account_attribute');
__PACKAGE__->add_columns(
    'account_attribute_id' => {
        data_type         => 'integer',
        is_auto_increment => 1,
        is_nullable       => 0,
        sequence          => 'account_attribute_seq',
        auto_nextval      => 1,
        is_numeric        => 1,
    },
    'name' => {
        data_type     => 'text',
        is_nullable   => 0
    },
    'value' => {
        data_type     => 'text',
        is_nullable   => 0
    },
    'account_attribute_group_id' => {
        data_type         => 'integer',
        is_foreign_key    => 1,
        is_nullable       => 0,
        is_numeric        => 1,
    },
    'last_update_id' => {
        data_type     => 'text',
        is_nullable   => 1
    },
    'last_update_time' => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('account_attribute_id');
__PACKAGE__->add_unique_constraint( 'account_attribute_uq_group_name', ['account_attribute_group_id', 'name'] );

__PACKAGE__->belongs_to(
    'account_attribute_group', 'SAMS::Schema::Result::AccountAttributeGroup', 'account_attribute_group_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

1;
