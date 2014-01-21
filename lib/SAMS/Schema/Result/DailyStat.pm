use utf8;
package SAMS::Schema::Result::DailyStat;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('daily_stats');
__PACKAGE__->add_columns(
    'acc_id' => {
        data_type   => 'integer',
    },
    'site_id' => {
        data_type   => 'text',
    },
    'day' => {
        data_type           => 'timestamp with time zone',
        default             => \'now()',
        inflate_datetime    => 1,
    },
    'credential_type' => {
        data_type   => 'text',
    },
    'browse_requests' => { data_type => 'integer', is_nullable => 0 },
    'content_requests' => { data_type => 'integer', is_nullable => 0 },
    'menu_requests' => { data_type => 'integer', is_nullable => 0 },
    'page_requests' => { data_type => 'integer', is_nullable => 0 },
    'raw_requests' => { data_type => 'integer', is_nullable => 0 },
    'search_requests' => { data_type => 'integer', is_nullable => 0 },
    'sessions' => { data_type => 'integer', is_nullable => 0 },
    'total_session_duration' => { data_type => 'interval', is_nullable => 0 },
    'live_subs' => { data_type => 'integer', is_nullable => 0 },
    'concurrency_turnaways' => { data_type => 'integer', is_nullable => 0 },
    'licence_turnaways' => { data_type => 'integer', is_nullable => 0 },
);

__PACKAGE__->set_primary_key('acc_id', 'site_id', 'day', 'credential_type');

1;
