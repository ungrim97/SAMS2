package SAMS::Schema::Result::OrgSize;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('org_size');

__PACKAGE__->add_columns(
    'description'    => { data_type => 'text', },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'org_size_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
);

__PACKAGE__->set_primary_key('org_size_id');

__PACKAGE__->add_unique_constraint( 'org_size_description_key',
    ['description'] );

__PACKAGE__->has_many(
    'accounts', 'SAMS::Schema::Result::Account',
    'org_size_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
