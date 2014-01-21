package SAMS::Schema::Result::AccountPreference;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('account_preference');
__PACKAGE__->add_columns(
    'last_update_id' => {
        data_type     => 'text',
        is_nullable   => 1,
    },
    'name' => {
        data_type   => 'text',
    },
    'value' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'acc_id' => {
        data_type       => 'integer',
        is_foreign_key  => 1,
        is_numeric      => 1,
    },
    'last_update_time' => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('acc_id', 'name');
__PACKAGE__->add_unique_constraint('acc_pref_uniq_name_acc_id', ['name', 'acc_id']);

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

1;
