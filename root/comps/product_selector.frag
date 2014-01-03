<input id="product_selector" 
       name="pe_selector" 
       placeholder="<% $placeholder %>"
       class="searchme <% $ajax_or_regex %>" type="text"
       data-enable-sites="<% $enable_sites %>"
       data-enable-products="<% $enable_products %>"
       data-result-limit="<% $result_limit %>"
       data-url="/ajax_widgets/product_site_selector_search.json"/>
<input id="product_selector_pe_id" name="pe_id" type="hidden" value="<% $pe_id %>" />
<input id="product_selector_site_id" name="site_id" type="hidden" value="<% $site_id %>" />

<script>
    $("#product_selector").data('source', <% $json |n %> );
    $("#product_selector").data('value', "<% $pe_selector_value %>" );
    $("#product_selector").data('category', "<% $pe_selector_category %>" );
</script>

<%args>
    $enable_sites       => 0
    $enable_products    => 0
    $result_limit       => 50
    $pe_id              => ''
    $site_id            => ''
    $problems           => SAMS::Problems->new()
</%args>
<%init>

    my @sites_and_products;
    push @sites_and_products, 'site' if $enable_sites;
    push @sites_and_products, 'product' if $enable_products;
    my $placeholder = "start typing a " . join('/',@sites_and_products) . " name or id..." ;

    my $pe_selector_value = '';
    my $pe_selector_category = '';
    my $json = {};
    my $ajax_or_regex = 'regex';
    # TODO - handle initial values for pe_id and site_id.
</%init>
%# vim: set ai et sw=4 syntax=mason:
