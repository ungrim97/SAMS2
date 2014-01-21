package SAMS::Schema::Result::Country;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('country');
__PACKAGE__->add_columns(
    country_id => {
        data_type     => 'varchar',
        size          => 3
    },
    last_update_id => {
        data_type     => 'text',
        is_nullable   => 1
    },
    name => {
        data_type     => 'text',
    },
    territory => {
        data_type     => 'char',
        size          => 3
    },
    langauge_id => {
        data_type => 'integer',
        is_numeric  => 1,
        is_foreign_key => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('country_id');

__PACKAGE__->has_many(
    'accounts', 'SAMS::Schema::Result::Account',  'contact_country_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0
    },
);

__PACKAGE__->has_many(
    'invoices', 'SAMS::Schema::Result::Invoice', 'contact_country_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0
    },
);

__PACKAGE__->has_many(
    'subscriptions', 'SAMS::Schema::Result::Subscription', 'country_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

__PACKAGE__->belongs_to(
    'language', 'SAMS::Schema::Result::Language', 'language_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

1;
