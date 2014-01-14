use strict;
use warnings;

use Locale::Country;
use Locale::Object::Country;

sub {
    my ($schema, $version) = @_;
    my $n = 0;
    my @rows;
    for my $country_name (all_country_names()){
        # Contries must have a name and a Alpha 3 country code
        my $country = Locale::Object::Country->new(name => $country_name);
        next unless $country && $country->code_alpha3;

        # They must have a defined official language
        my ($primary_language) = $country->languages_official;
        next unless $primary_language;

        # That must be in our language list
        my $language = $schema->resultset('Language')->find({language_code => $primary_language->code_alpha2});
        next unless $language;

        push @rows, [++$n, $country->code_alpha3, $country->name, $language->language_id];
    };

    $schema->resultset('Country')->populate([
            ['country_id', 'country_code', 'country_name', 'language_id'],
            @rows,
        ]);
}
