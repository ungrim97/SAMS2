package SAMS::Controller::Account;
use Moose;
use namespace::autoclean;
use Try::Tiny;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SAMS::Controller::Account - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 account

This is the root action for the account/ namespace. Its main use is as a chain
base for actions in the account/* namespace. Should contain handling of
stash population for all actions in this namespace.

All page actions here should chain of account which in turn chains of auth->web which handles
authorisation and request based transactions such as translations.

Its main role is to get an account via the model based on the url path arg /account/*.
This is the account that the user is editing not necessarily the logged in user.

We don't need to inflate any of the sub objects here as all the data we need
is on the main account object

Errors in account retrieval, either because the account doesn't exist or the user doesn't have
permission to view the account should return the user to the main page (TODO: Maybe the previous page)
with an error stating why. 

ALL LOGIC ON HOW AN ACCOUNT IS FOUND SHOULD BE DEALT WITH IN THE MODELS RESULTSET

=cut

sub account :Chained('/web') PathPart('account') CaptureArgs(1){
    my ($self, $c, $account_id) = @_;

    my $user = $c->stash->{user};

    my $account;

    if ($user->account_id != $account_id){
        $c->log->info("Attempting to locate account $account_id");
        my $result = $c->model('DB::Account')->find_account(search_args => {
                account_id => $account_id
            });

        # Failure to find an the requested account for whatever reason
        # should render their errors on the index page.
        if (ref $result eq 'SAMS::Error'){
            push @{$c->stash->{errors}}, $result;
            $c->stash->{template} = 'index.html';
            $c->detach;
        }

        $account = $result;
    }

    # If we didn't detach in the if above then we have an account
    # If we skipped it then we are using the current users details
    $account //= $user;

    $c->log->info("Editing details for ".$account->account_name." (".$account->account_id.")");
    $c->stash->{account} = $account;

    # Populate contact dropdowns
    $c->forward('populate_contact_dropdowns');

    # All account/* pages are linked from index.html
    $c->stash(
        template    => 'account_details.html',
        update_uri  => '/account/'.$account->account_id.'/update_account',
    );
}

=head2 account_details

This is the landing page for the account_details navbar link. As all this page does is display the account
and the contact details in two tabs there is nothing to do as account loading occurs in the account sub above

=cut

sub account_details :Path('account/account_details') Chained('account') :PathPart('account_details') Args(0) {
    my ($self, $c) = @_;

    # MAIN PAGE FOR SUBSCRIBER SERVICE ACCOUNTS PAGES.
}

=head2 update_account

Call update account on the current account object and let it handle the logic
of how that is supposed to proceed.

Should recieve either a SAMS::Error object or an updated account object for display.

NO ACTUALL LOGIC FOR HOW AN UPDATE OCCURS SHOULD GO HERE.

=cut

sub update_account :Path('account/update_account') Chained('account') :PathPart('update_account') Args(0) {
    my ($self, $c) = @_;

    my $account = $c->stash->{account};
    $c->log->info('Updating account '.$account->account_id);

    my $result = $account->update_account(
        action  => 'update_'.($c->req->param('action')//'contact_details'),
        account => $account,
        user    => $c->stash->{user},
        params  => $c->req->params,
    );

    if (ref $result eq 'SAMS::Error'){
        push @{$c->stash->{errors}}, $result;
    } else {
        $c->stash->{account} = $result;
    }
}

=head2 populate_contact_dropdowns

This sub should populate the stash with all data needed for the various dropdowns needed on all
account/* pages

Drop Downs are:
    List of Country ID's => Country Name
    List of Contact Title ID's => Title Description

=cut

sub populate_contact_dropdowns :Private {
    my ($self, $c) = @_;

    my @countries = $c->model('DB')->resultset('Country')->all;
    my @contact_titles = $c->model('DB')->resultset('ContactTitle')->all;

    $c->stash(
        countries   => [
            map +{ $_->country_id => $_->country_name}, @countries
        ],
        contact_titles => [
            map +{$_->title_id, $_->description}, @contact_titles,
        ],
    );
}

=head1 USER DOCS

The account details page provides the user with the ability to view an account and the contact details associated
with it. In many cases these details will be for their account. But for Consortia/Parent accounts they may be able
to view other accounts. If the user has write permission to that account then the contact details are completely editable.

A user may only view their own account or a child account. Editablility of these accounts is controlled from the SAMS Admin Interface
but it is usually the case that if a user can view an account then they are able to edit it. To prevent a user editing an account
set the users account to read only administrator.

The required fields needed for editing are definable by the client JavaScript. Email address and Name are always required fields
if any fields are entered. No Server side validation occurs for any field except the email format. This is mostly due to the fact that HTML5 email validation
fails to correctly recognise valid/invalid email addresses. Its check is based purely on the presence of an @ symbol.

=encoding utf8

=head1 AUTHOR

Mike Francis,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
