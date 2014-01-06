use strict;
use warnings;
use Test::More;


use Catalyst::Test 'SAMS';
use SAMS::Controller::Admin::AJAX;

ok( request('/admin/ajax')->is_success, 'Request should succeed' );
done_testing();
