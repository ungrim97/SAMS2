package SAMS::Schema::Result::Language;
use base 'DBIx::Class::Core';

__PACKAGE__->table('languages');
__PACKAGE__->add_columns(
    language_id => {
        data_type           => 'int',
        is_numeric          => 1,
        is_auto_increment   => 1,
    },
    language_code => {
        data_type => 'varchar',
        size      => 2,
    },
    language_name => {
        data_type => 'text',
    }
);

__PACKAGE__->set_primary_key('language_id');
__PACKAGE__->add_unique_constraint(['language_code']);
__PACKAGE__->has_many('translations', 'SAMS::Schema::Result::Translation', 'language_id');
__PACKAGE__->has_many('countries', 'SAMS::Schema::Result::Country', 'language_id');

1;
