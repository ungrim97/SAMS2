package SAMS::Schema::ResultSet::Account;

use Moose;
use namespace::autoclean;
use MooseX::NonMoose;
use Try::Tiny;

extends 'DBIx::Class::ResultSet';

# NOTE: See C<DBIx::Class::ResultSet> for the reason the below
# is needed

sub BUILDARGS { $_[2] };

=head1 NAME

SAMS::Schame::ResultSet::Account

=head1 DESCRIPTION

A DBIx::Class::ResultSet class for custom queries against the Account ResultSet

=head1 METHODS

A list of custom 'Canned' queries for dealing with custom business logic on a whole resultset

=head2 find_account 

A base replacement for the DBIx::Class::ResultSet::search method. Should be used to allow
for custom relationship inflation ect

=cut

sub find_account {
    my ($self, %input) = @_;

    my $result;
    try {
        $result = $self->find($input{search_args});
    };

    $result //= SAMS::Error->new(error_message => 'No Account found');

    return $result;
}

__PACKAGE__->meta->make_immutable;
1;
