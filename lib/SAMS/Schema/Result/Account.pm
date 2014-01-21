package SAMS::Schema::Result::Account;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('account');
__PACKAGE__->add_columns(
    'acc_id' => {
        data_type         => 'integer',
        auto_nextval      => 1,
        sequence          => 'account_acc_id_seq',
        is_auto_increment => 1,
    },
    'if_acc_id' => {
        data_type   => 'integer',
        is_nullable => 1,
        is_numeric  => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'msd_customer_id' => {
        data_type   => 'integer',
        is_nullable => 1,
        is_numeric  => 1,
    },
    'notes' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'oed_sid' => {
        data_type     => 'text',
        is_nullable       => 1,
        is_auto_increment => 1,
    },
    'organisation' => { data_type => 'text', },
    'vista_id'     => {
        data_type   => 'bigint',
        is_nullable => 1,
        is_numeric  => 1,
    },
    'account_type_id' => {
        data_type      => 'integer',
        default_value  => 1,
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    'creation_date' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'group_acc_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_nullable    => 1,
        is_numeric     => 1,
    },
    'last_update_time' => {
        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        is_nullable      => 1,
        inflate_datetime => 1,
    },
    'maintainer' => {
        data_type      => 'text',
        is_foreign_key => 1,
        is_nullable    => 1
    },
    'org_size_id' => {
        data_type      => 'integer',
        default_value  => 1,
        is_foreign_key => 1,
        is_numeric     => 1,
    },
    'parent_acc_id' => {
        data_type      => 'integer',
        is_foreign_key => 1,
        is_nullable    => 1,
        is_numeric     => 1,
    },
    'contact_given_name' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_family_name' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_title' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_job_title' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_address_1' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_address_2' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_city' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_county' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_country_id' => {
        data_type      => 'varchar',
        is_foreign_key => 1,
        is_nullable    => 1,
        size           => 3
    },
    'contact_telephone' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'contact_mobile_telephone' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_fax' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_email' => {
        data_type   => 'text',
        is_nullable => 1,
    },
    'contact_postcode' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('acc_id');
__PACKAGE__->add_unique_constraint( 'account_if_acc_id_key', ['if_acc_id'] );
__PACKAGE__->add_unique_constraint( 'account_msd_customer_id_key',
    ['msd_customer_id'] );
__PACKAGE__->add_unique_constraint( 'account_oed_sid_key',  ['oed_sid'] );
__PACKAGE__->add_unique_constraint( 'account_vista_id_key', ['vista_id'] );

__PACKAGE__->has_many(
    'attribute_groups',
    'SAMS::Schema::Result::AccountAttributeGroup',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'group_accounts',
    'SAMS::Schema::Result::Account',
    'group_acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'parent_accounts',
    'SAMS::Schema::Result::Account',
    'parent_acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'preferences',
    'SAMS::Schema::Result::AccountPreference',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->belongs_to(
    'account_type',
    'SAMS::Schema::Result::AccountType',
    'account_type_id',
    {
        is_deferrable => 1,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->belongs_to(
    'country',
    'SAMS::Schema::Result::Country',
    'contact_country_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'ip_credentials',
    'SAMS::Schema::Result::CredentialIp',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'library_card_credentials',
    'SAMS::Schema::Result::CredentialLibcard',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'oauth_credentials',
    'SAMS::Schema::Result::CredentialOauth',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'referrer_credentials',
    'SAMS::Schema::Result::CredentialReferrer',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'shibboleth_credentials',
    'SAMS::Schema::Result::CredentialShibboleth',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'userpass_reset_credentials',
    'SAMS::Schema::Result::CredentialUserpassReset',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'userpass_credentials',
    'SAMS::Schema::Result::CredentialUserpass',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'ecommerce_transactions',
    'SAMS::Schema::Result::EcommerceTransaction',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->belongs_to(
    'group_account',
    'SAMS::Schema::Result::Account',
    'group_acc_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'invoices',
    'SAMS::Schema::Result::Invoice',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->belongs_to(
    'maintainer',
    'SAMS::Schema::Result::GroupName',
    'maintainer',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'named_users',
    'SAMS::Schema::Result::NamedUser',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->has_many(
    'oauth_server_access_tokens',
    'SAMS::Schema::Result::OauthServerAccessToken',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'oauth_server_permissions',
    'SAMS::Schema::Result::OauthServerPermission',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0
    },
);

__PACKAGE__->belongs_to(
    'organisation_size',
    'SAMS::Schema::Result::OrgSize',
    'org_size_id',
    {
        is_deferrable => 1,
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION'
    },
);

__PACKAGE__->belongs_to(
    'parent_account',
    'SAMS::Schema::Result::Account',
    'parent_acc_id',
    {
        is_deferrable => 1,
        join_type     => 'LEFT',
        on_delete     => 'NO ACTION',
        on_update     => 'NO ACTION',
    },
);

__PACKAGE__->has_many(
    'session_ip_credentials',
    'SAMS::Schema::Result::SessionCredentialIp',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'session_library_card_credentials',
    'SAMS::Schema::Result::SessionCredentialLibcard',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'session_oauth_credentials',
    'SAMS::Schema::Result::SessionCredentialOauth',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'session_referrer_credentials',
    'SAMS::Schema::Result::SessionCredentialReferrer',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'session_credential_shibboleths',
    'SAMS::Schema::Result::SessionCredentialShibboleth',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'session_credential_userpasses',
    'SAMS::Schema::Result::SessionCredentialUserpass',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'sessions',
    'SAMS::Schema::Result::Session',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'subscriptions',
    'SAMS::Schema::Result::Subscription',
    'acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

__PACKAGE__->has_many(
    'subscription_contact_accs',
    'SAMS::Schema::Result::Subscription',
    'contact_acc_id',
    {
        cascade_copy   => 0,
        cascade_delete => 0,
    },
);

1;
