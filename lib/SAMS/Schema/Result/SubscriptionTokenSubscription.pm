package SAMS::Schema::Result::SubscriptionTokenSubscription;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_token_subscription');

__PACKAGE__->add_columns(
    'id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'activation_date' => {
        data_type   => 'date',
        is_nullable => 1
    },
    'subscription_token_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'subscription_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->belongs_to(
    'subscription',
    'SAMS::Schema::Result::Subscription',
    'subscription_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'subscription_token',
    'SAMS::Schema::Result::SubscriptionToken',
    'subscription_token_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
