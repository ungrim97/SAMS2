use Locale::Language;

sub {
    my ($schema, $version) = @_;

    my $language = $schema->resultset('Language')->find({language_code => language2code('english')});
    my $language_id = $language->id;

    $schema->resultset('Translation')->populate([
            ['area', 'name', 'literal', 'language_id'],
            ['account', 'name', 'Organisation', $language_id],
            ['account', 'account_id', 'Account ID', $language_id],
            ['account', 'account_type', 'Account Type', $language_id],
            ['contact', 'title', 'Title', $language_id],
            ['contact', 'name', 'Contact Name', $language_id],
            ['contact', 'job_title', 'Occupation', $language_id],
            ['contact', 'street_1', 'Address Line 1', $language_id],
            ['contact', 'street_2', 'Address Line 2', $language_id],
            ['contact', 'city', 'Town/City', $language_id],
            ['contact', 'county', 'County', $language_id],
            ['contact', 'postcode', 'ZIP/Postcode', $language_id],
            ['contact', 'country', 'Country', $language_id],
            ['contact', 'phone_number', 'Phone Number', $language_id],
            ['contact', 'mobile_number', 'Mobile/Cell Number', $language_id],
            ['contact', 'fax_number', 'Fax Number', $language_id],
            ['contact', 'email_address', 'Email Address', $language_id],
            ['buttons', 'submit_changes', 'Save Changes', $language_id],
            ['titles', 'account_details_page', 'Account Details', $language_id],
            ['titles', 'application_title', 'SAMS: Subscriber Interface', $language_id],
            ['tabs', 'account_details', 'Account Details', $language_id],
            ['tabs', 'contact_details', 'Contact Details', $language_id],
            ['navbar', 'accounts', 'Account Management', $language_id],
            ['navbar', 'account_details', 'Account Details', $language_id],
            ['navbar', 'account_subscriptions',  'Subscription Details', $language_id],
            ['navbar', 'account_credentials', 'Credentials', $language_id],
            ['navbar', 'account_preferences', 'Preferences', $language_id],
            ['navbar', 'reports', 'Reporting Tools', $language_id],
            ['navbar', 'report_icolc', 'ICOLC', $language_id],
            ['navbar', 'report_counter', 'COUNTER Reporting', $language_id],
            ['navbar', 'report_counter_3', 'COUNTER 3', $language_id],
            ['navbar', 'report_counter_4', 'COUNTER 4', $language_id],
            ['navbar', 'access_tokens', 'Access Tokens', $language_id],
            ['navbar', 'access_token_activate', 'Redeem Access Tokens', $language_id],
            ['navbar', 'info', 'Support', $language_id],
            ['navbar', 'info_contact', 'Contact Us', $language_id],
            ['navbar', 'info_help', 'Help', $language_id],
        ]);
}
