package SAMS::Schema::ResultSet::Account;

use Moose;
use namespace::autoclean;
use MooseX::NonMoose;

extends 'DBIx::Class::ResultSet';

use SAMS::Error;
use Data::Dumper;

sub BUILDARGS {
    $_[2];
}

sub update_account {
    my ($self, %input) = @_;
    my $params = $input{params};
    my $user   = $input{user};

    my $action = $self->can('update_contact_details');

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'No Account to update',
    ) unless $params->{account_id};

    my $account = $self->find($params->{account_id});

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'User not authorised to edit account '.$params->{account_id},
    ) unless $user->is_authorised(update => $account);

    $self->$action($account, $params, $user);
}

sub update_contact_details {
    my ($self, $account, $params, $user) = @_;

    # Remove any params that aren't account columns
    for my $param (keys $params){
        delete $params->{$param} unless $account->has_column($param);
    }

    $account->update($params);

    return $account;
}
