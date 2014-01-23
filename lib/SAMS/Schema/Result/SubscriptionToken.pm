package SAMS::Schema::Result::SubscriptionToken;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_token');

__PACKAGE__->add_columns(
    'administered_by' => {
        data_type   => 'char',
        is_nullable => 0,
        size        => 3
    },
    'batch' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'concurrency' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'currency' => {
        data_type   => 'char',
        is_nullable => 1,
        size        => 3
    },
    'grace_period' => {
        data_type     => 'interval',
        default_value => '00:00:00',
    },
    'ignore_end' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'ignore_start' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'isbn' => {
        data_type   => 'char',
        is_nullable => 1,
        size        => 14
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'price' => {
        data_type   => 'numeric',
        is_nullable => 1,
        size        => [ 9, 2 ]
    },
    'subscription_token_id' => { data_type => 'text', },
    'creation_date'         => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'end_date' => {
        data_type   => 'date',
        is_nullable => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'pe_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'start_date' => {
        data_type   => 'date',
        is_nullable => 1
    },
    'subs_duration_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
        is_nullable    => 1
    },
    'subscription_type_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'start_on_activation' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'status'            => { data_type => 'text', },
    'total_redemptions' => {
        data_type     => 'integer',
        is_numeric    => 1,
        default_value => 1,
    },
);

__PACKAGE__->set_primary_key('subscription_token_id');

__PACKAGE__->belongs_to(
    'batch',
    'SAMS::Schema::Result::SubscriptionTokenBatch',
    'batch',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'product_edition',
    'SAMS::Schema::Result::ProductEdition',
    'pe_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'subscription_duration',
    'SAMS::Schema::Result::SubsDuration',
    'subs_duration_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'subscription_token_subscriptions',
    'SAMS::Schema::Result::SubscriptionTokenSubscription',
    'subscription_token_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'subscription_type',
    'SAMS::Schema::Result::SubscriptionType',
    'subscription_type_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
