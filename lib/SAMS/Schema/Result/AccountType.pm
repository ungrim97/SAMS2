package SAMS::Schema::Result::AccountType;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('account_type');
__PACKAGE__->add_columns(
  'account_type_id' => {
    data_type           => 'integer',
    is_auto_increment   => 1,
    is_numeric          => 1,
  },
  'description' => {
      data_type     => 'text',
  },
  'is_account_group' => {
      data_type     => 'boolean',
      default_value => \'false',
  },
  'is_subscription_group' => {
      data_type     => 'boolean',
      default_value => \'false',
  },
  'last_update_id' => {
      data_type     => 'text',
      is_nullable   => 1,
  },
  'last_update_time' => {
    data_type     => 'timestamp with time zone',
    default_value => \'now()',
    is_nullable   => 1,
  },
);

__PACKAGE__->set_primary_key('account_type_id');
__PACKAGE__->add_unique_constraint('account_type_description_key', ['description']);

__PACKAGE__->has_many(
    'accounts', 'SAMS::Schema::Result::Account', 'account_type_id',
    {
        cascade_copy    => 0,
        cascade_delete  => 0,
    },
);

1;
