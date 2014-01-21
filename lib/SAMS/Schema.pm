package SAMS::Schema;

use 5.008005;

use Moose;
use MooseX::MarkAsMethods autoclean => 1;

our $VERSION = 1;

extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;

__END__

=encoding utf-8

=head1 NAME

SAMS::Schema - Module for DBIx::Class mapping of the SAMS DB

=head1 SYNOPSIS

    use SAMS::Schema;
    my $schema = SAMS::Schema->connect(%connect_args);
    $schema->resultset('Account')->search({});

=head1 DESCRIPTION

SAMS::Schema is a DBIx::Class::Schema subclass representing the SAMS DB.
Its main use is withing the SAMS application suite but it can be used from outside

This can be used in a Catalyst application as a model in the normal way for a DBIx::Class schema

=head1 SEE ALSO

C<DBIx::Class>
C<Catalyst::Model::DBIC>
C<DBIx::Class::Schema>

=head1 LICENSE

Copyright (C) Mike Francis.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Mike Francis E<lt>ungrim97@gmail.comE<gt>

=cut

