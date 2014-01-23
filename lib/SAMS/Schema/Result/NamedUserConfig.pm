package SAMS::Schema::Result::NamedUserConfig;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('named_user_config');

__PACKAGE__->add_columns(
    'subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'max_users' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
        default          => \'now()',
    },
);

__PACKAGE__->set_primary_key('subs_id');

__PACKAGE__->belongs_to(
    'sub',
    'SAMS::Schema::Result::Subscription',
    'subs_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
