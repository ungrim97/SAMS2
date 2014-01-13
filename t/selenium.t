use lib 't/lib/';
use Test::Class::Moose::Load qw#t/Tests/SAMS/Selenium#;
my $test_suite = Test::Class::Moose->new()->runtests;
