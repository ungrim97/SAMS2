use utf8;
package SAMS::Schema::Result::DbUpdate;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('db_updates');
__PACKAGE__->add_columns(
    'id' => {
        data_type           => 'integer',
        is_numeric => 1,
        is_auto_increment   => 1,
    },
    'script_number' => {
        data_type => 'text',
    },
    'when_realised' => {
        data_type           => 'timestamp with time zone',
        default_value       => \'now()',
        inflate_datetime    => 1,
    },
    'applied_by' => {
        data_type => 'text',
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint('db_updates_uq_script_number', ['script_number']);

1;
