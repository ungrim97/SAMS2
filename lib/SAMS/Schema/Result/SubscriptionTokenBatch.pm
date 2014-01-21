package SAMS::Schema::Result::SubscriptionTokenBatch;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_token_batch');

__PACKAGE__->add_columns(
    'id' => {

        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
        is_nullable       => 0,
        sequence          => 'subscription_token_batch_seq',
    },
    'name' => {
        data_type   => 'text',
        is_nullable => 0
    },
    'notes' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type   => 'timestamp with time zone',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(
    'subscription_token_batch_subscription_preferences',
    'SAMS::Schema::Result::SubscriptionTokenBatchSubscriptionPreference',
    'subscription_token_batch_subscription_preference_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_tokens', 'SAMS::Schema::Result::SubscriptionToken',
    'subscription_token_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
