package SAMS::Schema::Result::CredentialIp;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_ip');
__PACKAGE__->add_columns(
    allow => {
        data_type     => 'boolean',
        default_value => \'true',
        is_nullable   => 0
    },
    credential_ip_id => {
        data_type           => 'integer',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    ip_address => {
        data_type     => 'inet',
    },
    last_update_id => {
        data_type     => 'text',
        is_nullable   => 1,
    },
    acc_id => {
        data_type         => 'integer',
        is_foreign_key    => 1,
    },
    last_update_time => {
        data_type     => 'timestamp with time zone',
        is_nullable => 1,
        default     => \'now()',
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key('credential_ip_id');

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

1;
