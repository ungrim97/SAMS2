package SAMS::Model::DB::Account;
use SAMS::Error;

=head1 NAME

SAMS::Model::DB::Account

=head1 DESCRIPTION

Custom methods for implementing on a single DBIC result object.

=cut

sub is_authorised {

    return 1
}

sub update_account {
    my ($self, %input) = @_;
    my $params = $input{params};
    my $user   = $input{user};

    # Replace with action in params
    my $action = $self->can('update_contact_details');

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'No Account to update',
    ) unless $self->account_id;

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'User not authorised to edit account '.$account->account_id,
    ) unless $user->is_authorised(update => $account);

    $self->$action($params, $user);
}

sub update_contact_details {
    my ($self, $params, $user) = @_;

    # Remove any params that aren't account columns
    for my $param (keys $params){
        delete $params->{$param} unless $self->has_column($param);
    }

    $self->update($params);

    return $self;
}
1;
