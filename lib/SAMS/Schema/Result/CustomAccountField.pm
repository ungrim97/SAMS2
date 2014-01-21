use utf8;
package SAMS::Schema::Result::CustomAccountField;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('custom_account_field');
__PACKAGE__->add_columns(
    'account_preference_name' => {
        data_type     => 'text',
    },
    'label' => {
        data_type     => 'text',
    },
    'description' => {
        data_type     => 'text',
        is_nullable   => 1
    },
);

__PACKAGE__->set_primary_key('account_preference_name');

1;
