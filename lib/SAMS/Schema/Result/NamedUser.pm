package SAMS::Schema::Result::NamedUser;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('named_user');

__PACKAGE__->add_columns(
    'named_user_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'is_admin' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type   => 'timestamp with time zone',
        is_nullable => 1
    },
    'is_user' => {
        data_type     => 'boolean',
        default_value => \'true',
        is_nullable   => 1
    },
);

__PACKAGE__->set_primary_key('named_user_id');

__PACKAGE__->add_unique_constraint( 'named_user_unique_acc_and_sub_key',
    [ 'acc_id', 'subs_id' ] );

__PACKAGE__->belongs_to(
    'acc',
    'SAMS::Schema::Result::Account',
    'acc_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'sub',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
