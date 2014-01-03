use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SAMS';
use SAMS::Controller::SAMS::Login;

ok( request('/sams/login')->is_success, 'Request should succeed' );
done_testing();
