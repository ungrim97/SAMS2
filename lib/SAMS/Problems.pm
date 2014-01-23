=head1 NAME

SAMS::Problems - problem reporting API

=head1 SYNOPSIS

  my $p = SAMS::Problems->new;
  $p->add( acc_id => 'no acc_id' );
  $p->add( allowed_ips =>
      'Duplicate IP Address [_1]', '212.74.15.64/26' );
  $p->add( allowed_ips =>
      'Disallowed network [_1]', '192.168.1.0/24' );

  my @items = $p->get( 'allowed_ips' );
  my %hash_of_items = $p->get_all;

  unless ($p->ok) {
      print "oops!\n";
      print $p->all_as_string, "\n";
  }

=head1 DESCRIPTION

This class is used as an error reporting mechanism.  It allows problems
to be associated with a field name, as well as multiple problems per
fields.  It is intended that each problem may need to be translated, so
optional arguments are also maintained for each problem.

=head1 METHODS

=over 4

=cut

package SAMS::Problems;

use strict;
use warnings;

use Carp qw( croak );
use SAMS::Problems::Item;

our $VERSION = (qw( $Revision$ ))[1];

=item new ( )

I<Class Method>.  Constructor.

=cut

sub new {
    my $class = shift;
    warn 'SAMS::Problems is DEPRICATED. See SAMS::Error';
    return bless { }, $class;
}

=item new_with_item ( ITEM )

=item new_with_item ( FIELD, PROBLEM, [ ARGS ] )

Creates a new problems object and populates it with either the ITEM
object, or it creates a new item object from ID, FIELD, PROBLEM and ARGS
and uses that instead.

=cut

sub new_with_item {
    my $class  = shift;
    my $thingy = shift;         # multiplexed argument...
    my $p      = $class->new;

    my $item;
    if ( $thingy && ref $thingy ) {
        $item = $thingy;
    } else {
        $item = SAMS::Problems::Item->new( $thingy => @_ );
    }
    $p->add_item( $item );
    return $p;
}

=item add ( FIELD, PROBLEM, [ ARGS ] )

Add a new description, PROBLEM to FIELD.  Optionally associate ARGS with
PROBLEM, if there are arguments present in PROBLEM.  Arguments are
intended to be used by translation software later on.  For example,
PROBLEM might be:

  Duplicate IP Address [_1]

And ARGS would be an IP address.  The idea is taken from
L<Locale::MakeText>.

Alternatively, a L<SAMS::Problems::Item> object may be passed in
directly.

Returns $self.

=cut

sub add {
    my $self = shift;
    my ( $key, $val, @args ) = @_;
    croak "usage: add(key,val,[args])"
      unless $key && $val;
    my $item = SAMS::Problems::Item->new( $key, $val, @args );

    return $self->add_item( $item );
}

=item add_item ( ITEM )

Add a I<SAMS::Problems::Item> object.

=cut

sub add_item {
    my $self = shift;
    my ($item) = @_;
    croak "usage: add_item(item)"
        unless $item && ref($item) && $item->isa( 'SAMS::Problems::Item');

    my $problem_list = $self->{ $item->field } || [];
    push @$problem_list, $item;
    $self->{ $item->field } = $problem_list;
    return $self;
}

=item get ( FIELD )

Return a list of problems for FIELD.  Each problem will be a
L<SAMS::Problems::Item>.

Returns an empty list if FIELD has no problems.

=cut

sub get {
    my $self = shift;
    my ( $key ) = @_;
    croak "usage: get(key)"
        unless $key;

    return @{ $self->{ $key } || [] };
}

=item get_all ( )

Return a hash of all problems.  The key in each hash will be the field
name and the value will be a list (as returned by get()).

=cut

sub get_all {
    my $self = shift;
    return map { $self->get($_) } $self->list_all;
}

=item list_all ( )

Return a sorted list of problems inside this object.  Each entry in the
list can then be passed in to get().

=cut

sub list_all {
    my $self = shift;
    return sort keys %$self;
}

=item remove ( FIELD )

Remove FIELD from the problems object.  This will remove all problems
associated with FIELD, even if there are multiple problems.  It returns
a list reference containing the removed items.

This should probably not be used lightly.

=cut

sub remove {
    my $self = shift;
    my ($field) = @_;
    delete $self->{ $field };
}

=item ok ( )

Returns true if there are no problems contained in this object.

=cut

sub ok {
    my $self = shift;
    return scalar( keys %$self ) == 0;
}

=item num ( )

Returns the number of problems currently held by this object.

=cut

sub num {
    my $self = shift;
    my $num = 0;
    $num += scalar @$_ foreach values %$self;
    return $num;
}

=item as_string ( FIELD )

Returns a string version of all the problems for FIELD.  This is used in
lieu of a proper translation service.  Each problem will have its
arguments interpolated, and all problems will be on a seperate line of
the string.

Returns an empty string for a field which has no problems.

=cut

sub as_string {
    my $self = shift;
    my ( $key ) = @_;
    croak "usage: as_string(key)" unless $key;
    return join "\n", map { $_->as_string } $self->get( $key );
}

=item all_as_strings ( )

Returns each problem in the object as an individual string.

=cut

sub all_as_strings {
    my $self = shift;
    croak "usage: all_as_string()" unless @_ == 0;
    my @str;
    foreach my $field ( $self->list_all ) {
        foreach my $item ( $self->get( $field ) ) {
            push @str, $item->as_string_with_field;
        }
    }
    return @str;
}

=item all_as_string ( )

Returns a string version of all the problems.  Each problem will be on a
separate line and prefixed by its field name.

=cut

sub all_as_string {
    my $self = shift;
    return join "\n", $self->all_as_strings;
}

=item merge ( PROBLEM, [ prefix ] )

Takes a PROBLEM object and merges it's items onto this.
Also takes optional prefix to prepend to the merged problem items.

=cut

sub merge{
    my $self = shift;
    my ( $problems, $prefix ) = @_;

    foreach my $problem ( $problems->list_all ) {
        if ( defined $prefix ) {
            my ( $item ) = $problems->get( $problem );
            $self->add( $prefix.' '.$item->{ field } => $item->as_string  );
        }else{
            $self->add_item( $problems->get( $problem ) );
        }
    }
}


1;
__END__


=back

=head1 AUTHOR

Dominic Mitchell E<lt>dom@semantico.comE<gt>

=head1 VERSION

@(#) $Id$

=cut

# Local Variables:
# mode: cperl
# cperl-indent-level: 4
# indent-tabs-mode: nil
# End:
# vim: set ai et sw=4 :
