package SAMS::Schema::Result::ContactTitle;
use base 'DBIx::Class::Core';

__PACKAGE__->table('contact_titles');
__PACKAGE__->add_columns(
    title_id    => {
        data_type   => 'int',
        is_auto_increment => 1,
        is_numeric  => 1,
    },
    description => {
        data_type => 'text',
    },
);

__PACKAGE__->set_primary_key('title_id');

__PACKAGE__->has_many('accounts', 'SAMS::Schema::Result::Account', 'contact_title_id');
1;
