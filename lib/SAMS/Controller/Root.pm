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

=cut

sub auth :Chained(/) :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->log->warn('RUNNING AUTH');
    # $c->stash->{user} should always be the logged in user.
    # $c->stash->{account} will contain the account being modified/looked at

    unless ($c->stash->{user} && $c->stash->{is_authorised}){
        #$c->forward('Controller::Auth');
        $c->stash->{user} = $c->model('DB')->resultset('Account')->find({account_id => 1});
        $c->stash->{is_readonly} = 0;
    }
}

=head2 index

=cut

sub index :Path :Chained('auth') :PathPart('') :Args(0) {
   my ($self, $c) = @_;

    $c->go('/account_details');
}

=head2 account_details

=cut

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
