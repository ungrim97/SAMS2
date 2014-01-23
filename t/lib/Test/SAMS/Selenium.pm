package Test::SAMS::Selenium;

use Test::Class::Moose;
use Test::WWW::Selenium::Catalyst 'SAMS';
use Data::Dumper;

extends 'Test::SAMS';

has sel => (
    is  => 'rw',
    isa => 'Test::WWW::Selenium',
    lazy => 1,
    builder => '_build_selenium',
);

has labels => (
    is => 'rw',
    isa => 'HashRef',
    lazy => 1,
    builder => '_build_labels',
);

has account => (
    is => 'rw',
    isa => 'SAMS::Schema::Result::Account',
    lazy => 1,
    builder => '_build_test_account',
);

sub _build_selenium {
    my ($self) = @_;

    return Test::WWW::Selenium::Catalyst->start({app_uri => 'http://sams.mikef.dev.semantico.net'});
}

sub _build_test_account {
    my ($self) = @_;

    # Use Account 1 for now. Later we will likely need handlers for accounts
    # with differing permissions ect.
    return $self->db->resultset('Account')->find(1);
}

sub _build_labels {
    my ($self) = @_;

    my $labels = {};
    my @translations = $self->db->resultset('Language')->find({language_code => 'en'})->translations->all;
    for my $translation (@translations){
        $labels->{$translation->area}{$translation->name} = $translation->literal;
    }

    return $labels;
}


1;
