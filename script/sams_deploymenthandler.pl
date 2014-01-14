#!/usr/bin/env perl
use strict;
use warnings;

use 5.18.1;

use aliased 'DBIx::Class::DeploymentHandler' => 'DH';

use Config::JFDI;
use Data::Dumper;
use FindBin;
use Getopt::Long;
use lib "$FindBin::Bin/../lib";

use SAMS::Schema;

my $config = Config::JFDI->new( name => 'sams' );
my $config_hash  = $config->get;
my $connect_info = $config_hash->{"Model::DB"}{"connect_info"};
my $schema = SAMS::Schema->connect($connect_info);

my ($action, $version);
my $force_overwrite = 0;

GetOptions(
    'action|a=s' => \$action,
    'version|v=i' => \$version,
    'force_overwrite|f' => \$force_overwrite,
) || die help();

my $dh = DH->new({
  schema           => $schema,
  databases        => 'PostgreSQL',
  force_overwrite  => $force_overwrite,
});

$version //= $dh->schema_version;

given ( $action ) {
    when ('install')            { install()             }
    when ('upgrade')            { upgrade()             }
    when ('downgrade')          { downgrade()           }
    when ('prepare_install')    { prepare_install()     }
    when ('prepare_upgrade')    { prepare_upgrade()     }
    when ('prepare_downgrade')  { prepared_downgrade()  }
    when ('current-version')    { current_version()     }
    default                     { die help() }
};

sub install {
  $dh->deploy({version => $version});
}

sub upgrade {
    $dh->upgrade();
}

sub downgrade {
    $dh->downgrade()
}

sub prepare_install {
    $dh->prepare_deploy;
}

sub prepare_upgrade {
    die "Please update the version in Schema.pm"
        if ( $dh->version_storage->version_rs->search({version => $dh->schema_version})->count );

    die "We only support positive integers for versions around these parts."
        unless $dh->schema_version =~ /^\d+$/;
    my $from_version = $dh->version_storage->database_version;

    $dh->prepare_deploy;
    $dh->prepare_upgrade({
        from_version => $from_version,
        to_version   => $version,
        version_set  => [$from_version, $version],
    });
}

sub prepare_downgrade {
    die "Please update the version in Schema.pm"
      if ( $dh->version_storage->version_rs->search({version => $dh->schema_version})->count );

    die "We only support positive integers for versions around these parts."
      unless $dh->schema_version =~ /^\d+$/;

    my $from_version = $dh->version_storage->database_version;
    $dh->prepare_downgrade({
        from_version => $from_version,
        to_version   => $version,
        version_set  => [$from_version, $version]
    });
}

sub current_version {
  say $dh->database_version;
}

sub help {
my $usage = '
usage:
    script/sams_deploymenthandler.pl --action|-a action [--version|-v]

    --action    -a  List the action desired to run on the DB defined in sams.conf/sams_local.conf
                        install             Deploy $version to the DB
                        upgrade             Upgrade to $version from current version
                        downgrade           Downgrade to $version from current version
                        prepare_upgrade     Write sql required to upgrade from current DB version to new schema version
                        prepare_install     Write sql needed to deploy a new schema version
                        prepare_downgrade   Write sql needed to downgrade from new schema to current DB

    --version   -v  The version to reach
';
say $usage;
}


