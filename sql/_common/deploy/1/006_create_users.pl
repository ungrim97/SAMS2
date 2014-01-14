use strict;
use warnings;

sub {
    my ($schema, $version) = @_;

    $schema->resultset('Account')->populate([
            [qw/account_id alt_account_id_1 alt_account_id_2 legacy_account_id account_name account_type_id contact_name street_1 street_2 city county postcode country_id contact_title_id contact_job_title contact_number mobile_number fax_number email_address last_update_date/],
            ['1', '', '', '', 'Semantico', '1', 'dictatorial', 'retried', 'wreak', 'Sutton', 'subscription', 'RH15 0PU', '1', '1', 'senior', '01444 243 347', '07581 208879', '', 'mikef@semantico.net', '2014-01-07 15:11:14.656222+00'],
        ]);
}
