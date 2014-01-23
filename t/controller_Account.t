use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SAMS';
use SAMS::Controller::Account;

ok( request('/account')->is_success, 'Request should succeed' );
done_testing();
