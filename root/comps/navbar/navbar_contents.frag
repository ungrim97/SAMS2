<%args>
    $user => undef
    $labels => {}
</%args>
<%init>
my $counter_options = [
                        [$labels->{navbar}{report_counter_3} => "/report/counter.html" ],
                        [$labels->{navbar}{report_counter_4} => "/report/counter_star.html" ],
                       ];


my @items = (
                [ $labels->{navbar}{reports} => [ 
                                [ $labels->{navbar}{report_icolc}, "/report/icolc.html" ],
                                [ $labels->{navbar}{report_counter}, $counter_options ]
                               ]
                ],
                [ $labels->{navbar}{access_tokens} => [
                                        [ $labels->{navbar}{access_token_activate}, "/access_token_1.html" ]
                                     ]
                ],
                [ $labels->{navbar}{info} => [
                                    [ $labels->{navbar}{info_contact}, "/contact.html" ],
                                    [ $labels->{navbar}{info_help}, "/help.html" ],
                                  ]
                ],
);

# Account navbar should always link to logged in $user
if ($user){
    unshift @items, [
        $labels->{navbar}{accounts} => [
            [ $labels->{navbar}{account_details}, '/account/'.$user->account_id.'/account_details' ],
            [ $labels->{navbar}{account_subscriptions}, "/subscriptions.html" ],
            [ $labels->{navbar}{account_credentials}, "/credentials.html" ],
            [ $labels->{navbar}{account_preferences}, "/account_preferences.html" ],
        ]
    ];
}

return @items;

</%init>
%# vim: set ai et sw=4 syntax=mason :
