package SAMS::Schema::Result::Platform;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('platform');

__PACKAGE__->add_columns(
    'platform_id'      => { data_type => 'text', },
    'platform_name'    => { data_type => 'text', },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('platform_id');

__PACKAGE__->has_many( 'sites', 'SAMS::Schema::Result::Site', 'platform_id',
    { cascade_copy => 0, cascade_delete => 0 },
);

1;
