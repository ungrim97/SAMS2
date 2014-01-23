package Test::SAMS;

use Test::Class::Moose;
use SAMS::Schema;

=head1 NAME

Test::SAMS

=head1 DESCRIPTION

Module for bootstrapping the call to Test::Class::Moose->new->runtests
in testing scripts.

Functions may include starting servers, handling DB stuff, loading config ect.

Any accessors in you sub class *should* be available to each test as the are subclasses of that.

=cut

has db => (
    is => 'rw',
    isa => 'SAMS::Schema',
    lazy => 1,
    builder => '_build_db',
);

sub _build_db {
    my ($self) = @_;

    return SAMS::Schema->connect('dbi:Pg:dbname=mikef-sams-3', 'mikef');
}

1;
