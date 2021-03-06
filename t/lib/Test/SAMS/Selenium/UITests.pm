package Test::SAMS::Selenium::UITests;
use Test::More;
use Moose::Role;

requires 'labels';
requires 'sel';
requires 'account';

sub generic_layout_test {
    my ($self, $args) = @_;

    $self->navbar_tests;
    $self->header_tests($args);

    if (defined $args->{errors} && scalar @{$args->{errors}}){
        my @errors = @{$args->{errors}};
        $self->sel->is_visible_ok('//div[@id="problems"]', 'Error box is visible');
        $self->sel->is_visible_ok('//div[@id="problems"]/span[1]', '  -> with error icon');
        $self->sel->text_is('//div[@id="problems"]/span[2]' => 'Errors:', '  -> with "Errors:" text');

        for my $error_no (0..$#errors){
            $self->sel->text_is("//div[\@id='problems']/ul/li[$error_no + 1]" => $errors[$error_no], ' -> with correct error text');
        }
    } else {
        ok($self->sel->is_visible('//div[@id="problems"]') == 0, 'Error box is hidden');
    }
}

sub navbar_tests {
    my ($self) = @_;

    subtest 'Account NavBar' => sub {
        $self->account_navbar_tests();
    };

    subtest 'Access Token NavBar' => sub {
        $self->access_token_navbar_tests;
    };

    subtest 'Report NavBar' => sub {
        $self->report_navbar_tests;
    };

    subtest 'Information NavBar' => sub {
        $self->information_navbar_tests;
    };
}

sub account_navbar_tests {
    my ($self) = @_;

    # ACCOUNT NAVBAR ITEM TESTS
    $self->sel->is_element_present_ok("//li[1]/span", 'Account NavBar item exists');
    $self->sel->text_is("//li[1]/span", $self->labels->{navbar}{accounts}, '  -> with correct label');

    subtest 'Account Navbar subitems' => sub {
        $self->sel->is_element_present_ok("//li[1]/ul/li[1]/a", 'Account details subitem exists');
        $self->sel->text_is("//li[1]/ul/li[1]/a", $self->labels->{navbar}{account_details}, '  -> with correct label');

        $self->sel->is_element_present_ok("//li[1]/ul/li[2]/a", 'Account subscriptions subitem exists');
        $self->sel->text_is("//li[1]/ul/li[2]/a" => $self->labels->{navbar}{account_subscriptions}, "  -> with correct label");

        $self->sel->is_element_present_ok("//li[1]/ul/li[3]/a", 'Account credentials subitem exists');
        $self->sel->text_is("//li[1]/ul/li[3]/a" => $self->labels->{navbar}{account_credentials}, '  -> with correct label');

        $self->sel->is_element_present_ok("//li[1]/ul/li[4]/a", 'Account preferences subitem exists');
        $self->sel->text_is("//li[1]/ul/li[4]/a" => $self->labels->{navbar}{account_preferences}, '  -> with correct label');
    };
}

sub report_navbar_tests {
    my ($self) = @_;

    # REPORT NAVBAR ITEM TESTS
    $self->sel->is_element_present_ok("//li[2]/span", 'Reports NavBar item exists');
    $self->sel->text_is("//li[2]/span" => $self->labels->{navbar}{reports}, '  -> with correct label');
    $self->sel->click('//li[2]/span');

    subtest 'Report NavBar subitems' => sub {
        $self->sel->is_element_present_ok("//li[2]/ul/li[1]/a", 'Report ICOLC subitem exists');
        $self->sel->text_is("//li[2]/ul/li[1]/a", $self->labels->{navbar}{report_icolc}, '  -> with correct label');

        $self->sel->is_element_present_ok("//li[2]/ul/li[2]/span");
        $self->sel->text_is("//li[2]/ul/li[2]/span", $self->labels->{navbar}{report_counter});
        $self->sel->click("//li[2]/ul/li[2]/span"); # All navbar items should be collapsed for new sessions

        subtest 'COUNTER Subitems' => sub {
            $self->sel->is_element_present_ok("//li[2]/ul/li[2]/ul/li[1]/a", 'Report COUNTER 3 subitem exists');
            $self->sel->text_is("//li[2]/ul/li[2]/ul/li[1]/a" => $self->labels->{navbar}{report_counter_3}, '  -> with correct label');

            $self->sel->is_element_present_ok("//li[2]/ul/li[2]/ul/li[2]/a", 'Report COUNTER 4 subitem exists');
            $self->sel->text_is("//li[2]/ul/li[2]/ul/li[2]/a" => $self->labels->{navbar}{report_counter_4}, '  -> with correct label');
        };
    };
}

sub access_token_navbar_tests {
    my ($self) = @_;

    # ACCESS TOKENS NAVBAR ITEM TESTS
    $self->sel->is_element_present_ok("//li[3]/span", 'Access Tokens NavBar item exists');
    $self->sel->text_is("//li[3]/span", $self->labels->{navbar}{access_tokens}, '  -> with correct label');

    $self->sel->is_element_present_ok('//li[3]/ul/li[1]/a', 'Access Token Activation subitem exists');
    $self->sel->text_is("//li[3]/ul/li[1]/a" => $self->labels->{navbar}{access_token_activate}, '  -> with correct label');
}

sub information_navbar_tests {
    my ($self) = @_;

    $self->sel->is_element_present_ok("//li[4]/span", 'Information NavBar item exists');
    $self->sel->text_is("//li[4]/span", $self->labels->{navbar}{info}, '  -> with correct label');

    $self->sel->is_element_present_ok("//li[4]/ul/li[1]/a", 'Information Contact Us subitem exists');
    $self->sel->text_is('//li[4]/ul/li[1]/a' => $self->labels->{navbar}{info_contact}, '  -> with correct label');

    $self->sel->is_element_present_ok('//li[4]/ul/li[2]/a', 'Information Help subitem exists');
    $self->sel->text_is('//li[4]/ul/li[2]/a' => $self->labels->{navbar}{info_help}, '  -> with correct label');
}

sub header_tests {
    my ($self, $args) = @_;

    $self->sel->title_is($self->labels->{titles}{application_title}.' : '.$args->{page_title});
    $self->sel->is_element_present_ok("//body/div/h1/a/img[\@alt='".$self->labels->{titles}{application_title}."']", 'Client logo present');
}

1;
