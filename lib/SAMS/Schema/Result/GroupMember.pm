package SAMS::Schema::Result::GroupMember;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('group_member');

__PACKAGE__->add_columns(
    'group_member_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'credential_userpass_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'group_name_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        default_value    => \'now()',
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key('group_member_id');

__PACKAGE__->add_unique_constraint(
    'group_member_credential_userpass_id_key',
    [ 'credential_userpass_id', 'group_name_id' ]
);

__PACKAGE__->belongs_to(
    'credential_userpass',
    'SAMS::Schema::Result::CredentialUserpass',
    'credential_userpass_id',
    {
        is_deferrable => 1,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

__PACKAGE__->belongs_to(
    'group_name',
    'SAMS::Schema::Result::GroupName',
    'group_name_id',
    {
        is_deferrable => 1,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

1;
