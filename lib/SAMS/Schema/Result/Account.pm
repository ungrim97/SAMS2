package SAMS::Schema::Result::Account;
use base 'DBIx::Class::Core';

__PACKAGE__->table('accounts');
__PACKAGE__->add_columns(
    account_id      => {
        data_type           => 'int',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    account_name    => {
        data_type   => 'text',
    },
    contact_name => {
        data_type   => 'text',
    },
    street_1 => {
        data_type   => 'text',
    },
    street_2 => {
        data_type   => 'text',
        is_nullable => 1,
    },
    city     => {
        data_type   => 'text',
    },
    county   => {
        data_type   => 'text',
    },
    postcode => {
        data_type   => 'text',
    },
    country_id => {
        data_type   => 'int',
        is_foreign_key  => 1,
        is_numeric  => 1,
    },
    contact_number => {
        data_type   => 'text',
    },
    mobile_number => {
        data_type   => 'text',
        is_nullable => 1,
    },
    fax_number => {
        data_type   => 'text',
        is_nullable => 1,
    },
    email_address   => {
        data_type   => 'text',
    },
    last_update_date    => {
        data_type   => 'timestamp with time zone',
        is_nullable => 1,
        default_value  => \'now()',
    },
    last_update_user    => {
        data_type   => 'int',
        is_numeric  => 1,
        is_nullable => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('account_id');

# RELATIONSHIPS

__PACKAGE__->belongs_to('update_user', 'SAMS::Schema::Result::Account', 'last_update_user');
__PACKAGE__->has_many('update_accounts', 'SAMS::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to('country', 'SAMS::Schema::Result::Country', 'country_id');

1;
