package SAMS::Controller::Admin::AJAX;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

SAMS::Controller::Admin::AJAX - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

__PACKAGE__->config(
    namespace => 'ajax_widgets'
);

sub find_accounts :Path('find_accounts') :Args(0) {
    my ($self, $c) = @_;

    $c->log->warn('IN FIND ACCOUNTS');

    # TODO: This should probably be handed off to the Model with the params and recieve an array of accounts.
    my $account = $c->model('DB')->resultset('Account')->find({account_id => $c->req->param('acc_id')});

    # TODO: Account Listing expects a JSON response. This should use a new view called JSON.

    $c->stash(
        iTotalDisplayRecords => '1',
        iTotalRecords        => '1',
        sEcho                => $c->req->param('sEcho'),
        aaData => [
            [
                $account->account_id,
                $account->account_name,
                '',
            ],
        ],
    );
    $c->forward('View::JSON');
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SAMS::Controller::Admin::AJAX in Admin::AJAX.');
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
