<div id="contact_details" class="fieldedEntry">
    <h4>Account contact details</h4>

    <p>Fields marked <span class="required_mark">*</span> are required.</p>

    <&| /comps/label.frag, for => "contact_title_id" &><% $labels->{contact}{title} %></&>
    <& /comps/textbox.frag,
        problems        => $problems,
        class           => "searchme",
        name            => 'contact_title',
        value           => $account->contact_title,
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

    <&| /comps/label.frag, for => "contact_address_2" &><% $labels->{contact}{street_1} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_address1',
        value       => $account->contact_address_1,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_address_2" &><% $labels->{contact}{street_2} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_address_2',
        value       => $account->contact_address_2,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_city" &><% $labels->{contact}{city} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_city',
        value       => $account->contact_city,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_county" &><% $labels->{contact}{county} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_county',
        value       => $account->contact_county,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_postcode" &><% $labels->{contact}{postcode} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_postcode',
        value       => $account->contact_postcode,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_country_id", required => 1 &><% $labels->{contact}{country} %></&>
    <& /comps/select.frag ,
        title           => 'Country',
        name            => 'contact_country_id',
        class           => 'drop',
        options         => $countries,
        selected_label   => $account->contact_country_id,
        problems        => $problems,
        readonly        => $is_readonly,
        disabled        => $is_readonly,
        required        => 1
    &>

    <&| /comps/label.frag, for => "contact_telephone" &><% $labels->{contact}{phone_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_telephone',
        value       => $account->contact_telephone,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_mobile_telephone" &><% $labels->{contact}{mobile_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_mobile_telephone',
        value       => $account->contact_mobile_telephone,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_fax" &><% $labels->{contact}{fax_number} %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_fax',
        value       => $account->contact_fax,
        readonly    => $is_readonly,
        disabled    => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_email", required => 1 &><% $labels->{contact}{email_address} || 'foo' %></&>
    <& /comps/textbox.frag,
        problems    => $problems,
        class       => "searchme",
        name        => 'contact_email',
        type        => 'email',
        value       => $account->contact_email,
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
