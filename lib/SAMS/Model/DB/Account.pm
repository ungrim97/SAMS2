package SAMS::Model::DB::Account;
use SAMS::Error;

=head1 NAME

SAMS::Model::DB::Account

=head1 DESCRIPTION

Custom methods for implementing on a single DBIC account result (Single Row).

=cut

=head1 METHODS

=head2 is_authorised ($action, $user)

Method for determining if the current user is authorised to undertake action($action)

returns 1 or 0

=cut

sub is_authorised {

    return 1
}

=head2 update_account (%update_args, $update_user)

Main input for updating account. Will hand of to other smaller methods for
individual logic on updating certain records.

return either an updated account($self) or a SAMS::Error

=cut

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

=head2 update_contact_details (\%update_params, $update_user)

Routine for handling the logic around update account contact details.
Any specific on how contact details should be updated on the account should go here.

returns either an updated account($self) or a SAMS::Error object

=cut

sub update_contact_details {
    my ($self, $params, $user) = @_;

    # Remove any params that aren't account columns
    for my $param (keys $params){
        next unless $self->has_column($param);
        $self->$param($params->{$param}) || return SAMS::Error->new(
            level => 'Error'
            error_message => "Unable to update $param."
        );
    }

    $self->update();
    return $self;
}

1;
