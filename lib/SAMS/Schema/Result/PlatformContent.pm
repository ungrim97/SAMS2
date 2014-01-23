package SAMS::Schema::Result::PlatformContent;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('platform_content');

__PACKAGE__->add_columns(
    'platform_id'     => { data_type => 'text', },
    'content_unit_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
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

__PACKAGE__->set_primary_key( 'platform_id', 'content_unit_id' );

__PACKAGE__->belongs_to(
    'content_unit',
    'SAMS::Schema::Result::ContentUnit',
    'content_unit_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
