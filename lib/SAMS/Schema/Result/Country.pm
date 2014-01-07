package SAMS::Schema::Result::Country;
use parent DBIx::Class::Core;

__PACKAGE__->table('countries');
__PACKAGE__->add_columns(
    country_id  => {
        data_type           => 'int',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    country_code => {
        data_type   => 'varchar',
        size        => 3,
    },
    country_name    => {
        data_type   => 'text',
    },
    language_id     => {
        data_type => 'int',
        is_numeric => 1,
        is_foreign_key => 1,
    },
);

__PACKAGE__->set_primary_key('country_id');
__PACKAGE__->has_many('accounts', 'SAMS::Schema::Result::Account', 'country_id');
__PACKAGE__->belongs_to('primary_language', 'SAMS::Schema::Result::Language', 'language_id');

1;
