package SAMS::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

SAMS::Controller::Root - Root Controller for SAMS

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path(/) Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(
        account_search_fields => {
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
        },
        template => 'index.html',
    )
}

=head2 translate

A private routine for getting text from a database to allow for translatable lables

TODO: This need to be a) moved to a translation role. and b) connected to a model

=cut

sub translate :Private {
    my ($self, $c, $label) = @_;

    # should call $c->model('DB')->search({$label}) probably but the model isn't set up yet
    # for now just use the label we recieved

    return $label;
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Michael Francis,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
