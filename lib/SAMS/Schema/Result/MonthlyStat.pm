package SAMS::Schema::Result::MonthlyStat;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('monthly_stats');

__PACKAGE__->add_columns(
    'acc_id' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'site_id' => {
        data_type => 'text',
    },
    'month' => {
        data_type => 'timestamp with time zone',
        inflate_datetime => 1,
    },
    'credential_type' => {
        data_type => 'text',
    },
    'browse_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'content_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'menu_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'page_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'raw_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'search_requests' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'sessions' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'total_session_duration' => {
        data_type => 'interval',
    },
    'live_subs' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'concurrency_turnaways' => {
        data_type => 'integer',
        is_numeric => 1,
    },
    'licence_turnaways' => {
        data_type => 'integer',
        is_numeric => 1,
    },
);

__PACKAGE__->set_primary_key( 'acc_id', 'site_id', 'month', 'credential_type' );

1;
