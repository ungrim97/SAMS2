package SAMS::Schema::Result::AccountAttributeGroup;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("account_attribute_group");
__PACKAGE__->add_columns(
    account_attribute_group_id => {
        data_type         => "integer",
        is_auto_increment => 1,
        sequence          => "account_attribute_group_seq",
        auto_nextval      => 1,
        is_numeric        => 1,
    },
    acc_id => {
        data_type      => "integer",
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    last_update_id => {
        data_type   => "text",
        is_nullable => 1
    },
    last_update_time => {
        data_type        => "timestamp with time zone",
        default_value    => \"now()",
        is_nullable      => 1,
        inflate_datetime => 1,
    },
);

__PACKAGE__->set_primary_key("account_attribute_group_id");

__PACKAGE__->belongs_to(
    "account",
    "SAMS::Schema::Result::Account",
    "acc_id",
    {
        is_deferrable => 1,
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION"
    },
);

__PACKAGE__->has_many(
    "account_attributes",
    "SAMS::Schema::Result::AccountAttribute",
    'account_attribute_group_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

1;
