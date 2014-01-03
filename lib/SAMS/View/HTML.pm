package SAMS::View::HTML;

use strict;
use warnings;

use parent 'Catalyst::View::Mason';
use SAMS::Problems;
use Data::Dumper;

__PACKAGE__->config(use_match => 0);

=head1 NAME

SAMS::View::HTML - Mason View Component for SAMS

=head1 DESCRIPTION

Mason View Component for SAMS

=head1 SEE ALSO

L<SAMS>, L<HTML::Mason>

=head1 AUTHOR

Michael Francis,,,

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
