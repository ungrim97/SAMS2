use utf8;
package SAMS::Schema::Result::CredentialShibboleth;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_shibboleth');

__PACKAGE__->add_columns(
    credential_shibboleth_id => {
        data_type         => 'integer',
        is_auto_increment => 1,
        is_numeric        => 1,
    },
    acc_id => {
        data_type       => 'integer',
        is_foreign_key  => 1,
        is_numeric      => 1
    },
    entity_id => {
        data_type   => 'text',
    },
    organisation_id => {
        data_type   => 'text',
    },
    last_update_id => {
        data_type   => 'text',
        is_nullable => 1
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        is_nullable         => 1,
        default             => \'now()',
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('credential_shibboleth_id');

__PACKAGE__->add_unique_constraint( 'credential_shibboleth_organisation_id_key', ['organisation_id'] );

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION'
    },
);

1;
