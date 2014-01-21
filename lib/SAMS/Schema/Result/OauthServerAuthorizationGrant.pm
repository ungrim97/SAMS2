package SAMS::Schema::Result::OauthServerAuthorizationGrant;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('oauth_server_authorization_grant');

__PACKAGE__->add_columns(
    'oauth_server_authorization_grant_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'oauth_server_client_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'token'     => { data_type => 'text', },
    'is_active' => {
        data_type     => 'boolean',
        default_value => \'false',
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

__PACKAGE__->set_primary_key('oauth_server_authorization_grant_id');

__PACKAGE__->add_unique_constraint(
    'oauth_server_authorization_grant_token_key',
    ['token'] );

__PACKAGE__->has_many(
    'oauth_server_access_tokens',
    'SAMS::Schema::Result::OauthServerAccessToken',
    'oauth_server_authorization_grant_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'oauth_server_client',
    'SAMS::Schema::Result::OauthServerClient',
    'oauth_server_client_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'oauth_server_refresh_tokens',
    'SAMS::Schema::Result::OauthServerRefreshToken',
    'oauth_server_authorization_grant_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

1;
