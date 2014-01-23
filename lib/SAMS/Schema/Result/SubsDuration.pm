package SAMS::Schema::Result::SubsDuration;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subs_duration');

__PACKAGE__->add_columns(
    'duration'     => { data_type => 'interval', },
    'grace_period' => {
        data_type     => 'interval',
        default_value => '00:00:00',
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'subs_duration_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
);

__PACKAGE__->set_primary_key('subs_duration_id');

__PACKAGE__->add_unique_constraint( 'subs_duration_duration_key',
    ['duration'] );

__PACKAGE__->has_many(
    'product_edition_skus', 'SAMS::Schema::Result::ProductEditionSku',
    'subs_duration_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_tokens', 'SAMS::Schema::Result::SubscriptionToken',
    'subs_duration_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
