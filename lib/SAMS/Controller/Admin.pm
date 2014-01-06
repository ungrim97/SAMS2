package SAMS::Controller::Admin;
use Moose;
use namespace::autoclean;
with 'SAMS::Roles::Translate';

BEGIN {
    extends 'Catalyst::Controller';
}

=head1 NAME

SAMS::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.
Base namespace of SAMS Admin controllers

=head1 METHODS

=cut

=head2 admin

The root handler for the SAMS Admin index page

=cut

sub admin :Path Args(0) {
    my ( $self, $c ) = @_;

    $c->forward('populate_account_search_stash');
    $c->stash->{template} = 'index.html';
}

sub populate_account_search_stash :Private {
    my ($self, $c) = @_;

    $c->stash->{account_search_fields} = {
            organisation        => $self->translate('organisation'),
            acc_id              => $self->translate('acc_id'),
            subs_id             => $self->translate('subs_id'),
            organisation_id     => $self->translate('organisation_id'),
            entity_id           => $self->translate('entity_id'),
            contact_name        => $self->translate('contact_name'),
            contact_forename    => $self->translate('contact_forename'),
            alternative_subs_id => $self->translate('alternative_subs_id'),
            msd_order_id        => $self->translate('msd_order_id'),
            if_acc_id           => $self->translate('if_acc_id'),
            notes               => $self->translate('notes'),
            city                => $self->translate('city'),
            county              => $self->translate('county'),
            msd_customer_id     => $self->translate('msd_customer_id'),
            oed_sid             => $self->translate('oed_sid'),
            email               => $self->translate('email'),
            username            => $self->translate('username'),
            ip_address          => $self->translate('ip_address'),
            referrer            => $self->translate('referrer'),
    };
    $c->stash->{account_types} = {
            institution     => $self->translate('institution'),
    };
    $c->stash->{subscription_types} = {
            trial       => $self->translate('trial'),
            full        => $self->translate('full'),
            gratis      => $self->translate('gratis'),
    };
    $c->stash->{subscription_status} = {
            ok          => $self->translate('ok'),
            expired     => $self->translate('expired'),
    };
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
