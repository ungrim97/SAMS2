package SAMS::Roles::Translate;
use Moose::Role;

=head1 NAME

SAMS::Roles::Translate - SAMS Translation handler

=head1 DESCRIPTION

A handler for connecting to the db and providing translations based on language settings

=head1 METHODS

=head2 translate

A private routine for getting text from a database to allow for translatable lables

TODO: This need to be a) moved to a translation role. and b) connected to a model

=cut

sub translate {
    my ($self, $label) = @_;

    # should call $c->model('DB')->search({$label}) probably but the model isn't set up yet
    # for now just use the label we recieved

    return $label;
}

1;


