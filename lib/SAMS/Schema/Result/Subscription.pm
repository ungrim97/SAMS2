package SAMS::Schema::Result::Subscription;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('subscription');

__PACKAGE__->add_columns(
    'address1' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'address2' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'administered_by' => {
        data_type => 'char',
        size      => 3
    },
    'alternative_subs_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'allow_marketing_email' => {
        data_type     => 'boolean',
        default_value => \'true',
    },
    'allow_notification_email' => {
        data_type     => 'boolean',
        default_value => \'true',
    },
    'city' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'concurrency' => {
        data_type  => 'integer',
        is_numeric => 1,
    },
    'contact_forename' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_job_title' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_title' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'county' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'currency' => {
        data_type   => 'char',
        is_nullable => 1,
        size        => 3
    },
    'email' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'fax' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'grace_period' => {
        data_type     => 'interval',
        default_value => '00:00:00',
    },
    'if_sub_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'ignore_end' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'ignore_start' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'isbn' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'msd_order_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1
    },
    'notes' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'postcode' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'prepayment_required' => {
        data_type     => 'boolean',
        default_value => \'false',
    },
    'price' => {
        data_type   => 'numeric',
        is_nullable => 1,
        is_numeric  => 1,
        size        => [ 9, 2 ]
    },
    'sales_rep' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'status'  => { data_type => 'text', },
    'subs_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'telephone' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'country_id' => {

        data_type      => 'varchar',
        is_foreign_key => 1,
        is_nullable    => 1,
        size           => 3
    },
    'creation_date' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'end_date' => {
        data_type        => 'date',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'group_subs_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
        is_nullable    => 1
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'pe_id' => {
        data_type      => 'text',
        is_foreign_key => 1,
    },
    'start_date' => {
        data_type   => 'date',
        is_nullable => 1
    },
    'subscription_type_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'allow_ip'       => { data_type => 'boolean', },
    'allow_userpass' => { data_type => 'boolean', },
    'deny_groups'    => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'allow_referrer'  => { data_type => 'boolean', },
    'allow_libcard'   => { data_type => 'boolean', },
    'require_libcode' => {
        data_type   => 'boolean',
        is_nullable => 1,
    },
    'publication_medium_id' => {
        data_type      => 'text',
        default_value  => 'ONLINE',
        is_foreign_key => 1,
    },
    'converted_to_sub_id' => {
        data_type   => 'integer',
        is_numeric  => 1,
        is_nullable => 1,
    },
    'conversion_date' => {
        data_type        => 'timestamp with time zone',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'conversion_type' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'is_inheritable' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1,
    },
    'contact_mobile_telephone' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_acc_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
        is_nullable    => 1,
    },
    'satisfy_all_selected_creds' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1,
    },
    'allow_shibboleth' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1,
    },
    'allow_oauth' => {
        data_type     => 'boolean',
        default_value => \'false',
        is_nullable   => 1,
    },
);

__PACKAGE__->set_primary_key('subs_id');

__PACKAGE__->add_unique_constraint( 'subscription_alternative_subs_id_key',
    ['alternative_subs_id'], );

__PACKAGE__->add_unique_constraint( 'subscription_if_sub_id_key',
    ['if_sub_id'] );

__PACKAGE__->add_unique_constraint( 'subscription_msd_order_id_key',
    ['msd_order_id'] );

__PACKAGE__->belongs_to(
    'acc',
    'SAMS::Schema::Result::Account',
    'acc_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'contact_acc',
    'SAMS::Schema::Result::Account',
    'contact_acc_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'SET NULL',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->belongs_to(
    'country',
    'SAMS::Schema::Result::Country',
    'country_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'credential_userpass_resets',
    'SAMS::Schema::Result::CredentialUserpassReset',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'group_sub',
    'SAMS::Schema::Result::Subscription',
    'group_subs_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'invoice_payments', 'SAMS::Schema::Result::InvoicePayment',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->might_have(
    'named_user_config', 'SAMS::Schema::Result::NamedUserConfig',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'named_users', 'SAMS::Schema::Result::NamedUser',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'pe',
    'SAMS::Schema::Result::ProductEdition',
    'pe_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->belongs_to(
    'publication_medium',
    'SAMS::Schema::Result::PublicationMedium',
    'publication_medium_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'subscription_attribute_groups',
    'SAMS::Schema::Result::SubscriptionAttributeGroup',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->might_have(
    'subscription_invoice', 'SAMS::Schema::Result::SubscriptionInvoice',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_ips', 'SAMS::Schema::Result::SubscriptionIp',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_preferences', 'SAMS::Schema::Result::SubscriptionPreference',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'subscription_token_subscriptions',
    'SAMS::Schema::Result::SubscriptionTokenSubscription',
    'subscription_id', { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->belongs_to(
    'subscription_type',
    'SAMS::Schema::Result::SubscriptionType',
    'subscription_type_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

__PACKAGE__->has_many(
    'subscriptions', 'SAMS::Schema::Result::Subscription',
    'subs_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
