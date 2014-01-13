<%init>
my $counter_options = [
                        ['COUNTER 3'        => "/report/counter.html" ],
                        ['COUNTER 4'        => "/report/counter_star.html" ],
                       ];


my @items = (
                [ "Reports" => [ 
                                [ "ICOLC", "/report/icolc.html" ],
                                [ "COUNTER", $counter_options ]
                               ]
                ],
                [ 'Access Tokens' => [
                                        [ "Access Token Activation", "/access_token_1.html" ]
                                     ]
                ],
                ['Information' => [
                                    [ "Contact Us", "/contact.html" ],
                                    [ "Help", "/help.html" ],
                                  ]
                ],
);

# Account navbar should always link to logged in $user
if ($user){
    unshift @items, [
        'Account' => [
            [ "Account Details", '/account/'.$user->account_id.'/account_details' ],
            [ "Subscriptions", "/subscriptions.html" ],
            [ "Credentials", "/credentials.html" ],
            [ "Account Preferences", "/account_preferences.html" ],
        ]
    ];
}

return @items;

</%init>
<%args>
    $user => undef
</%args>
%# vim: set ai et sw=4 syntax=mason :
