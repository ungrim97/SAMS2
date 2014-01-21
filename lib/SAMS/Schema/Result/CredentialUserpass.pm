use utf8;
package SAMS::Schema::Result::CredentialUserpass;

use strict;
use warnings;

use base 'DBIx::Class::Core';


__PACKAGE__->load_components('InflateColumn::DateTime');


__PACKAGE__->table('credential_userpass');


__PACKAGE__->add_columns(
    'credential_userpass_id' => {
        data_type           => 'integer',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    'last_update_id' => {
        data_type     => 'text',
        is_nullable   => 1
    },
    'password' => {
        data_type     => 'text',
    },
    'username' => {
        data_type     => 'text',
    },
    'acc_id' => {
        data_type         => 'integer',
        is_foreign_key    => 1,
        is_numeric        => 1,
    },
    'last_update_time' => {
        data_type             => 'timestamp with time zone',
        is_nullable           => 1,
        default               => \'now()',
        inflate_datetime      => 1,
    },
    'make_public' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
);


__PACKAGE__->set_primary_key('credential_userpass_id');


__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);


__PACKAGE__->has_many(
    'group_members', 'SAMS::Schema::Result::GroupMember', 'credential_userpass_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0
    },
);

1;
