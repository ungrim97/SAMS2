use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SAMS';
use SAMS::Controller::Admin;

ok( request('/admin')->is_success, 'Request should succeed' );
done_testing();
