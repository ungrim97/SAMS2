use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $account_rs = shift->schema->resultset('Account');

    my @accounts = $account_rs->all;

    for my $account (@accounts){
        next unless $account->contact_given_name || $account->contact_family_name;
        $account->contact_name($account->contact_given_name.' '.$account->contact_family_name);
        $account->update;
    }
};
