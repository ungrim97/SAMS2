package SAMS::Schema::Result::Translation;
use base 'DBIx::Class::Core';

__PACKAGE__->table('translations');
__PACKAGE__->add_columns(
    area => {
        data_type => 'text',
    },
    name => {
        data_type => 'text',
    },
    literal => {
        data_type => 'text',
    },
    language_id => {
        data_type       => 'int',
        is_numeric      => 1,
        is_foreign_key  => 1,
    },
);

__PACKAGE__->belongs_to('language', 'SAMS::Schema::Result::Language', 'language_id');
1;
