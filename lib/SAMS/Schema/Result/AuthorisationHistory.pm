package SAMS::Schema::Result::AuthorisationHistory;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('authorisation_history');
__PACKAGE__->add_columns(
    authorisation_history_id => {
        data_type           => 'integer',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    authorisation_type => {
        data_type     => 'text',
    },
    credential_type => {
        data_type     => 'text',
    },
    credential_value => {
        data_type     => 'text',
    },
    last_update_id => {
        data_type     => 'text',
        is_nullable   => 1,
    },
    acc_id => {
        data_type         => 'integer',
        is_numeric        => 1,
    },
    event_timestamp => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        inflate_datetime    => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
    site_id => {
        data_type   => 'text',
    },
    site_name => {
        data_type   => 'text',
        is_nullable => 1,
    },
    organisation => {
        data_type   => 'text',
        is_nullable => 1,
    },
    summarised => {
        data_type       => 'boolean',
        default_value   => \'false',
    },
);

__PACKAGE__->set_primary_key('authorisation_history_id');

1;
