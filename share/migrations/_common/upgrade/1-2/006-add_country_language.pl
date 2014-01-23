use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

use Locale::Country;
use Locale::Object::Country;

migrate {
    my $schema = shift->schema;
    my $country_rs = $schema->resultset('Country');

    my @current_countries = $country_rs->all;
    for my $country (@current_countries){

        my $locale_country;
        if (length $country->country_id == 2){
            $locale_country = Locale::Object::Country->new(code_alpha2 => $country->country_id);
        } else {
            $locale_country = Locale::Object::Country->new(code_alpha3 => $country->country_id);
        }

        next unless $locale_country;

        # They must have a defined official language
        my ($primary_language) = $locale_country->languages_official;
        next unless $primary_language;

        # That must be in our language list
        my $language = $schema->resultset('Language')->find({language_code => $primary_language->code_alpha2});
        next unless $language;

        $country->language_id($language->language_id);
        $country->update;
    };
}
