package SAMS::Problems::Item;

use strict;
use warnings;

use Carp 'croak';

use base 'Class::Accessor';

__PACKAGE__->mk_accessors( qw( field text id ) );

sub new {
    my $class = shift;
    my ( $field, $text, @args ) = @_;
    croak "usage: new(field,text,[args])"
      unless $field && $text;
    my $self = bless {}, $class;
    $self->field( $field );
    $self->text( $text );
    $self->args( @args );
    return $self;
}

sub details {
    my ( $self, $text ) = @_;

    $self->{ details } = $text if $text;

    return $self->{ details } || '';
}

# Have to do this ourselves because Class::Accessor doesn't handle list
# items terribly well.
sub args {
    my $self = shift;
    $self->{ args } = [@_] if @_;
    return @{ $self->{ args } || [] };
}

# Simple access to the argument list.
sub arg {
    my $self = shift;
    my ( $n ) = @_;
    croak "usage: arg(n)" unless $n && $n =~ m/^\d+$/;
    my @args = $self->args;
    return defined( $args[ $n - 1 ] ) ? $args[ $n - 1 ] : '';
}

sub as_string {
    my $self = shift;
    my $msg  = $self->text;
    $msg =~ s/\[_(\d+)\]/ $self->arg( $1 ) /ge;
    return $msg;
}

sub as_string_with_field {
    my $self = shift;
    return $self->field . ': '. $self->as_string;
}

# Turn the text into components.  Many thanks to Richard Clamp for
# pointing out the obvious solution to me.
sub text_parts {
    my $self = shift;
    return split /(\[_\d+])/, $self->text;
}

1;
__END__

=head1 NAME

SAMS::Problems::Item - an individual problem item

=head1 SYNOPSIS

  my $item = SAMS::Problems::Item->new( field => 'wrong' );
  $problems->add( $item );

=head1 DESCRIPTION

This class is used by L<SAMS::Problems>.  It stores all details related
to an individual problem report.

=head1 METHODS

=over 4

=item new ( FIELD, TEXT [, ARGS ] )

Create a new problem item and return it.

=item field ( [ TEXT ] )

Accessor.  The field to which this problem relates.

=item details( [ TEXT ] )

Accessor / Setter. More detailed information about the specific error

=item id ( [ TEXT ] )

Accessor.  A I<canonical> form of the text.

=item text ( [ TEXT ] )

Accessor.  The text of the problem.

=item text_parts ( )

Returns the text, but split into components with the arguments separated
out for easy processing.

=item args ( [ ARGS ] )

Accessor.  Any arguments needed by the text.

=item arg ( NUMBER )

Returns argument NUMBER from the list, or an empty string if it's not
defined.  NUMBER starts at 1.

=item as_string ( )

Returns a rendered, textual form of the problem.

=item as_string_with_field ( )

Like as_string(), but the text is preceded by the field name and a
colon.

=head1 AUTHOR

Dominic Mitchell E<lt>dom@semantico.comE<gt>

=head1 VERSION

@(#) $Id$

=cut

# vim: set ai et sw=4 :
