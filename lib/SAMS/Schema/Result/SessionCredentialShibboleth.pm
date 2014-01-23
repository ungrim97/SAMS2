package SAMS::Schema::Result::SessionCredentialShibboleth;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('session_credential_shibboleth');

__PACKAGE__->add_columns(
    'session_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'credential_shibboleth_id' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
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
);

__PACKAGE__->set_primary_key( 'session_id', 'credential_shibboleth_id' );

__PACKAGE__->add_unique_constraint(
    'session_credential_shibboleth_session_acc_unique',
    [ 'session_id', 'acc_id' ],
);

__PACKAGE__->belongs_to(
    'acc',
    'SAMS::Schema::Result::Account',
    'acc_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'session',
    'SAMS::Schema::Result::Session',
    'session_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
