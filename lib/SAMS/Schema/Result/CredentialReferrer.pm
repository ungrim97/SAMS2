use utf8;
package SAMS::Schema::Result::CredentialReferrer;


use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');
__PACKAGE__->table('credential_referrer');

__PACKAGE__->add_columns(
    credential_referrer_id => {
        data_type           => 'integer',
        is_numeric          => 1,
        is_auto_increment   => 1,
    },
    last_update_id => {
        data_type   => 'text',
        is_nullable => 1,
    },
    referrer => {
        data_type   => 'text',
    },
    acc_id => {
        data_type       => 'integer',
        is_foreign_key  => 1,
        is_numeric      => 1,
    },
    last_update_time => {
        data_type           => 'timestamp with time zone',
        is_nullable         => 1,
        default             => \'now()',
        inflate_datetime    => 1,
    },
);

__PACKAGE__->set_primary_key('credential_referrer_id');
__PACKAGE__->add_unique_constraint('credential_referrer_referrer_key', ['referrer']);

__PACKAGE__->belongs_to(
    'account', 'SAMS::Schema::Result::Account', 'acc_id',
    {
        is_deferrable   => 1,
        on_delete       => 'NO ACTION',
        on_update       => 'NO ACTION',
    },
);

1;
