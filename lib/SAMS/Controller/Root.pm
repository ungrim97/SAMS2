package SAMS::Controller::Root;
use Moose;
use namespace::autoclean;
use Data::Dumper;

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

Core actions for chaining all pages off.

=head1 METHODS

=cut

sub auth :Chained(/) :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;

    # $c->stash->{user} should always be the logged in user.
    # $c->stash->{account} will contain the account being modified/looked at

    unless ($c->stash->{user}){
        #$c->forward('Controller::Auth');
        my $user = $c->model('DB::Account')->find(1);

        unless ($user){
            push @{$c->error}, SAMS::Error->new(error_message => 'Unable to authorise user', error_level => 'Critacal');
            $c->template('login.html');
            $c->detach;
        }

        $c->stash->{user} = $user;
        $c->stash->{is_readonly} = 0;
    }
}

=head2 web

Actions that need to be populated prior to *every* request such as auth and translations

=cut

sub web :Chained('auth') :PathPart('') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->forward('load_translations');
}

=head2 load_translations

TODO: Move this to the Translate role

=cut

sub load_translations :Private {
    my ($self, $c) = @_;

    my @translations = $c->model('DB')->resultset('Language')->find({language_code => 'en'})->translations->all;

    my $labels = {};

    for my $translation (@translations){
        $labels->{$translation->area}{$translation->name} = $translation->literal;
    }

    $c->stash->{labels} = $labels;
}


sub index :Path PathPart('') :Args(0){
    my ($self, $c) = @_;
    $c->forward('auth');
    $c->forward('web');
    $c->stash(template => 'index.html');
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

sub end : ActionClass('RenderView') {
    my ($self, $c) = @_;

    $c->log->error("Error:\n".Dumper($_)) for @{$c->stash->{errors}};
    if (@{$c->error}){
        $c->log->warn("Error:\n".Dumper($_)) for @{$c->error};

        #$c->forward('send_technical_email');
        $c->stash->{template} = 'error.html';
    }
}

=head1 AUTHOR

Michael Francis,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
