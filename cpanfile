requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Runtime', '5.90053';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::Mason';
requires 'JSON';
requires 'Catalyst::View::JSON';
requires 'Config::General';
requires 'Data::Dumper';
requires 'Moose';
requires 'MooseX::MarkAsMethods';
requires 'MooseX::NonMoose';
requires 'namespace::autoclean';
requires 'DBD::Pg';
requires 'DBIx::Class';
requires 'DBIx::Class::Migration';
requires 'Locale::Object::Language';
requires 'HTML::Mason';

on build => sub {
    requires 'Data::Random';
    requires 'ExtUtils::MakeMaker', '6.36';
    requires 'Test::Class::Moose';
    requires 'Test::More', '0.88';
    requires 'Test::WWW::Selenium::Catalyst';
};

on dev => sub {
    requires 'Catalyst::Restarter';
};
