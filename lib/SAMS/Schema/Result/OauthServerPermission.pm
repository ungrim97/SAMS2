package SAMS::Schema::Result::OauthServerPermission;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('oauth_server_permission');

__PACKAGE__->add_columns(
    'oauth_server_permission_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'oauth_server_client_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
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

__PACKAGE__->set_primary_key('oauth_server_permission_id');

__PACKAGE__->belongs_to(
    'account',
    'SAMS::Schema::Result::Account',
    'acc_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'oauth_server_client',
    'SAMS::Schema::Result::OauthServerClient',
    'oauth_server_client_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
