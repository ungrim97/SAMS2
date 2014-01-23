package SAMS::Schema::Result::SubscriptionIp;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_ip');

__PACKAGE__->add_columns(
    'subscription_ip_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'ip_address'     => { data_type => 'inet', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'notes' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('subscription_ip_id');

__PACKAGE__->add_unique_constraint(
    'subscription_ip_unique_sub_and_ip_key',
    [ 'subs_id', 'ip_address' ],
);

__PACKAGE__->belongs_to(
    'subscription',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
