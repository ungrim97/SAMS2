var parent_accounts_data;
var child_accounts_data;
var results_per_page = 250;
var minimum_search_string = 4;


// Monitor parent account search value for ENTER key
jQuery.fn.keyPressParentAccountSearch = function () {
    return this.each(function() {
            $(this).keydown(function(event) {
                if (event.keyCode == '13') {
                event.preventDefault();
                jQuery.fn.parentAccountSearch( $(this).attr("value") );
                }
                });
            });
}

jQuery.fn.clickParentAccountSearch = function () {
    return this.each(function() {
            $(this).click(function () {
                jQuery.fn.parentAccountSearch( $("div#parent_account input#parent_account_search_value").attr("value") );
                });
            });

}

jQuery.fn.parentAccountSearch = function ( string ) {
    if ( string != undefined && string != ""){

        if (string.length < minimum_search_string){
            $("div#parent_account div#search_results_summary").html( "You must enter at least " + minimum_search_string + " characters" ) ;
        }else{

            $("div#parent_account div#search_results_summary").html( "searching for " + string ) ;

            $.getJSON(
                    "/ajax_widgets/parent_account_search.html?acc_id=" + $("form#acc input#acc_id").attr("value") + "&q=" + string,
                    function( data ){ jQuery.fn.handleParentAccounts( data );}
                    );
        }
    }
}

// Monitor child account search value for ENTER key
jQuery.fn.keyPresschildAccountSearch = function () {
    return this.each(function() {
            $(this).keydown(function(event) {
                if (event.keyCode == '13') {
                event.preventDefault();
                jQuery.fn.childAccountSearch( $(this).attr("value") );
                }
                });
            });
}

jQuery.fn.clickChildAccountSearch = function () {
    return this.each(function() {
            $(this).click(function () {
                jQuery.fn.childAccountSearch( $("div#child_accounts input#child_account_search_value").attr("value") );
                });
            });
}

jQuery.fn.childAccountSearch = function ( string ) {
    if ( string != undefined && string != ""){
        if (string.length < minimum_search_string){
            $("div#child_accounts div#search_results_summary").html( "You must enter at least " + minimum_search_string + " characters" ) ;
        }else{
            $("div#child_accounts div#search_results_summary").html( "searching for " + string ) ;
            $.getJSON(
                    "/ajax_widgets/child_account_search.html?acc_id=" + $("form#acc input#acc_id").attr("value") + "&q=" + string,
                    function( data ){ jQuery.fn.handleChildAccounts( data );}
                    );
        }
    }
}


jQuery.fn.handleChildAccounts = function ( data ) {
    if ( $(data).length ){
        child_accounts_data = data;
        jQuery.fn.viewChildResultPage( 1 );
    }
}


jQuery.fn.viewChildResultPage = function ( view_page ) {

    $("div#child_accounts select#child_account_search_results").empty();
    $("div#child_accounts div.search_results_pagination").empty();

    if ( child_accounts_data.accounts_found > 0 ){

        var number_of_pages = calc_pagination( child_accounts_data.accounts_found, "div#child_accounts div.search_results_pagination" );
        var page = 1;
        var acc_page_counter = 1;
        var acc_counter = 1;

        $("div#child_accounts div#search_results_summary").html( child_accounts_data.accounts_found + " " + (child_accounts_data.accounts_found == 1 ? "account" : "accounts") + " found");

        $.each(child_accounts_data.accounts, function(i,item){

                if ( page == view_page ){
                var newAccount = $("<option>" + acc_counter + " : " 
                    + $(item).attr("organisation") + " (" + $(item).attr("acc_id") + ")</option>");

                newAccount.attr( "acc_id", $(item).attr("acc_id") );
                newAccount.attr( "organisation", $(item).attr("organisation") );
                newAccount.attr( "is_ancestor", $(item).attr("is_ancestor") );
                newAccount.attr( "page", page );

                // set the relevant class
                var option_class = "search_result";

                if ( $(item).attr("is_ancestor") == 1 ){
                option_class += " is_ancestor";
                }
                if ( $(item).attr("parent_acc_id" ) ){
                option_class += " has_parent";
                }

                newAccount.attr( "class", option_class );

                if ( $(item).attr("is_ancestor") == 1){
                    newAccount.attr( "disabled", "disabled");
                }

                $("div#child_accounts select#child_account_search_results").append( newAccount );
                }

                // increment account counter
                acc_page_counter += 1;
                acc_counter += 1;

                // increment page counter and reset acc_page_counter if necessary
                if ( acc_page_counter > results_per_page ){
                    page += 1;
                    acc_page_counter = 1;
                }

        });

        // Re-register selectors to work with newly added elements.
        jQuery.fn.registerInheritanceSelectors();

        $("strong.search_results_page_link[page="+ view_page +"]").attr("style", "text-decoration:underline");
        $("strong.search_results_page_link[page!="+ view_page +"]").attr("style", "text-decoration:none");

        $("div#child_accounts select#child_account_search_results").focus();
    }else{
        $("div#child_accounts div#search_results_summary").html( "0 accounts found");
    }
}


jQuery.fn.clickViewChildResultPage = function () {
    return this.each(function() {
            $(this).click(function () {
                jQuery.fn.viewChildResultPage( $(this).attr("page") );
                });
            });
}



jQuery.fn.handleParentAccounts = function ( data ) {

    // empty the list if we've found results
    if ( $.length ){

        parent_accounts_data = data;

        $("div#parent_account ul#parent_account_search_results").empty();
        $("div#parent_account ul#parent_account_search_results").attr( "style");
        $("div#parent_account div.search_results_pagination").empty();

        if ( data.accounts_found > 0 ){

            var number_of_pages = calc_pagination( data.accounts_found, "div#parent_account div.search_results_pagination" );
            var page = 1;
            var acc_page_counter = 1;
            var acc_counter = 1;

            $.each(data.accounts, function(i,item){

                    var newAccount = $("<li>" + acc_counter + " : " 
                        + $(item).attr("organisation") + " (" + $(item).attr("acc_id") + ")</li>");

                    newAccount.attr( "acc_id", $(item).attr("acc_id") );
                    newAccount.attr( "organisation", $(item).attr("organisation") );
                    newAccount.attr( "parent_acc_id", $(item).attr("parent_acc_id") );
                    newAccount.attr( "is_ancestor", $(item).attr("is_ancestor") );
                    newAccount.attr( "page", page );

                    // set the relevant class
                    var li_class = "search_result";

                    if ( $(item).attr("is_ancestor") == 1 ){
                    li_class += " is_ancestor";
                    }

                    newAccount.attr( "class", li_class );

                    // this gets blatted by subsequent call to viewResultPage but it should prevent
                    // temporary display of entire result set.
                    if ( page > 1 ){
                        newAccount.attr( "style", "display:none" );
                    }

                    $("div#parent_account ul#parent_account_search_results").append( newAccount );

                    // increment account counter
                    acc_page_counter += 1;
                    acc_counter += 1;

                    // increment page counter and reset acc_page_counter if necessary
                    if ( acc_page_counter > results_per_page ){
                        page += 1;
                        acc_page_counter = 1;
                    }
            });

            jQuery.fn.viewResultPage(
                    "div#parent_account ul#parent_account_search_results li", 
                    1 , 
                    "div#parent_account div#search_results_summary",
                    parent_accounts_data.accounts_found
                    );

            // Re-register selectors to work with newly added elements.
            jQuery.fn.registerInheritanceSelectors();
        }else{
            $("div#parent_account div#search_results_summary").html( "0 accounts found" );
        }
    }
}


jQuery.fn.clickViewParentResultPage = function () {
    return this.each(function() {
            $(this).click(function () {
                jQuery.fn.viewResultPage(
                    "div#parent_account ul#parent_account_search_results li", 
                    $(this).attr("page") , 
                    "div#parent_account div#search_results_summary",
                    parent_accounts_data.accounts_found
                    );

                });
            });
}


jQuery.fn.viewResultPage = function ( selector, page , summary_selector , accounts_found) {
    // hide all other pages
    $( selector + "[page!=" + page + "]" ).attr("style", "display:none");
    // display this page
    $( selector + "[page=" + page + "]" ).attr("style", "display:block");

    var start = 1;

    if (page > 1){
        start = (( page - 1 ) * results_per_page ) + 1;
    }

    var end = page * results_per_page;
    if ( end > accounts_found ){
        end = accounts_found;
    }

    var page_info = "";
    if ( end > start){
        page_info = ", displaying rows " + start + " to " + end;
    }else if (end == start){
        page_info = ", displaying row " + start;
    }

    $( summary_selector ).html( accounts_found + " " + (accounts_found == 1 ? "account" : "accounts") + " found" + page_info);

    $("strong.search_results_page_link[page="+ page +"]").attr("style", "text-decoration:underline");
    $("strong.search_results_page_link[page!="+ page +"]").attr("style", "text-decoration:none");
}


jQuery.fn.adoptSelectedAccounts = function () {
    return this.each(function() {
            $(this).click(function () {

                $( "div#child_accounts select#child_account_search_results option:selected" ).each( function () {
                    var requested_child = $(this);

                    // Add to the children unless it's already there.
                    var matched = false;
                    if ( $( "div#child_accounts select#child_account_current_children option[acc_id=" + requested_child.attr("acc_id") + "]").length ){
                    matched = true;
                    }

                    if ( !matched ){
                    if ( requested_child.attr("is_ancestor") == 1){
                    alert(
                        requested_child.attr("organisation") + " (" + requested_child.attr("acc_id") + ")\n\n" + 
                        "already inherits from\n\n" + 
                        $("form#acc input#organisation").attr("value") + " ("+ $("form#acc input#acc_id").attr("value") + ")\n\n" + 
                        "and so cannot be selected"
                        );

                    return;
                    }else{
                    var new_child = $( "<option>" + requested_child.attr("organisation") + " (" + requested_child.attr("acc_id") + ")</option>" );
                    new_child.attr("acc_id", requested_child.attr("acc_id"));
                    $( "div#child_accounts select#child_account_current_children" ).append( new_child );
                    }
                    }
                });
            });
    });
}


jQuery.fn.removeSelectedAccounts = function () {
    return this.each(function() {
            $(this).click(function () {
                $( "div#child_accounts select#child_account_current_children option:selected" ).remove();
                });
            });
}

jQuery.fn.saveChildAccounts = function () {
    return this.each(function() {
            $(this).click(function () {
                var child_acc_ids = '';

                $( "div#child_accounts select#child_account_current_children option" ).each( function () {
                    child_acc_ids = child_acc_ids + "&child_acc_ids=" + $(this).attr("acc_id");
                    });

                $("div#child_accounts div#child_account_update_summary").html("Updating child accounts...");

                $.getJSON(
                    "/ajax_widgets/set_child_account.html?parent_acc_id=" + $("form#acc input#acc_id").attr("value") + child_acc_ids,
                    function( data ){
                        jQuery.fn.handleSetChildAccounts( data );
                        jQuery.fn.submitAccountForm();  
                    });
                });
            });
}

jQuery.fn.discardChildAccounts = function () {
    return this.each(function() {
            $(this).click(function () {

                $.getJSON(
                    "/ajax_widgets/get_child_accounts.html?acc_id=" + $("form#acc input#acc_id").attr("value"),
                    function( data ){ jQuery.fn.handleGetChildAccounts( data );}
                    );

                });
            });
}

jQuery.fn.handleGetChildAccounts = function ( data ) {

    $( "div#child_accounts select#child_account_current_children" ).empty();

    if ( $.length ){

        $.each(data.accounts, function(i,item){
                var new_child = $( "<option>" + $(this).attr("organisation") + " (" + $(this).attr("acc_id") + ")</option>" );
                new_child.attr("acc_id", $(this).attr("acc_id"));
                $( "div#child_accounts select#child_account_current_children" ).append( new_child );
                });

    }
}


jQuery.fn.handleSetChildAccounts = function ( data ) {
    if ( $.length ){
        if ( data.error != undefined ){
            $("div#child_accounts div#child_account_update_summary").html( data.error );
        }else{
            $("div#child_accounts div#child_account_update_summary").html( "Children set" );
        }
    }else{
        $("div#child_accounts div#child_account_update_summary").html( "An error occurred" );
    }
}

jQuery.fn.chooseNewParent = function () {
    return this.each(function() {
            $(this).click(function () {

                var new_id = $(this).attr("acc_id");

                if ( new_id == $("div#parent_account input#current_parent_acc_id").attr("value") ){
                return;
                }

                var li_class = "search_result";

                // turn off all currently selected li's
                $("div#parent_account ul#parent_account_search_results li.selected").each(function(i, item) {
                    if ( $(item).attr("is_ancestor") == 1){
                    li_class += " is_ancestor";
                    }
                    // set the relevant class
                    $(item).attr( "class", li_class );
                    });


                $("div#parent_account ul#parent_account_search_results li[acc_id='" + new_id + "']").each(function(i, item){
                    // set the relevant class
                    $(item).attr( "class", li_class + " selected" );

                    if ( $(item).attr("is_ancestor") == 1 ){
                    alert(
                        $(item).attr("organisation") + " (" + new_id + ")\n\n" + 
                        "already inherits from\n\n" + 
                        $("form#acc input#organisation").attr("value") + " (" + $("form#acc input#acc_id").attr("value") + ")\n\n" +
                        "and so cannot be selected."
                        );

                    return;
                    }

                    $("div#parent_account div#new_parent strong#new_parent_display").html( $(item).attr("organisation") + " (" + $(item).attr("acc_id") +")" );
                    $("div#parent_account div#new_parent input#new_parent_acc_id").attr("value", new_id);
                    $("div#parent_account div#new_parent input#new_parent_acc_org").attr("value", $(item).attr("organisation"));
                    });


            });
    });

}


jQuery.fn.saveNewParent = function () {
    return this.each(function() {
            $(this).click(function () {

                // Get the parent_acc_id for the main form
                var new_id = $("div#parent_account div#new_parent input#new_parent_acc_id").attr("value");

                $("form#acc input#parent_acc_id").attr("value", new_id);

                var parent_account_text = "None";

                if ( new_id != undefined && new_id != ""){
                var new_org = $("div#parent_account div#new_parent input#new_parent_acc_org").attr("value");
                parent_account_text = $("<strong><a href=\"/viewedit_account.html?acc_id=" + new_id + "\">" + new_org + " (" + new_id + ")</a></strong>");
                }

                // Set the parent account description in main form
                $("div#parent_account_text").html( parent_account_text );

                jQuery.fn.submitAccountForm();  
                });

    });
}



jQuery.fn.removeParent = function () {
    return this.each(function() {
            $(this).click(function () {
                $("div#parent_account div#new_parent strong#new_parent_display").html( "None" );
                $("div#parent_account div#new_parent input#new_parent_acc_id").attr("value", "");
                $("div#parent_account div#new_parent input#new_parent_acc_org").attr("value", "");
                });
            });
}



jQuery.fn.registerInheritanceSelectors  = function (){

    $("div#parent_account ul#parent_account_search_results li.search_result").chooseNewParent();
    $("div#parent_account strong.search_results_page_link").clickViewParentResultPage();

    $("div#child_accounts strong.search_results_page_link").clickViewChildResultPage();
}

$(document).ready(function () {


    // move the jqmWindows to be direct children of the body.
    $('body').append($('div#parent_account')); 
    $('body').append($('div#parent_account_help')); 

    $('body').append($('div#child_accounts')); 
    $('body').append($('div#child_accounts_help')); 

    // Init the parent account dialog
    $('div#parent_account').jqm({
                                modal:      true, 
                                toTop:      true,
                                trigger:    "input#choose_parent_account"
    });

    // Init the parent account help dialog
    $('div#parent_account_help').jqm({
                                modal:      true, 
                                toTop:      true,
                                onHide:     function(hash){ jQuery.fn.hideNestedModalDiv( hash, 'div#parent_account') },
                                trigger:    "div#parent_account div#display_parent_account_help"
    });

    // Init the child account dialog
    $('div#child_accounts').jqm({
                                modal:      true, 
                                toTop:      true,
                                trigger:    "input#choose_child_accounts"
    });

    // Init the child account help dialog
    $('div#child_accounts_help').jqm({
                                modal:      true, 
                                toTop:      true,
                                onHide:     function(hash){ jQuery.fn.hideNestedModalDiv( hash, 'div#child_accounts') },
                                trigger:    "div#child_accounts div#display_child_accounts_help"
    });

    jQuery.fn.registerInheritanceSelectors();

    $("div#parent_account input#parent_account_search_value").keyPressParentAccountSearch();
    $("div#parent_account input#parent_account_search_button").clickParentAccountSearch();
    $("div#parent_account input#save_parent_account").saveNewParent();
    $("div#parent_account input#remove_parent_account").removeParent();

    $("div#child_accounts input#child_account_search_value").keyPresschildAccountSearch();
    $("div#child_accounts input#child_account_search_button").clickChildAccountSearch();
    $("div#child_accounts input#adopt_selected_accounts").adoptSelectedAccounts();
    $("div#child_accounts input#remove_child_accounts").removeSelectedAccounts();
    $("div#child_accounts input#save_child_accounts").saveChildAccounts();
    $("div#child_accounts input#discard_child_accounts").discardChildAccounts();
});
