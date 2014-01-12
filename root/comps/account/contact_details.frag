<div id="contact_details" class="fieldedEntry">
    <h4>Account contact details</h4>

    <p>Fields marked <span class="required_mark">*</span> are required.</p>

    <&| /comps/label.frag, for => "contact_title_id" &><% $labels->{contact}{title} %></&>
    <& /comps/select.frag,
        problems        => $problems,
        class           => "drop",
        name            => 'contact_title_id',
        options         => $contact_titles,
        selectedlabel   => $account->contact_title->title_id,
        readonly        => $is_readonly,
        disabled        => $is_readonly,
    &>

    <&| /comps/label.frag, for => "contact_name" &><% $labels->{contact}{name} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_name',
        value       => $account->contact_name,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_job_title" &><% $labels->{contact}{job_title} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_job_title',
        value       => $account->contact_job_title,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "street_1" &><% $labels->{contact}{street_1} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'street_1',
        value       => $account->street_1,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "street_2" &><% $labels->{contact}{street_2} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'street_2',
        value       => $account->street_2,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "city" &><% $labels->{contact}{city} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'city',
        value       => $account->city,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "county" &><% $labels->{contact}{county} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'county',
        value       => $account->county,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "postcode" &><% $labels->{contact}{postcode} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'postcode',
        value       => $account->postcode,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "country_id", required => 1 &><% $labels->{contact}{country} %></&>
    <& /comps/select.frag ,
        title           => 'Country',
        name            => 'country_id',
        class           => 'drop',
        options         => $countries,
        selectedlabel   => $account->country->country_id,
        problems        => $problems,
        readonly        => $is_readonly,
        disabled        => $is_readonly,
        required        => 1
    &>

    <&| /comps/label.frag, for => "contact_number" &><% $labels->{contact}{phone_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_number',
        value       => $account->contact_number,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "mobile number" &><% $labels->{contact}{mobile_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'mobile_number',
        value       => $account->mobile_number,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "fax_number" &><% $labels->{contact}{fax_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'fax_number',
        value       => $account->fax_number,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "email_address", required => 1 &><% $labels->{contact}{email_address} || 'foo' %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'email_address',
        type        => 'email',
        value       => $account->email_address,
        readonly    => $is_readonly,
        disabled    => $is_readonly,
        required    => 1,
    &>
</div>

<%args>
    $problems       => SAMS::Problems->new()
    $account        => undef
    $countries      => []
    $contact_titles => []
    $is_readonly    => 1
    $labels         => {}
</%args>
<%init>
    return unless $account;
</%init>

%# vim: set ai et sw=4 syntax=mason :
