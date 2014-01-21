package SAMS::Schema::Result::CredentialOauth;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_oauth');
__PACKAGE__->add_columns(
    credential_oauth_id => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    identity               => { data_type => 'text', },
    oauth_client_server_id => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    acc_id => {
        data_type      => 'integer',
        is_foreign_key => 1,
    },
    last_update_id => {
        data_type   => 'text',
        is_nullable => 1,
    },
    last_update_time => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key('credential_oauth_id');
__PACKAGE__->add_unique_constraint(
    'unique_identity_and_client_server_id',
    [ 'identity', 'oauth_client_server_id' ]
);

__PACKAGE__->belongs_to(
    'account',
    'SAMS::Schema::Result::Account',
    'acc_id',
    {
        is_deferrable => 0,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

__PACKAGE__->belongs_to(
    'client_server',
    'SAMS::Schema::Result::OauthClientServer',
    'oauth_client_server_id',
    {
        is_deferrable => 0,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

1;
