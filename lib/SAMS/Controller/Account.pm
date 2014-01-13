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

=cut

sub account_details :Path('account/account_details') Chained('account') :PathPart('account_details') Args(0) {
    my ($self, $c) = @_;

    # MAIN PAGE FOR SUBSCRIBER SERVICE ACCOUNTS PAGES.
}

=head2 update_account

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

=encoding utf8

=head1 AUTHOR

Mike Francis,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
