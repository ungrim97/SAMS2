requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Runtime', '5.90053';
requires 'Config::General';
requires 'Data::Dumper';
requires 'Moose';
requires 'namespace::autoclean';

on build => sub {
    requires 'Data::Random';
    requires 'ExtUtils::MakeMaker', '6.36';
    requires 'Test::Class::Moose';
    requires 'Test::More', '0.88';
    requires 'Test::WWW::Selenium::Catalyst';
};
