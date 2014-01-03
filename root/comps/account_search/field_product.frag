<&| /comps/label.frag, for => "site_id", problems => $problems &>Site/Product:<% ($required) ? '<span class="message">*</span>' : '' |n %></&>
<& "/comps/product_selector.frag",
    enable_sites    => 1,
    enable_products => 1, 
    problems        => $problems,
    pe_id           => $pe_id,
    site_id         => $site_id,
    enable_deselect => !$required
&>
<span title="Choose a site or product to find accounts with a subscription to that product (or any product in the site). Start typing to get some suggested completions." class="help inline_icon ui-icon ui-icon-help"></span>
<%args>
    $problems   => SAMS::Problems->new()
    $pe_id      => ''
    $site_id    => ''
    $required   => 0
</%args>


