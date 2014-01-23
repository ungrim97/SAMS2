package SAMS::Schema::Result::SubscriptionType;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_type');

__PACKAGE__->add_columns(
    'description'    => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'subscription_type_id' => {
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

__PACKAGE__->set_primary_key('subscription_type_id');

__PACKAGE__->add_unique_constraint( 'subscription_type_description_key',
    ['description'] );

__PACKAGE__->has_many(
    'subscription_tokens', 'SAMS::Schema::Result::SubscriptionToken',
    'subscription_type_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscriptions', 'SAMS::Schema::Result::Subscription',
    'subscription_type_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
