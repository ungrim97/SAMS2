package SAMS::Schema::Result::PublisherPreference;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('publisher_preference');

__PACKAGE__->add_columns(
    'publisher_preference_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'name'  => { data_type => 'text', },
    'value' => {
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

__PACKAGE__->set_primary_key('publisher_preference_id');

__PACKAGE__->add_unique_constraint( 'publisher_preference_uniq_name',
    ['name'] );

1;
