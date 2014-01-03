<!-- $Id$ -->
<%init>

my $display = 0;
##
# Determine navigation bar restrictions
# curently only READONLY mode
my $counter_options = [
                        ['COUNTER 3'        => "/report/counter.html" ],
                        ['COUNTER 4'        => "/report/counter_star.html" ],
                       ];

my @items = (
    # Name, URL.
    ['Accounts and Subscriptions' => [
                                        ['Account Search' => '/' ],
                                        ( $display ) ? ['Create Account' => '/create_newaccount.html'] : undef,
                                        ( $display ) ? ['Bulk Subscription Import' => '/bulk_import_subscription.html'] : undef,
                                     ]
    ],

    ['Product Management' => [
                                [ 'Platform' => '/platform.html' ],
                                [ 'Site' => '/site_details.html' ],
                                [ 'Product' => '/product.html' ],
                                ( $display ) ? [ 'Bulk Product Import' => '/bulk_import_product.html'] : undef,
                             ] 
    ],

    ['Access Tokens' => [
                            ['Search Tokens' => '/access_tokens_search.html'], 
                            ( $display ) ? ['Create Tokens' => '/access_tokens_create.html' ] : undef,
                            ['Batches' => '/access_tokens_batches.html']
                        ] 
    ],

    ['Reports' => [
                   ['ICOLC' => "/report/icolc.html" ],
                   ['COUNTER' => $counter_options ],
                   ['eCommerce Transactions' => '/report/ecommerce.html' ],
                   ['Management Reports' => [
                                             [ 'Headline Overview' =>'/report/headline_overview.html' ],
                                             [ 'Expiring and Unrenewed Subscriptions' =>'/report/exsubs.html' ],
                                             [ 'Trial Conversions' =>'/report/trial_conversions.html' ],
                                             [ 'Ad Hoc' =>'/report/adhoc.html' ],
                                             [ 'Duplicate IP Addresses' =>'/report/duplicate_ips.html' ],
                                             [ 'Data Changes' =>'/report/data_changes.html' ],
                                             [ 'Titles' =>'/report/content_units.html' ],
                                            ]
                       ],
                   ['General usage reports' => [
                                                [ 'Headline usage statistics' => '/report/summarised_hstats.html' ],
                                                [ 'Headline usage statistics archive' => '/report/summarised_hstats_historical.html' ],
                                                [ 'Inactive subscriptions' => '/report/inactive_subs.html' ],
                                                [ 'Inactive subscriptions archive' => '/report/inactive_subs_historical.html' ],
                                                [ 'Turnaways' => '/report/summarised_turnaways.html' ],
                                                [ 'Turnaways archive' => '/report/summarised_turnaways_historical.html' ],
                                               ]
                   ],
                   ($m->comp_exists( "/comps/report/custom_list.frag" ) ?
                    $m->comp( "/comps/report/custom_list.frag" ) : undef),
                   ['Saved Reports' => '/report/saved.html' ]
                  ]
    ],
             
    ['Email' => [
                    [ 'Bulk Email' => '/bulk_email.html' ],
                    [ 'Email Lists' => '/email_admin.html' ],
                    [ 'Test Email Templates'=> '/email_test.html' ]
                ]
    ],
    ['Invoicing' => [
                        ['Subscription Invoice Account Search' => '/subscription_invoice_account_search.html'],
                        ['Payment History' => '/invoice_payment_history.html'],
                    ]
    ],
    ['Support Tools' => [
                            ['Live Sessions' => '/server_status.html' ],
                            ['Access Test Tool' => '/access_testtool.html' ],
                            ['Whois' => '/whois.html' ],
                            ['API Explorer' => '/api_explorer.html' ],
                        ] 
    ]
);

return @items;

</%init>
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
