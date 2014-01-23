use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

use Locale::Language;
use Locale::Object::Language;

migrate {
    my $language_rs = shift->schema->resultset('Language');

    my $n = 0; # Generate language ID
    my @rows;
    for my $language_name (all_language_names()){
        my $language = Locale::Object::Language->new(name => $language_name);
        next unless $language && $language->code_alpha2;
        push @rows, [++$n, $language->code_alpha2, $language->name];
    }

    $language_rs->populate([
            ['language_id', 'language_code', 'language_name'],
            @rows,
        ]);
};
