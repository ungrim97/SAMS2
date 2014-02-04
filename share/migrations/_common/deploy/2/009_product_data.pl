use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $platform_rs = shift->schema->resultset('Platform');

    $platform_rs->create({
        platform_id     => 'ADMIN',
        platform_name   => 'SAMS Admin Interface',
        sites => [{
            site_id         => 'ADMIN-IF',
            site_name       => 'SAMS Admin Interface',
            last_update_id  => 'dbseed',
            product_editions => [{
                pe_id                   => 'ADMIN',
                immediate_access        => 1,
                last_update_id          => 'dbseed',
                pe_name                 => 'SAMS Admin Interface',
                product_url             => 'http://example.com',
                site_id                 => 'ADMIN-IF',
                product_type_id         => 'single',
                allow_ip_default        => 1,
                allow_userpass_default  => 1,
                deny_groups_default     => 1,
                allow_referrer_default  => 1,
                allow_libcard_default   => 1,
                require_libcode_default => 1,
                product_contents => [{
                    last_update_id  => 'dbseed',
                    content_unit    => {
                        content_unit_id => 'ADMIN',
                        name            => 'SAMS Admin Interface',
                        last_update_id  => 'dbseed',
                        content_unit_type => {
                            content_unit_type_id => 'COLL_NAME',
                            description => 'Collection Code',
                        },
                        platform_contents => [{
                            platform_id     => 'ADMIN',
                            last_update_id  => 'dbseed',
                        }],
                    },
                }],
            },
            {
                immediate_access        => 1,
                last_update_id          => 'dbseed',
                pe_id                   => 'ADMIN-CUSTOMERSERVICE',
                pe_name                 => 'SAMS Admin Interface Customer Service',
                product_url             => 'http://example.com',
                product_type_id         => 'single',
                allow_ip_default        => 1,
                allow_userpass_default  => 1,
                deny_groups_default     => 1,
                allow_referrer_default  => 1,
                allow_libcard_default   => 1,
                require_libcode_default => 1,
            },
            {
                immediate_access        => 1,
                last_update_id          => 'dbseed',
                pe_id                   => 'ADMIN-RO',
                pe_name                 => 'SAMS Admin Interface Readonly',
                product_url             => 'http://example.com',
                product_type_id         => 'single',
                allow_ip_default        => 1,
                allow_userpass_default  => 1,
                deny_groups_default     => 1,
                allow_referrer_default  => 1,
                allow_libcard_default   => 1,
                require_libcode_default => 1,
            }],
        }],
    });
};
