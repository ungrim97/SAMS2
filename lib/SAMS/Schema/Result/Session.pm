package SAMS::Schema::Result::Session;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('session');

__PACKAGE__->add_columns(
    'abuse_reason' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'client_id'         => { data_type => 'text', },
    'client_session_id' => { data_type => 'text', },
    'clientdata'        => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'session_id' => {

        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'shared_session' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'user_agent' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
        is_nullable    => 1
    },
    'last_access_time' => {
        data_type        => 'timestamp with time zone',
        inflate_datetime => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'start_time' => {
        data_type        => 'timestamp with time zone',
        inflate_datetime => 1,
    },
    'site_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('session_id');

__PACKAGE__->add_unique_constraint( 'session_client_id_key',
    [ 'client_id', 'client_session_id' ] );

__PACKAGE__->belongs_to(
    'account',
    'SAMS::Schema::Result::Account',
    'acc_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'session_credential_ips', 'SAMS::Schema::Result::SessionCredentialIp',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'session_credential_libcards',
    'SAMS::Schema::Result::SessionCredentialLibcard',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'session_credential_oauths', 'SAMS::Schema::Result::SessionCredentialOauth',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'session_credential_referrers',
    'SAMS::Schema::Result::SessionCredentialReferrer',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'session_credential_shibboleths',
    'SAMS::Schema::Result::SessionCredentialShibboleth',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'session_credential_userpasses',
    'SAMS::Schema::Result::SessionCredentialUserpass',
    'session_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'site',
    'SAMS::Schema::Result::Site',
    'site_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
