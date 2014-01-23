package SAMS::Schema::Result::Consortium;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('consortium');
__PACKAGE__->result_source_instance->view_definition(
    'SELECT DISTINCT ac.acc_id AS parent_acc_id, ac2.acc_id AS member_acc_id, ac2.organisation
       FROM account ac
          JOIN subscription s ON s.acc_id = ac.acc_id
          JOIN subscription s2 ON s.subs_id = s2.group_subs_id
          JOIN account ac2 ON ac2.acc_id = s2.acc_id;'
);

__PACKAGE__->add_columns(
    parent_acc_id => {
        data_type     => 'integer',
        is_nullable   => 1,
        is_numeric    => 1,
    },
    member_acc_id => {
        data_type   => 'integer',
        is_nullable => 1,
        is_numeric  => 1,
    },
    organisation => {
        data_type   => 'text',
        is_nullable => 1
    },
);

1;
