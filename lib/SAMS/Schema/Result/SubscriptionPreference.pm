package SAMS::Schema::Result::SubscriptionPreference;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_preference');

__PACKAGE__->add_columns(
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'name'  => { data_type => 'text', },
    'value' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
);

__PACKAGE__->set_primary_key( 'subs_id', 'name' );

__PACKAGE__->belongs_to(
    'subscription',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
