package SAMS::Schema::Result::AccountType;
use base 'DBIx::Class::Core';

__PACKAGE__->table('account_types');
__PACKAGE__->add_columns(
    account_type_id => {
        data_type => 1,
        is_auto_increment => 1,
        is_numeric => 1,
    },
    description => {
        data_type => 'text',
    },
    last_update_user => {
        data_type => 'int',
        is_numeric => 1,
        is_foreign_key => 1,
        is_nullable     => 1,
    },
    last_update_time => {
        data_type => 'timestamp with time zone',
        is_nullable => 1,
        default_value => \'now()',
    },
);

__PACKAGE__->set_primary_key('account_type_id');

__PACKAGE__->belongs_to('update_user', 'SAMS::Schema::Result::Account', 'last_update_user');
__PACKAGE__->has_many('accounts', 'SAMS::Schema::Result::Account', 'account_type_id');

1;
