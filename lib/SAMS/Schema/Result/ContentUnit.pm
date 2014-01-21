use utf8;
package SAMS::Schema::Result::ContentUnit;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('content_unit');

__PACKAGE__->add_columns(
    content_unit_id => {
        data_type   => 'text',
    },
    name => {
        data_type   => 'text',
        is_nullable => 1,
    },
    publication_date => {
        data_type   => 'timestamp with time zone',
        is_nullable => 1,
        inflate_datetime => 1,
    },
    price => {
        data_type   => 'numeric',
        is_nullable => 1,
        size        => [9, 2],
        is_numeric  => 1,
    },
    date_added => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        is_nullable         => 1,
        inflate_datetime    => 1,
    },
    last_update_id => {
        data_type   => 'text',
        is_nullable => 1,
    },
    content_unit_type_id => {
        data_type       => 'varchar',
        is_foreign_key  => 1,
        is_nullable     => 0,
        size => 50,
    },
);

__PACKAGE__->set_primary_key('content_unit_id');

__PACKAGE__->belongs_to(
    'content_unit_type', 'SAMS::Schema::Result::ContentUnitType', 'content_unit_type_id',
    {
        is_deferrable   => 0,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'platform_contents', 'SAMS::Schema::Result::PlatformContent', 'content_unit_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

__PACKAGE__->has_many(
    'product_contents', 'SAMS::Schema::Result::ProductContent', 'content_unit_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

1;
