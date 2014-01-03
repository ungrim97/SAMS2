<%args>
    $problems
    $account_search_fields  => {}
    $account_types  => {}
    $subscription_types => {}
    $subscription_status => {}
</%args>
<%init>

</%init>
<h4>Type in your query below:</h4>
<form class="fieldedEntry" name="main" id="searchForm" method="get">
    <& "/comps/account_search/field_choose.frag", problems => $problems, query => '', field => '', account_search_fields => $account_search_fields &>
    <& "/comps/account_search/field_subscription_type.frag", problems => $problems, subscription_types => $subscription_types &>
    <& "/comps/account_search/field_status.frag", problems => $problems, subscription_status => $subscription_status &>
    <& "/comps/account_search/field_account_type.frag", problems => $problems, account_types => $account_types &>
    <div class="label">
        <& /comps/submit.frag,
            problems => $problems,
            name => "searchButton",
            id => 'searchButton',
            class => "button",
            title => "Search",
            value => "Search",
        &>
    </div>
</form>
<script>

/**
 * Reads params set in input fields on search form. This is called
 * by addSearchParams() in /comps/account_listing.frag.
 */
var getSearchFormParams = function () {
    var searchParams = [];

    // main search field
    var searchQuery = $('form#searchForm input#query').val();
    var searchField = $('form#searchForm select#field').val();
    if (searchQuery != "" && searchField != "") {
        searchParams[searchField] = searchQuery;
    }

    // any other input or select fields in form - this may result in irrelevent data being 
    // submitted, but makes it easier to deal with additional form fields added by overrides.
    var inputFields = $('form#searchForm :input')
        .not('input#query, select#field, input#search, input#product_selector_category, input#product_selector_value, input#product_selector, '
             + 'input#group_subs_id');
    inputFields.each( function (index) {
        if ($(this).val() != "") {
            // autocompleteAJAX places the value in xxx_value (where xxx is the name of the control), so if group_subs_id_value 
            // is set then send to server as group_subs_id.
            if ($(this).attr('name') == 'group_subs_id_value') {
                searchParams['group_subs_id'] = $(this).val();
            }
            else {
                searchParams[$(this).attr('name')] = $(this).val();
            }
        }
    } );

    return searchParams;
}

/**
 * Checks the query term is valid for the selected query field. Fields that are integers
 * or IP addresses in the database are checked before submission.
 */
var validateForm = function () {
    var isValid = true;
    var searchQuery = $('form#searchForm input#query').val();
    var searchField = $('form#searchForm select#field').val();

    // Integer
    if (searchField == 'acc_id' || searchField == 'subs_id' || searchField == 'msd_order_id') {
        isValid = searchQuery.search(/^\d*$/) >= 0;
        if (! isValid) {
            searchFormShowProblems("The search field should contain an integer");
        }
    }

    // IP address
    if (searchField == 'ip_address') {
        isValid = searchQuery.search(/^\d+\.\d+\.\d+\.\d+$/) >= 0;
        if (! isValid) {
            searchFormShowProblems("The search field should contain an IP address");
        }
    }

    return isValid;
}

var searchFormShowProblems = function (message) {
    $('div#problems span.message').text(message);
    $('div#problems').css("display", "block");
}

var searchFormHideProblems = function () {
    $('div#problems').css("display", "none");
}

var searchAccounts = function () {
    if (validateForm()) {
        searchFormHideProblems();
        // Redraw the table - this will fetch data from the server using the form params.
        $('table#account_listing').dataTable().fnDraw();
        // Switch to the results tab.
        $('.tab_wrapper').tabs( "option", "selected", 1);
    }
}

$(document).ready(function () {
    // Set up submit handler for search button which causes the table to be redrawn - which in
    // turn calls find_account.json on the server.
    $('form#searchForm').submit( function (event) {
        searchAccounts();
        event.preventDefault();
    } );
    // Also set up a keypress handler on select fields so that hitting enter causes the table
    // to be redrawn as above.
    // This replaces the submitonenter functionality which appears to submit the form in a way
    // that can't be trapped by the above submit event binding.
    $('form#searchForm select').keypress( function (event) {
        if (event.which == 13 || event.which == 3) {
            searchAccounts();
            event.preventDefault();
        }
    } );
} );

</script>
%# $Id$
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason:
