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

=head2 account_details

=cut

sub account_details :Chained('auth') Args(0) {
    my ($self, $c) = @_;

    $c->log->warn('Getting Account Details');

    my @countries = $c->model('DB')->resultset('Country')->all;
    $c->stash(
        # Subs only allows us to modify the current logged in user
        account     => $c->stash->{user},
        countries   => [
            map +{ $_->country_code => $_->country_name}, @countries
        ],
        template => 'index.html',
    );
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched SAMS::Controller::Account in Account.');
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
