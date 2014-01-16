package Tests::SAMS::Selenium::Account;

use Test::Class::Moose extends => 'Test::SAMS::Selenium';
use Data::Random qw/:all/;
use Data::Dumper;

with 'Test::SAMS::Selenium::UITests';

=head1 NAME

Tests::SAMS::Selenium::Account

=head1 DESCRIPTION

Class for frontend testing of /account/*/ pages.

=head1 SYNOPSIS

    use Test::Class::Moose extends => 'Test::SAMS::Selenium';
    with 'Test::SAMS::Selenium::UITests';

    sub test_* {}

=head1 METHODS

=head2 test_account_details

This method provides tests for /account/*/account_details/

=cut

sub test_account_details {
    my ($self) = @_;

    $self->sel->open_ok('/account/'.$self->account->account_id.'/account_details', 'Account page loaded ok');

    $self->generic_account_layout_test;

    $self->sel->text_is("//div[\@id='account_details']/p[1]", "View or change your contact details or account information.");
    $self->sel->text_is("//div[\@id='account_details']/p[2]", "If you would like us to change your contact details for you, or if you wish to change credentials details, please Contact Us");

    $self->sel->text_is("//div[\@id='account_details']/label[1]", $self->labels->{account}{name}, 'Correct Account name label');
    $self->sel->text_is("//span[\@name='account_name']" => $self->account->account_name, 'Account Name correct');

    $self->sel->text_is("//div[\@id='account_details']/label[2]", $self->labels->{account}{account_type}, 'Correct Account type label');
    $self->sel->text_is("//span[\@name='account_type']", $self->account->account_type->description, 'Account type correct');

    $self->sel->text_is("//div[\@id='account_details']/label[\@for='account_id']", $self->labels->{account}{account_id}, 'Correct Account ID label');
    $self->sel->text_is("//span[\@name='account_id']", $self->account->account_id, 'Account id correct');
};

=head2 test_contact_details

Tests for /account/*/contact_details

=cut

sub test_contact_details {
    my ($self) = @_;

    $self->sel->open_ok('/account/'.$self->account->account_id.'/account_details', 'Account page loaded ok');
    $self->sel->click_ok('//a[contains(@href,"#contact_details")]', 'Selected Contact details tab');

    $self->generic_account_layout_test;

    my $xpath = '//div[@id="contact_details"]';
    $self->sel->is_element_present_ok("$xpath/h4", 'Accout contact details sub header exists');
    $self->sel->text_is("$xpath/h4" => "Account contact details", '  -> with correct text');

    $self->sel->is_element_present_ok("$xpath/p", 'Required field text exists');
    $self->sel->text_is("$xpath/p" => 'Fields marked * are required.', '  -> with correct text');

    $self->sel->is_element_present_ok("$xpath/label[1]", 'Has Contact Title Label');
    $self->sel->text_is("$xpath/label[1]" => $self->labels->{contact}{title}, '  -> with correct literal');
    $self->sel->is_element_present_ok("$xpath/select[\@id='contact_title_id']" , 'Contact Title dropdown exists');
    $self->sel->value_is("$xpath/select[\@id='contact_title_id']" => $self->account->contact_title_id, '  -> with correct selected value');

    subtest 'Contact Titles dropdown' => sub {
        my @contact_titles = $self->db->resultset('ContactTitle')->all;
        for my $contact_title (@contact_titles){
            my $xpath = $xpath."/select[\@id='contact_title_id']/option[".$contact_title->title_id."]";
            $self->sel->is_element_present_ok("$xpath", "Title ".$contact_title->title_id." exists");
            $self->sel->value_is("$xpath" => $contact_title->title_id, '  -> with correct value');
            $self->sel->text_is("$xpath" => $contact_title->description, '  -> with correct literal');
        }
    };

    $self->sel->is_element_present_ok("$xpath/label[2]", 'Contact name label exists');
    $self->sel->text_is("$xpath/label[2]" => $self->labels->{contact}{name}, '  -> with correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='contact_name']", 'Contact Name textbox exists');
    $self->sel->value_is("$xpath/input[\@id='contact_name']" => $self->account->contact_name, '  -> with correct value');

    $self->sel->is_element_present_ok("$xpath/label[3]", 'Contact Job Title label exists');
    $self->sel->text_is("$xpath/label[3]" => $self->labels->{contact}{job_title}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='contact_job_title']", 'Contact Job Title textbox exists');
    $self->sel->value_is("$xpath/input[\@id='contact_job_title']" => $self->account->contact_job_title, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[4]", 'Address Line 1 label exists');
    $self->sel->text_is("$xpath/label[4]" => $self->labels->{contact}{street_1}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='street_1']", 'Address Line 1 textbox exists');
    $self->sel->value_is("$xpath/input[\@id='street_1']" => $self->account->street_1, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[5]", 'Address Line 2 label exists');
    $self->sel->text_is("$xpath/label[5]" => $self->labels->{contact}{street_2}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='street_2']", 'Address Line 2 textbox exists');
    $self->sel->value_is("$xpath/input[\@id='street_2']" => $self->account->street_2, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[6]", 'City label exists');
    $self->sel->text_is("$xpath/label[6]" => $self->labels->{contact}{city}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='city']", 'City textbox exists');
    $self->sel->value_is("$xpath/input[\@id='city']" => $self->account->city, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[7]", 'County label exists');
    $self->sel->text_is("$xpath/label[7]" => $self->labels->{contact}{county}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='county']", 'County textbox exists');
    $self->sel->value_is("$xpath/input[\@id='county']" => $self->account->county, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[8]", 'Postcode lable exists');
    $self->sel->text_is("$xpath/label[8]" => $self->labels->{contact}{postcode}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='postcode']", 'Postcode textbox exists');
    $self->sel->value_is("$xpath/input[\@id='postcode']" => $self->account->postcode, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[9]", 'Contries label exists');
    $self->sel->text_is("$xpath/label[9]" => $self->labels->{contact}{country}.' *', '  -> With correct literal');

    subtest 'Countries dropdown' => sub {
        my @countries = $self->db->resultset('Country')->all;
        for my $country (@countries){
            my $xpath = $xpath."/select[\@id='country_id']/option[".$country->country_id."]";
            $self->sel->is_element_present_ok("$xpath", "Country ".$country->country_id." exists");
            $self->sel->value_is("$xpath" => $country->country_id, '  -> with correct value');
            $self->sel->text_is("$xpath" => $country->country_name, '  -> with correct literal');
        }
    };

    $self->sel->is_element_present_ok("$xpath/label[10]", 'Contact Number label exists');
    $self->sel->text_is("$xpath/label[10]" => $self->labels->{contact}{phone_number}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='contact_number']", 'Contact Number textbox exists');
    $self->sel->value_is("$xpath/input[\@id='contact_number']" => $self->account->contact_number, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[11]", 'Mobile Number label exists');
    $self->sel->text_is("$xpath/label[11]" => $self->labels->{contact}{mobile_number}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='mobile_number']", 'Mobile Number textbox exists');
    $self->sel->value_is("$xpath/input[\@id='mobile_number']" => $self->account->mobile_number, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[12]", 'Fax Number label exists');
    $self->sel->text_is("$xpath/label[12]" => $self->labels->{contact}{fax_number}, '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='fax_number']", 'Fax Number textbox exists');
    $self->sel->value_is("$xpath/input[\@id='fax_number']" => $self->account->fax_number, '  -> with correct value' );

    $self->sel->is_element_present_ok("$xpath/label[13]", 'Email Address label exists');
    $self->sel->text_is("$xpath/label[13]" => $self->labels->{contact}{email_address}.' *', '  -> With correct literal');
    $self->sel->is_element_present_ok("$xpath/input[\@id='email_address']", 'Email Address textbox exists');
    $self->sel->value_is("$xpath/input[\@id='email_address']" => $self->account->email_address, '  -> with correct value' );
}

=head2 test_update_contact_details

Test for the /account/*/update_details.

These are functional tests for the updating of the account contact details.

=cut

sub test_update_contact_details {
    my ($self) = @_;

    $self->sel->open_ok('/account/'.$self->account->account_id.'/account_details/');
    my $xpath = '//div[@id="contact_details"]';

    subtest 'Text Field' => sub {
        # Text fields have no constraints on their values. Any text is allowable so no errors should
        # be displayed.
        for my $field (qw/contact_name contact_job_title street_1 street_2 city county/){
            my ($random_word) = rand_words();

            $self->sel->type_ok("$xpath/input[\@id='$field']" => $random_word, "Typed $random_word into $field");
            $self->sel->click_ok('//input[@value="'.$self->labels->{buttons}{submit_changes}.'"]', '  -> Submited ok');
            $self->sel->wait_for_page_to_load_ok("3000");
            $self->sel->click('link='.$self->labels->{tabs}{contact_details});
            $self->sel->value_is("$xpath/input[\@id='$field']" => $random_word, "Field $field updated correctly");

            $self->generic_account_layout_test;
        }
    };

    subtest 'Dropdown selections' => sub {
        # Select boxes could error on strange override so we should ensure
        # we catch any errors from that. Otherwise the list defines the allowable
        # values

        subtest 'Country dropdown' => sub {
            my @countries = $self->db->resultset('Country')->all;
            my $max_countries = scalar @countries - 1;
            my $random_element = int(rand($max_countries));

            $self->sel->select_ok("$xpath/select[\@id='country_id']/" => "value=$random_element", "Selected country $random_element");
            $self->sel->click_ok('//input[@value="'.$self->labels->{buttons}{submit_changes}.'"]', '  -> Submited ok');
            $self->sel->wait_for_page_to_load_ok("3000");
            $self->sel->click('link='.$self->labels->{tabs}{contact_details});
            $self->sel->value_is("$xpath/select[\@id='country_id']" => $random_element, 'Country dropdown updated correctly');

            $self->generic_account_layout_test;
        };

        subtest 'Contact Titles dropdown' => sub {
            my @titles = $self->db->resultset('ContactTitle')->all;
            my $max_titles = scalar @titles - 1;
            my $random_element = int(rand($max_titles));

            $self->sel->select_ok("$xpath/select[\@id='contact_title_id']", "value=$random_element", "Selected title $random_element");
            $self->sel->click_ok('//input[@value="'.$self->labels->{buttons}{submit_changes}.'"]', '  -> Submited ok');
            $self->sel->wait_for_page_to_load_ok("3000");
            $self->sel->click("link=".$self->labels->{tabs}{contact_details});
            $self->sel->value_is("$xpath/select[\@id='contact_title_id']" => $random_element, 'Contact Title dropdown updated correctly');

            $self->generic_account_layout_test;
        };
    };

    subtest 'Email handling' => sub {
        # Emails are the only thing on the form that can really be input wrong without turning of JS/HTML5
        # Those things are handled in DB tests.
        #
        # The HTML5 email handler is inflexible compared to the RFC spec. Currently SAMS will allow RFC emails but the
        # input fields allow only HTML5. This will likely change as customers want UTF-8 chars in their emails which
        # HTML5 doesn't support

        # Valid Email
        $self->sel->type_ok("$xpath/input[\@id='email_address']", 'test@semantico.net', 'Valid email address input ok');
        $self->sel->click_ok('//input[@value="'.$self->labels->{buttons}{submit_changes}.'"]', '  -> Submited ok');
        $self->sel->wait_for_page_to_load_ok("3000");
        $self->sel->click("link=".$self->labels->{tabs}{contact_details});
        $self->sel->value_is("$xpath/input[\@id='email_address']" => 'test@semantico.net', "Updated email address correctly");

        $self->generic_account_layout_test;
    };
}

=head2 generic_account_layout_tests

Tests that should apply to every tab on the account page.

=cut

sub generic_account_layout_test {
    my ($self, $with_error) = @_;

    subtest 'Generic Account Page layout tests' => sub {
        $self->header_tests;
        $self->navbar_tests;

        $self->sel->is_element_present_ok("//div/ul/li[1]/a", 'Account details tab exists');
        $self->sel->text_is('//div/ul/li[1]/a' => $self->labels->{tabs}{account_details}, '  -> with correct label');

        $self->sel->is_element_present_ok('//div/ul/li[2]/a', 'Contact details tab exists');
        $self->sel->text_is('//div/ul/li[2]/a' => $self->labels->{tabs}{contact_details}, '  -> with correct label');

        $self->sel->is_element_present_ok("//div[\@id='save_changes']", 'Form submit button present');
        $self->sel->value_is("//div[\@id='save_changes']/input" => $self->labels->{buttons}{submit_changes}, '  -> with correct label');

        $self->sel->is_element_present_ok("//div[\@id='problems']", 'Problems box is present');
        if ($with_error){
            $self->sel->is_visible_ok('//div[@id="problems"]', '  -> is visible');
        } else {
            ok($self->sel->is_visible('//div[@id="problems"]') == 0, '  -> is hidden');
        }
    };
}

1;
