use utf8;
package SAMS::Schema::Result::CredentialUserpassReset;

use strict;
use warnings;

use base 'DBIx::Class::Core';


__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_userpass_reset');
__PACKAGE__->add_columns(
    'credential_userpass_reset_id' => {
        data_type   => 'text',
    },
    'acc_id' => {
        data_type       => 'integer',
        is_foreign_key  => 1,
    },
    'subs_id' => {
        data_type       => 'integer',
        is_foreign_key  => 1,
        is_nullable     => 1,
    },
    'username' => {
        data_type       => 'text',
        is_nullable     => 1,
    },
    'creation_time' => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        inflate_datetime    => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'last_update_time' =>  {
        data_type           => 'timestamp with time zone',
        is_nullable         => 1,
        default_value       => \'now()',
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('credential_userpass_reset_id');

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

__PACKAGE__->belongs_to(
    'subcription', 'SAMS::Schema::Result::Subscription', 'subs_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

1;
