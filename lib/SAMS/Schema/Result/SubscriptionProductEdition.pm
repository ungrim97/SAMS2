package SAMS::Schema::Result::SubscriptionProductEdition;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('subscription_product_edition');
__PACKAGE__->result_source_instance->view_definition(
'SELECT s.subs_id, s.acc_id, pe.immediate_access, pe.last_update_id, pe.license_url, pe.notify, pe.pe_id, pe.pe_name, pe.product_url, pe.last_update_time, pe.site_id, pe.product_type_id, pe.allow_ip_default, pe.allow_userpass_default, pe.deny_groups_default, pe.allow_referrer_default, pe.allow_libcard_default, pe.require_libcode_default, pe.isbn, pe.is_inheritable_default, pe.description, pe.image_filename, pe.notes
        FROM subscription s
            JOIN product_edition pe ON s.pe_id = pe.pe_id;'
);

__PACKAGE__->add_columns(
    'subs_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'acc_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'immediate_access' => {
        data_type   => 'boolean',
        is_nullable => 1
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
    'pe_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'pe_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'product_url' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'site_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'product_type_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'allow_ip_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'allow_userpass_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'deny_groups_default' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'allow_referrer_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'allow_libcard_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'require_libcode_default' => {
        data_type   => 'boolean',
        is_nullable => 1
    },
    'isbn' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'is_inheritable_default' => {
        data_type   => 'boolean',
        is_nullable => 1
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
);

1;
