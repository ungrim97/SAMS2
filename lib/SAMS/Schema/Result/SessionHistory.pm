package SAMS::Schema::Result::SessionHistory;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('session_history');

__PACKAGE__->add_columns(
    'browse_requests' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'client_id'         => { data_type => 'text', },
    'client_session_id' => { data_type => 'text', },
    'content_requests'  => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'host' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'ip_address' => {
        data_type   => 'inet',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'library_card' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'menu_requests' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'page_requests' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'raw_requests' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'referrer' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'search_requests' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 0,
    },
    'session_history_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'username' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'acc_id' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'first_request'    => { data_type => 'timestamp with time zone', },
    'last_request'     => { data_type => 'timestamp with time zone', },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'site_id'   => { data_type => 'text', },
    'site_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'organisation' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'summarised' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
);

__PACKAGE__->set_primary_key('session_history_id');

__PACKAGE__->add_unique_constraint(
    'session_history_client_id_key',
    [ 'client_id', 'client_session_id' ],
);

1;
