<div id="account_details" class="fieldedEntry">

<& /comps/account/account_update_text.frag &>
    <&| /comps/label.frag, for => 'account_name'&><% $labels->{account}{name} %></&>
    <span class="inputContainer" name='account_name'><% $account->account_name %></span>

    <&| /comps/label.frag, for => 'account_type'&><% $labels->{account}{account_type} %></&>
    <span class="inputContainer" name='account_type'><% $account->account_type->description %></span>

    <&| /comps/label.frag, for => "account_id"&><% $labels->{account}{account_id} %></&>
    <span class="inputContainer" name='account_id'><% $account->account_id %></span>
</div>

<%args>
    $account => undef
    $labels  => {}
</%args>
<%init>
    return unless $account;
</%init>
%# vim: set ai et sw=4 syntax=mason :
