package SAMS::Schema::Result::Account;
use base 'DBIx::Class::Core';

use Data::Dumper;
use SAMS::Error;
use Try::Tiny;

__PACKAGE__->table('accounts');
__PACKAGE__->add_columns(
    account_id      => {
        data_type           => 'int',
        is_auto_increment   => 1,
        is_numeric          => 1,
    },
    alt_account_id_1 => {
        data_type   => 'text',
        is_nullable => 1,
    },
    alt_account_id_2 => {
        data_type => 'text',
        is_nullable => 1,
    },
    legacy_account_id => {
        data_type => 'text',
        is_nullable => 1,
    },
    account_name    => {
        data_type   => 'text',
    },
    account_type_id => {
        data_type       => 'int',
        is_foreign_key  => 1,
        is_numeric      => 1,
    },
    contact_name => {
        data_type   => 'text',
    },
    street_1 => {
        data_type   => 'text',
    },
    street_2 => {
        data_type   => 'text',
        is_nullable => 1,
    },
    city     => {
        data_type   => 'text',
    },
    county   => {
        data_type   => 'text',
    },
    postcode => {
        data_type   => 'text',
    },
    country_id => {
        data_type       => 'int',
        is_foreign_key  => 1,
        is_numeric      => 1,
    },
    contact_title_id => {
        data_type       => 'int',
        is_numeric      => 1,
        is_foreign_key  => 1,
    },
    contact_job_title => {
        data_type   => 'text',
        is_nullable => 1,
    },
    contact_number => {
        data_type   => 'text',
    },
    mobile_number => {
        data_type   => 'text',
        is_nullable => 1,
    },
    fax_number => {
        data_type   => 'text',
        is_nullable => 1,
    },
    email_address   => {
        data_type   => 'text',
    },
    last_update_date    => {
        data_type       => 'timestamp with time zone',
        is_nullable     => 1,
        default_value   => \'now()',
    },
    last_update_user    => {
        data_type       => 'int',
        is_numeric      => 1,
        is_nullable     => 1,
        is_foreign_key  => 1,
    },
);

__PACKAGE__->set_primary_key('account_id');

# RELATIONSHIPS

__PACKAGE__->belongs_to('update_user', 'SAMS::Schema::Result::Account', 'last_update_user');
__PACKAGE__->has_many('update_accounts', 'SAMS::Schema::Result::Account', 'account_id');
__PACKAGE__->belongs_to('country', 'SAMS::Schema::Result::Country', 'country_id');
__PACKAGE__->belongs_to('account_type', 'SAMS::Schema::Result::AccountType', 'account_type_id');
__PACKAGE__->belongs_to('contact_title', 'SAMS::Schema::Result::ContactTitle', 'contact_title_id');

=head1 METHODS

These are custom methods for perfoming on a single Result(Row) from the db.

=head2 is_authorised ($action, $user)

Method for determining if the current user is authorised to undertake action($action)

returns 1 or 0

=cut

sub is_authorised {
    my ($self, $action, $account) = @_;

    return $self->account_id == $account->account_id;
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
    my $action = $input{action};

    # TODO: Replace with action in params
    my $action = $self->can($action);

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'No Account to update',
    ) unless $self->account_id;

    return SAMS::Error->new(
        level           => 'Error',
        error_message   => 'User not authorised to edit account '.$self->account_id,
    ) unless $user->is_authorised(update => $self);

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

        $self->$param($params->{$param});
    }

    try {
        $self->update();
    } catch {
        return SAMS::Error->new(
            level => 'Error',
            error_message => "Unable to update account ".$self->account_id,
            internal_error => $_,
        );
    };

    return $self;
}
1;
