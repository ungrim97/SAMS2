package SAMS::Schema::Result::Site;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('site');

__PACKAGE__->add_columns(
    'site_id'     => { data_type => 'text', },
    'site_name'   => { data_type => 'text', },
    'platform_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
        is_nullable    => 1
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
    'site_url' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('site_id');

__PACKAGE__->add_unique_constraint( 'site_name_key', ['site_name'] );

__PACKAGE__->belongs_to(
    'platform',
    'SAMS::Schema::Result::Platform',
    'platform_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'product_edition_sites', 'SAMS::Schema::Result::ProductEdition',
    'site_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'product_edition_sites_2s', 'SAMS::Schema::Result::ProductEdition',
    'site_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'sessions', 'SAMS::Schema::Result::Session',
    'site_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'site_preferences', 'SAMS::Schema::Result::SitePreference',
    'site_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
