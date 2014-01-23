package SAMS::Schema::Result::OauthClientServer;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('oauth_client_server');

__PACKAGE__->add_columns(
    'oauth_client_server_id' => { data_type => 'text', },
    'client_id'              => { data_type => 'text', },
    'client_secret'          => { data_type => 'text', },
    'last_update_id'         => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'image_url' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('oauth_client_server_id');

__PACKAGE__->add_unique_constraint( 'oauth_client_server_client_id_key',
    ['client_id'] );

__PACKAGE__->has_many(
    'credential_oauths', 'SAMS::Schema::Result::CredentialOauth',
    'oauth_client_server_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
