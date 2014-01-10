package Test::SAMS::Selenium::Account;

use Test::Class::Moose extends => 'Test::SAMS::Selenium';
use Data::Dumper;

with 'Test::SAMS::Selenium::Roles::UITests';

sub test_account_details {
    my ($self) = @_;

    $self->sel->open('/account/'.$self->account->account_id.'/account_details');
    $self->navbar_tests;
    $self->header_tests;
    $self->sel->is_element_present_ok("//div/ul/li[1]/a", 'Account details tab exists');
    $self->sel->text_is('//div/ul/li[1]/a' => $self->labels->{tabs}{account_details}, '  -> with correct label');

    $self->sel->is_element_present_ok('//div/ul/li[2]/a', 'Contact details tab exists');
    $self->sel->text_is('//div/ul/li[2]/a' => $self->labels->{tabs}{contact_detaisl}, '  -> with correct label');

    $self->sel->text_is("//div[\@id='account_details']/p[1]", "View or change your contact details or account information.");
    $self->sel->text_is("//div[\@id='account_details']/p[2]", "If you would like us to change your contact details for you, or if you wish to change credentials details, please Contact Us");

    $self->sel->text_is("//div[\@id='account_details']/label[1]", $self->labels->{account}{name}, 'Correct Account name label');
    $self->sel->text_is("//span[\@name='account_name']" => $self->account->account_name, 'Account Name correct');

    $self->sel->text_is("//div[\@id='account_details']/label[2]", $self->labels->{account}{account_type}, 'Correct Account type label');
    $self->sel->text_is("//span[\@name='account_type']", $self->account->account_type->description, 'Account type correct');

    $self->sel->text_is("//div[\@id='account_details']/label[\@for='account_id']", $self->labels->{account}{account_id}, 'Correct Account ID label');
    $self->sel->text_is("//span[\@name='account_id']", $self->account->account_id, 'Account id correct');
};


sub test_contact_details {
    my ($self) = @_;

    $self->sel->open('/account/'.$self->account->account_id.'/account_details');
    $self->sel->click('//a[contains(@href,"#contact_details")]');

    $self->sel->is_element_present_ok("css=#account_details_nav > a");
    $self->sel->is_element_present_ok("css=#contact_details_nav > a");

}

sub test_update_contact_details {}
#$self->sel->is_element_present_ok("css=span.headerText.ui-widget-header");
#$self->sel->is_element_present_ok("//input[\@value='Save Changes']");
#$self->sel->text_is("//input[\@value='Save Changes']", "");
#$self->sel->value_is("//input[\@value='Save Changes']", "Save Changes");
#$self->sel->is_element_present_ok("css=h4");
#$self->sel->text_is("css=h4", "Account contact details");
#$self->sel->is_element_present_ok("css=#contact_details > p");
#ok($self->sel->get_text("css=#contact_details > p") =~ /^exact:Fields marked [\s\S]* are required\.$/);
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[2]");
#$self->sel->text_is("//div[\@id='contact_details']/label[2]", "Title");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[3]");
#$self->sel->text_is("//div[\@id='contact_details']/label[3]", "Organisation");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[4]");
#$self->sel->text_is("//div[\@id='contact_details']/label[4]", "Occupation");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[5]");
#$self->sel->text_is("//div[\@id='contact_details']/label[5]", "Address Line 1");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[6]");
#$self->sel->text_is("//div[\@id='contact_details']/label[6]", "Address Line 2");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[7]");
#$self->sel->text_is("//div[\@id='contact_details']/label[7]", "Town/City");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[8]");
#$self->sel->text_is("//div[\@id='contact_details']/label[8]", "County");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[9]");
#$self->sel->text_is("//div[\@id='contact_details']/label[9]", "ZIP/Postcode");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[10]");
#ok($self->sel->get_text("//div[\@id='contact_details']/label[10]") =~ /^exact:Country [\s\S]*$/);
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[11]");
#$self->sel->text_is("//div[\@id='contact_details']/label[11]", "Phone Number");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[12]");
#$self->sel->text_is("//div[\@id='contact_details']/label[12]", "Mobile/Cell Number");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[13]");
#$self->sel->text_is("//div[\@id='contact_details']/label[13]", "Fax Number");
#$self->sel->is_element_present_ok("//div[\@id='contact_details']/label[14]");
#ok($self->sel->get_text("//div[\@id='contact_details']/label[14]") =~ /^exact:Email Address [\s\S]*$/);
#$self->sel->is_element_present_ok("id=contact_title_id");
#$self->sel->text_is("id=contact_title_id", "Mr");
#$self->sel->is_element_present_ok("id=contact_name");
#$self->sel->text_is("id=contact_name", "");
#$self->sel->value_is("id=contact_name", "Mike Francis");
#$self->sel->is_element_present_ok("id=contact_job_title");
#$self->sel->text_is("id=contact_job_title", "");
#$self->sel->value_is("id=contact_job_title", "Perl Gorilla");
#$self->sel->is_element_present_ok("id=street_1");
#$self->sel->text_is("id=street_1", "");
#$self->sel->value_is("id=street_1", "13 Sterling Close");
#$self->sel->text_is("id=street_2", "");
#$self->sel->is_element_present_ok("id=street_2");
#$self->sel->value_is("id=street_2", "World's End");
#$self->sel->is_element_present_ok("id=city");
#$self->sel->text_is("id=city", "");
#$self->sel->value_is("id=city", "Burgess Hill");
#$self->sel->is_element_present_ok("id=county");
#$self->sel->text_is("id=county", "");
#$self->sel->value_is("id=county", "West Sussex");
#$self->sel->is_element_present_ok("id=postcode");
#$self->sel->text_is("id=postcode", "");
#$self->sel->value_is("id=postcode", "RH15 0PU");
#$self->sel->is_element_present_ok("id=country_id");
#$self->sel->text_is("id=country_id", "United Kingdom");
#$self->sel->is_element_present_ok("id=contact_number");
#$self->sel->text_is("id=contact_number", "");
#$self->sel->value_is("id=contact_number", "01444 243 347");
#$self->sel->is_element_present_ok("id=mobile_number");
#$self->sel->text_is("id=mobile_number", "");
#$self->sel->value_is("id=mobile_number", "07581 208879");
#$self->sel->is_element_present_ok("id=fax_number");
#$self->sel->text_is("id=fax_number", "");
#$self->sel->value_is("id=fax_number", "");
#$self->sel->is_element_present_ok("id=email_address");
#$self->sel->text_is("id=email_address", "");
#$self->sel->value_is("id=email_address", "mikef\@semantico.net");
#$self->sel->type_ok("id=contact_job_title", "Perl Gorilla");
#$self->sel->click_ok("//input[\@value='Save Changes']");
#$self->sel->wait_for_page_to_load_ok("30000");
#$self->sel->click_ok("link=Contact Details");
#$self->sel->value_is("id=contact_job_title", "Perl Gorilla");
#$self->sel->text_is("link=Contact Details", "Contact Details");
#
1;
