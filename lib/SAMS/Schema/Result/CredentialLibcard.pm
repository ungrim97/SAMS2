package SAMS::Schema::Result::CredentialLibcard;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_libcard');
__PACKAGE__->add_columns(
    credential_libcard_id => {
        data_type           => 'integer',
        is_numeric          => 1,
        is_auto_increment   => 1,
    },
    last_update_id => {
        data_type   => 'text',
        is_nullable => 1,
    },
    pattern => {
        data_type   => 'text',
    },
    acc_id => {
        data_type       => 'integer',
        is_foreign_key  => 1,
        is_numeric      => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        is_nullable         => 1,
        default             => \'now()',
        inflate_datetime    => 1,
    },
    code => {
        data_type   => 'text',
        is_nullable => 1,
    },
);

__PACKAGE__->set_primary_key('credential_libcard_id');

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

1;
