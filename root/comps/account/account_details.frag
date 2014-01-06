<div id="account_details" class="fieldedEntry">

<& /comps/account/account_update_text.frag &>
    <&| /comps/label.frag, for => "organisation"&>Organisation</&>
    <span class="inputContainer"><% $account->account_name %></span>
:
    <&| /comps/label.frag, for => "account_type"&>Account Type</&>
    <span class="inputContainer"><% $account->account_type->description %></span>

    <&| /comps/label.frag, for => "acc_id"&>Account ID</&>
    <span class="inputContainer"><% $account->account_id %></span>
</div>

<%args>
    $account => undef
</%args>
<%init>
    return unless $account;
</%init>
%# vim: set ai et sw=4 syntax=mason :
