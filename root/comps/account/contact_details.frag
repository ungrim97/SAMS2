<div id="contact_details" class="fieldedEntry">
    <h4>Account contact details</h4>

    <p>Fields marked <span class="required_mark">*</span> are required.</p>

    <&| /comps/label.frag, for => "contact_name"&>Name</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_name',
        value => $account->account_name,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_title"&>Title</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_title',
        value => $account->contact_title->description,
        readonly => $is_readonly,
        disabled => $is_readonly,
    &>

    <&| /comps/label.frag, for => "contact_job_title"&>Job Title</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_job_title',
        value => $account->contact_job_title,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <label class="label" for="contact_address_1">Address line 1</label>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_address_1',
        value => $account->street_1,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <label class="label" for="contact_address_2">Address line 2</label>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_address_2',
        value => $account->street_2,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_city"&>City</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_city',
        value => $account->city,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_county"&>County</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_county',
        value => $account->county,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_postcode"&>Postcode</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_postcode',
        value => $account->postcode,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_country_id", required => 1 &>Country</&>
    <& /comps/select.frag ,
        title => 'Country',
        name => 'contact_country_id',
        class => 'drop',
        options => $countries,
        selectedlabel => $account->country->country_code,
        problems => $problems,
        readonly => $is_readonly,
        disabled => $is_readonly,
        required => 1
    &>

    <&| /comps/label.frag, for => "contact_telephone"&>Telephone</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_telephone',
        value => $account->contact_number,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_mobile_telephone"&>Mobile telephone</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_mobile_telephone',
        value => $account->mobile_number,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_fax"&>Fax</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_fax',
        value => $account->fax_number,
        readonly => $is_readonly,
        disabled => $is_readonly
    &>

    <&| /comps/label.frag, for => "contact_email", required => 1 &>Email</&>
    <& /comps/textbox.frag,
        problems => $problems,
        class => "searchme",
        name => 'contact_email',
        value => $account->email_address,
        readonly => $is_readonly,
        disabled => $is_readonly,
        required => 1
    &>
</div>
<%args>
    $problems   => SAMS::Problems->new()
    $account    => undef
    $countries  => []
    $is_readonly=> 1
</%args>
<%init>
    return unless $account;
</%init>

