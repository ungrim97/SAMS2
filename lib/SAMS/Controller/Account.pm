package SAMS::Controller::Account;
use Moose;
use namespace::autoclean;

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

sub account :Chained('/web') PathPart('account') CaptureArgs(0){
    my ($self, $c) = @_;

    if (!defined $c->stash->{account} && (my $account_id = $c->req->param('account_id'))){
        $c->stash->{account} = $c->model('DB')->resultset('Account')->find($account_id);
    } else {
        $c->stash->{account} = $c->stash->{user};
    }

    # Populate contact dropdowns
    $c->forward('populate_contact_dropdowns');

    # All account/* pages are linked from index.html
    $c->stash->{template} = 'index.html',
}

=head2 account_details

=cut

sub account_details :Path('account/account_details') Chained('account') :PathPart('account_details') Args(0) {
    my ($self, $c) = @_;

    my $user = $c->stash->{user};

    $c->log->info('Preparing account details for '.$user->account_name.' ('.$user->account_id.')');
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SAMS::Controller::Account in Account.');
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
