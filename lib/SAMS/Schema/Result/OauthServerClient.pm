package SAMS::Schema::Result::OauthServerClient;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('oauth_server_client');

__PACKAGE__->add_columns(
    'oauth_server_client_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'client_id'      => { data_type => 'text', },
    'client_secret'  => { data_type => 'text', },
    'endpoint'       => { data_type => 'text', },
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

__PACKAGE__->set_primary_key('oauth_server_client_id');

__PACKAGE__->add_unique_constraint( 'oauth_server_client_client_id_key',
    ['client_id'] );

__PACKAGE__->has_many(
    'oauth_server_authorization_grants',
    'SAMS::Schema::Result::OauthServerAuthorizationGrant',
    'oauth_server_client_id',
    { cascade_copy                     => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'oauth_server_permissions',
    'SAMS::Schema::Result::OauthServerPermission',
    'oauth_server_client_id',
    { cascade_copy                     => 0, cascade_delete => 0 },
);

1;
