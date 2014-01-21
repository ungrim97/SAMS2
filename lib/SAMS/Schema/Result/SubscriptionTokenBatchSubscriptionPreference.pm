package SAMS::Schema::Result::SubscriptionTokenBatchSubscriptionPreference;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_token_batch_subscription_preference');

__PACKAGE__->add_columns(
    'subscription_token_batch_subscription_preference_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'name'           => { data_type => 'text', },
    'value'          => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'subscription_token_batch_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key(
    'subscription_token_batch_subscription_preference_id');

__PACKAGE__->add_unique_constraint(
    'subs_tok_batch_subscription_preference_uq_tok_batch_id_name',
    [ 'subscription_token_batch_id', 'name' ],
);

__PACKAGE__->belongs_to(
    'subscription_token_batch',
    'SAMS::Schema::Result::SubscriptionTokenBatch',
    'subscription_token_batch_id',
    { is_deferrable => 0, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
