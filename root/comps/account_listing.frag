<%args>
</%args>
<%init>
</%init>
<table id="account_listing">
    <thead>
        <tr>
            <th>Account ID</th>
            <th>Account Name</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<script>
$(document).ready(function () {

    // Init DataTables for Product Titles
    var accountTable = $("table#account_listing").dataTable( {
        "bProcessing": true,
        "bServerSide": true,
        "bAutoWidth": false,
        "bSort": true,
        "aaSorting": [[1, 'asc']],
        "bStateSave": true,
        "iDisplayStart": 0,
        "oLanguage": {
            "sZeroRecords": "No accounts found",
        },
        "iDeferLoading": 0,
        "sDom": 
            '<"action-toolbar ui-widget ui-widget-header ui-corner-all"ilp>rt<"action-toolbar ui-widget ui-widget-header ui-corner-all"lp><"clear">',
        "sPaginationType": "full_numbers",
        "aLengthMenu": [10, 50, 100, 200],
        "iDisplayLength": 50,
        "aoColumns": [
            { "sName": "account_id", "bSortable": true, "sWidth": "15%" },
            { "sName": "organisation", "bSortable": true, "sWidth": "55%" },
            { "sName": "actions", "bSortable": false, "sWidth": "30%" }
        ],
        "fnDrawCallback": function (oSettings) {
            // Redraw the pagination butons
            $(oSettings.nTableWrapper).find('div.dataTables_paginate a')
                .addClass("ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only")
                .removeClass("ui-state-highlight ui-state-disabled");

            $(oSettings.nTableWrapper).find('div.dataTables_paginate a.paginate_active')
                .addClass("ui-state-highlight")
                .removeClass("ui-state-default ui-state-disabled");
    
            $(oSettings.nTableWrapper).find('div.dataTables_paginate a.paginate_button_disabled')
                .addClass("ui-state-disabled")
                .removeClass("ui-state-default ui-state-highlight");
        },
        "sAjaxSource": '/ajax_widgets/find_account.json',
        "fnServerParams": function (aoData) {
            addSearchParams(aoData);
        },
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            rowCallbackAddActionLinks(nRow, aData);
        },
        "fnCreatedRow" : function(nRow, aData, iDataIndex) {
            $(nRow).addClass("action_icons_row");
        }
    } );
    // Reset the current page to start. bStateSave retrieves this from a cookie if present and overrides the iDisplayStart
    // initialisation setting, but in this case the table could have less pages in it due to the search being performed 
    // than are stored in the cookie so this needs to be reset. The table is yet to be drawn at this stage due to the iDeferLoading 
    // setting and will be drawn as a result of the call to fnMultiFilter.
    accountTable.fnSettings()._iDisplayStart = 0;

    /**
     * Modifies aoData to include the search params returned by getSearchParams(). Depending
     * on where this component is used this could be the search form or the quick search form.
     */
    var addSearchParams = function (aoData) {
        var formParams = getSearchFormParams();
        for (formParam in formParams) {
            aoData.push({"name": formParam, "value": formParams[formParam]});
        }
    }

    var rowCallbackAddActionLinks = function (nRow, aData) {

        var organisation = aData[1];
        var organisationLink = $('<a href="/viewedit_account.html?acc_id=' + aData[0] + '">' + organisation + '</a>');
        $('td:eq(1)', nRow).html(organisationLink);

        var actionIcons= $('<span class="action_icons"></span>');

        var usageButton = $('<a href="" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">'
                            + '<span class="ui-button-icon-primary ui-icon ui-icon-document"></span><span class="ui-button-text"></span></a>');
        usageButton.find("span.ui-button-text").text("Usage");
        usageButton.attr("title", "View subscriber services usage statistics reports for this account");
        usageButton.attr("href", "/report/counter.html?acc_id=" + aData[0]);
        actionIcons.append(usageButton);

        var counterButton = $('<a href="" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">'
                            + '<span class="ui-button-icon-primary ui-icon ui-icon-calculator"></span><span class="ui-button-text"></span></a>');
        counterButton.find("span.ui-button-text").text("COUNTER 3");
        counterButton.attr("title", "View COUNTER usage statistics reports for this account");
        counterButton.attr("href", "/report/counter.html?acc_id=" + aData[0]);
        actionIcons.append(counterButton);

        var counterStarButton = $('<a href="" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">'
                            + '<span class="ui-button-icon-primary ui-icon ui-icon-calculator"></span><span class="ui-button-text"></span></a>');
        counterStarButton.find("span.ui-button-text").text("COUNTER 4");
        counterStarButton.attr("title", "View COUNTER usage statistics reports for this account");
        counterStarButton.attr("href", "/report/counter.html?acc_id=" + aData[0]);
        actionIcons.append(counterStarButton);

        var testButton = $('<a href="" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">'
                            + '<span class="ui-button-icon-primary ui-icon ui-icon-mail-closed"></span><span class="ui-button-text"></span></a>');
        testButton.find("span.ui-button-text").text("Test");
        testButton.attr("title", "Test email templates for this account");
        testButton.attr("href", "/email_test.html?acc_id=" + aData[0]);
        actionIcons.append(testButton);

        $('td:eq(2)', nRow).html(actionIcons);
    }

} );
</script>
%# vim: set ai et sw=4 syntax=mason:
