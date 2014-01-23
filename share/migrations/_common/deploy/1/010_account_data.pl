use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $schema = shift->schema;
    my $account_rs = $schema->resultset('Account');

    $account_rs->create({
        organisation => 'Semantico Admin',
        account_type_id => 1,
        credential_userpasses => [{
            password        => 'kkjahdj',
            username        => 'semantico-admin',
            last_update_id  => 'dbseed',
            group_members   => [{
                group_name_id   => 'administrator',
                last_update_id  => 'dbseed',
            }],
        }],
        subscription_accs => [{
            address1                    => 'Semantico',
            administered_by             => 'ROW',
            allow_marketing_email       => 0,
            allow_notification_email    => 0,
            city                        => 'Brighton',
            concurrency                 => '-1',
            contact_name                => 'Semantico Support',
            email                       => 'supportteam@semantico.com',
            grace_period                => '7 days',
            ignore_end                  => 1,
            ignore_start                => 1,
            last_update_id              => 'dbseed',
            prepayment_required         => 0,
            status                      => 'OK',
            telephone                   => '01273 358 200',
            country_id                  => $schema->resultset('Country')->find({name => 'United Kingdom'})->country_id,
            pe_id                       => 'ADMIN',
            subscription_type_id        => 1,
            allow_ip                    => 0,
            allow_userpass              => 1,
            allow_referrer              => 0,
            allow_libcard               => 0,
            require_libcode             => 1,
            publication_medium_id       => 'UNK',
        }],
    });

    $account_rs->create({
        organisation => 'Semantico Support',
        account_type_id => 1,
        credential_userpasses => [{
            password        => 'kkjahdj',
            username        => 'semanticosupport',
            last_update_id  => 'dbseed',
            group_members   => [{
                group_name_id   => 'administrator',
                last_update_id  => 'dbseed',
            }],
        }],
    });

    $account_rs->create({
        organisation => 'Semantico Search Monitor',
        account_type_id => 1,
        credential_ips => [
            {ip_address => '10.1.0.140',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.1.0.141',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.1.0.142',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.1.16.175',       allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.1.16.176',       allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.3.0.140',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.3.0.141',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '10.3.0.142',        allow => 1, last_update_id => 'dbseed'},
            {ip_address => '91.208.163.206',    allow => 1, last_update_id => 'dbseed'},
            {ip_address => '93.91.19.140',      allow => 1, last_update_id => 'dbseed'},
            {ip_address => '192.168.2.51',      allow => 1, last_update_id => 'dbseed'},
            {ip_address => '195.144.0.10',      allow => 1, last_update_id => 'dbseed'},
            {ip_address => '195.144.0.140',     allow => 1, last_update_id => 'dbseed'},
            {ip_address => '195.144.0.141',     allow => 1, last_update_id => 'dbseed'},
            {ip_address => '195.144.0.142',     allow => 1, last_update_id => 'dbseed'},
        ],
    });

    $account_rs->create({
        organisation => 'Admin Account',
        account_type_id => 1,
        credential_userpasses => [{
            password        => 'kkjahdj',
            username        => 'admin',
            last_update_id  => 'dbseed',
            group_members   => [{
                group_name_id   => 'administrator',
                last_update_id  => 'dbseed',
            }],
        }],
        subscription_accs => [{
            address1                    => 'Unkown',
            administered_by             => 'ROW',
            allow_marketing_email       => 0,
            allow_notification_email   => 0,
            city                        => 'Unkown',
            concurrency                 => '-1',
            contact_name                => 'Unkown',
            email                       => 'unkown@test.com',
            grace_period                => '7 days',
            ignore_end                  => 1,
            ignore_start                => 1,
            last_update_id              => 'dbseed',
            prepayment_required         => 0,
            status                      => 'OK',
            telephone                   => '01273 358 200',
            country_id                  => $schema->resultset('Country')->find({name => 'United Kingdom'})->country_id,
            pe_id                       => 'ADMIN',
            subscription_type_id        => 1,
            allow_ip                    => 0,
            allow_userpass              => 1,
            allow_referrer              => 0,
            allow_libcard               => 0,
            require_libcode             => 1,
            publication_medium_id       => 'UNK',
        }],

    });

    $account_rs->create({
        organisation => 'Site testing account',
        account_type_id => 1,
        credential_userpasses => [{
            password        => 'kkjahdj',
            username        => 'testing',
            last_update_id  => 'dbseed',
            group_members   => [{
                group_name_id   => 'administrator',
                last_update_id  => 'dbseed',
            }],
        }],
    });
};
