package SAMS::Schema::Result::PublicationMedium;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('publication_medium');

__PACKAGE__->add_columns(
    'publication_medium_id' => { data_type => 'text', },
    'description'           => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {

        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
);

__PACKAGE__->set_primary_key('publication_medium_id');

__PACKAGE__->has_many(
    'subscriptions', 'SAMS::Schema::Result::Subscription',
    'publication_medium_id', { cascade_copy => 0, cascade_delete => 0 },
);

1;
