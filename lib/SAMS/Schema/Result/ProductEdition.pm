package SAMS::Schema::Result::ProductEdition;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('product_edition');

__PACKAGE__->add_columns(
    'immediate_access' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'license_url' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'notify' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'pe_id'       => { data_type => 'text', },
    'pe_name'     => { data_type => 'text', },
    'product_url' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'site_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'product_type_id'        => { data_type => 'text', },
    'allow_ip_default'       => { data_type => 'boolean', },
    'allow_userpass_default' => { data_type => 'boolean', },
    'deny_groups_default'    => {
        data_type   => 'text',
        is_nullable => 1
    },
    'allow_referrer_default'  => { data_type => 'boolean', },
    'allow_libcard_default'   => { data_type => 'boolean', },
    'require_libcode_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'isbn' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'is_inheritable_default' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1
    },
    'description' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'image_filename' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'notes' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'satisfy_all_selected_creds_default' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1
    },
    'allow_shibboleth_default' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1
    },
    'allow_oauth_default' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1
    },
);

__PACKAGE__->set_primary_key('pe_id');

__PACKAGE__->add_unique_constraint( 'product_edition_pe_name_key',
    ['pe_name'] );

__PACKAGE__->has_many(
    'product_contents', 'SAMS::Schema::Result::ProductContent',
    'pe_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'product_edition_skus', 'SAMS::Schema::Result::ProductEditionSku',
    'pe_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'product_preferences', 'SAMS::Schema::Result::ProductPreference',
    'pe_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'site',
    'SAMS::Schema::Result::Site',
    'site_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'site_2',
    'SAMS::Schema::Result::Site',
    'site_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'subscription_tokens', 'SAMS::Schema::Result::SubscriptionToken',
    'pe_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscriptions', 'SAMS::Schema::Result::Subscription',
    'pe_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
