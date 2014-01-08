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

