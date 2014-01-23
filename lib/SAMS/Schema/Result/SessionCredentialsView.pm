package SAMS::Schema::Result::SessionCredentialsView;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('session_credentials_view');
__PACKAGE__->result_source_instance->view_definition(
'SELECT s.abuse_reason, s.client_id, s.client_session_id, s.clientdata, s.last_update_id, s.session_id, s.shared_session, s.user_agent, s.acc_id, s.last_access_time, s.last_update_time, s.start_time, s.site_id, userpass.credential_userpass_id, libcard.credential_libcard_id, ip.credential_ip_id, referrer.credential_referrer_id, shibboleth.credential_shibboleth_id, oauth.credential_oauth_id
        FROM session s
            LEFT JOIN session_credential_userpass userpass ON userpass.session_id = s.session_id
            LEFT JOIN session_credential_libcard libcard ON libcard.session_id = s.session_id
            LEFT JOIN session_credential_ip ip ON ip.session_id = s.session_id
            LEFT JOIN session_credential_referrer referrer ON referrer.session_id = s.session_id
            LEFT JOIN session_credential_shibboleth shibboleth ON shibboleth.session_id = s.session_id
            LEFT JOIN session_credential_oauth oauth ON oauth.session_id = s.session_id;'
);

__PACKAGE__->add_columns(
    'abuse_reason' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'client_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'client_session_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'clientdata' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'session_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'shared_session' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'user_agent' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'acc_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1,
    },
    'last_access_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'start_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'site_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'credential_userpass_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'credential_libcard_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'credential_ip_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'credential_referrer_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'credential_shibboleth_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'credential_oauth_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
);

1;
