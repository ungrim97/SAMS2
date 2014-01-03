use strict;
use warnings;

use SAMS;

my $app = SAMS->apply_default_middlewares(SAMS->psgi_app);
$app;

