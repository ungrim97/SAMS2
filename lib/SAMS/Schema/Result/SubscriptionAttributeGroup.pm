package SAMS::Schema::Result::SubscriptionAttributeGroup;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription_attribute_group');

__PACKAGE__->add_columns(
    'subscription_attribute_group_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
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
);

__PACKAGE__->set_primary_key('subscription_attribute_group_id');

__PACKAGE__->belongs_to(
    'subscription',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'subscription_attributes',
    'SAMS::Schema::Result::SubscriptionAttribute',
    'subscription_attribute_group_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

1;
