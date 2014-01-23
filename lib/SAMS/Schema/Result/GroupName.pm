package SAMS::Schema::Result::GroupName;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('group_name');

__PACKAGE__->add_columns(
    'group_name_id'  => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'privilege_level' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        default_value    => \'now()',
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key('group_name_id');

__PACKAGE__->has_many(
    'accounts', 'SAMS::Schema::Result::Account', 'maintainer',
    {
        cascade_copy         => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'group_members', 'SAMS::Schema::Result::GroupMember', 'group_name_id',
    {
        cascade_copy            => 0,
        cascade_delete  => 0
    },
);

1;
