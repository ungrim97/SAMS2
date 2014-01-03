/*global jQuery, alert */
/*jslint browser: true */
(function ($) {
    "use strict";

    /*
        To be used in conjunction with : 
            * live/comps/named_users/modify_named_users.frag
            * live/comps/named_users/upload_named_users.frag

    */
    var named_user_acc_ids, named_user_accounts_data, namedUserData, namedUserAdminData, results_per_page, methods;

    namedUserData = {};
    namedUserAdminData = {};

    results_per_page = 20;

    methods = {
        init : function (options) {

            if ($('div#named_users').length === 1) {
                // Named Users dialog
                $('div#named_users').jqm({
                    modal:      true,
                    toTop:      true,
                    onShow:     methods.show
                });

                $('div#named_users').jqmAddTrigger("input#modify_named_users");
                $('div#named_users').jqmAddTrigger("input#modify_named_user_admins");


                // Named Users Help dialog
                $('div#named_users_help').jqm({
                    modal:      true,
                    toTop:      true,
                    onHide:     function (hash) { jQuery.fn.hideNestedModalDiv(hash, 'div#named_users'); },
                    trigger:    "div#named_users div#display_named_users_help"
                });

                // Init the Named Users Upload dialog
                $('div#upload_named_users').jqm({
                    modal:      true,
                    toTop:      true,
                    trigger:    "input#upload_named_users_window_trigger"
                });

                // Init the Named Users Upload Help dialog
                $('div#upload_named_users_help').jqm({
                    modal:      true,
                    toTop:      true,
                    onHide:     function (hash) { jQuery.fn.hideNestedModalDiv(hash, 'div#upload_named_users'); },
                    trigger:    "div#upload_named_users div#display_upload_named_users_help"
                });

                // move the jqmWindows to be direct children of the body.
                $('body').append($('div#named_users'));
                $('body').append($('div#named_users_help'));
                $('body').append($('div#upload_named_users'));
                $('body').append($('div#upload_named_users_help'));

                $("body").namedUsers('escKey', "div#named_users, div#named_users_help, div#upload_named_users, div#upload_named_users_help");

                $("div#named_users input#named_user_account_search_value").namedUsers('enterKey');
                $("div#named_users select#named_users_current_named_users").namedUsers('delKey');
                $("div#named_users select#named_users_current_named_user_admins").namedUsers('delKey');
                $("div#named_users input#named_user_account_search_button").namedUsers('clickSearch');
                $("div#named_users input#add_selected_users").namedUsers('add');
                $("div#named_users input#remove_selected_named_users").click(methods.removeSelected);
                $("div#named_users input#remove_all_named_users").namedUsers('removeAll');
                $("div#named_users input#save_named_users").namedUsers('save');
                $("div#named_users input#discard_named_users").namedUsers('discard');



                $('div#upload_named_users form#upload_named_users_form').ajaxForm({
                    beforeSubmit: function () {
                        $("ul#upload_named_user_validate_results").empty();
                        $('div#upload_named_users input#upload_named_users_save_button').
                            addClass("ui-state-disabled")
                            .attr("disabled", "disabled");
                    },
                    success: methods.uploadSuccess,
                    error: methods.uploadError,
                    dataType: 'json',
                    iframe: true
                });

                $('div#upload_named_users form#upload_named_users_save_form').ajaxForm({
                    success: methods.saveUploadSuccess,
                    error: methods.uploadError,
                    dataType: 'json',
                    iframe: true
                });

                $("div#upload_named_users input#discard_upload_named_users").namedUsers('discardUpload');

                $("#download_named_users").namedUsers('download');

            }

            $("table#named_user_listing").tableSortingPaging('init');
            $("table#named_user_listing").namedUsers('get', {
                'target' : 'user',
                'callback' : function () { $("table#named_user_listing").namedUsers('updateListing', { 'target' : 'user' }); }
            });

            $("table#named_user_admin_listing").tableSortingPaging('init');
            $("table#named_user_admin_listing").namedUsers('get', {
                'target': 'admin',
                'callback': function () { $("table#named_user_admin_listing").namedUsers('updateListing', { 'target' : 'admin' }); }
            });

        },
        show: function (hash) {
            hash.w.show();

            if (hash.t.id === 'modify_named_users') {
                $("div#named_users").data('is_user', 1);
                $("div#named_users").data('is_admin', 0);

                $("div#named_users h4:first").html("Modify Named Users");
                $("div#named_users select#named_users_current_named_users").prev("h4").html("Current Named Users");
                $("div#named_users select#named_users_current_named_user_admins").hide();
                $("div#named_users select#named_users_current_named_users").show();
            } else if (hash.t.id === 'modify_named_user_admins') {
                $("div#named_users").data('is_user', 0);
                $("div#named_users").data('is_admin', 1);

                $("div#named_users h4:first").html("Modify Named User Administrators");
                $("div#named_users select#named_users_current_named_user_admins").prevAll("h4").html("Current Named User Administrators");
                $("div#named_users select#named_users_current_named_users").hide();
                $("div#named_users select#named_users_current_named_user_admins").show();
            }
        },
        enterKey: function () {
            this.keydown(function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    methods.search($(this).attr("value"));
                }
            });
        },
        escKey: function (modalDivsToCheck) {
            this.keydown(function (event) {
                if (event.keyCode === 27) {
                    var highestZindex, topmostDiv;

                    highestZindex = 0;
                    $(modalDivsToCheck).filter(":visible").each(function () {
                        if ($(this).css("z-index") > highestZindex) {
                            highestZindex = $(this).css("z-index");
                            topmostDiv = $(this);
                        }
                    });

                    if (topmostDiv) {
                        event.stopPropagation();
                        event.preventDefault();
                        topmostDiv.jqmHide();
                    }
                }
            });
        },
        delKey: function () {
            this.keydown(function (event) {
                if (event.keyCode === 46) {
                    event.preventDefault();
                    methods.removeSelected();
                }
            });
        },
        clickSearch: function () {
            this.click(function () {
                methods.search($("div#named_users input#named_user_account_search_value").attr("value"));
            });
        },
        search: function (string) {
            if (string !== undefined && string !== "") {
                var url = "/ajax_widgets/named_user_account_search.json?";
                url += "acc_id=" + $("form#sub input#acc_id").val();
                url += "&q=" + encodeURIComponent(string);

                $("div#named_users div#search_results_summary").html("searching for " + string);
                $.getJSON(
                    url,
                    function (data) {
                        if ($(data).length) {
                            named_user_accounts_data = data;
                            methods.viewPage(1);
                        }
                    }
                );
            } else {
                $("div#named_users div#search_results_summary").html("You must enter a search value");
            }
        },
        calcPagination: function (num_items, pagination_selector) {
            var number_of_pages, i, pagination;

            number_of_pages = 1;
            $(pagination_selector).empty();

            if (num_items % results_per_page) {
                number_of_pages = Math.floor(num_items / results_per_page) + 1;
            } else {
                number_of_pages = num_items / results_per_page;
            }

            if (number_of_pages > 1) {
                for (i = 1; i <= number_of_pages; i += 1) {
                    pagination = $("<strong class='search_results_page_link'>" + i + "</strong>");
                    pagination.data("page", i);
                    $(pagination_selector).append(pagination);
                }
            }

            return number_of_pages;
        },
        clickViewPage: function () {
            this.click(function () {
                methods.viewPage($(this).data('page'));
            });
        },
        viewPage: function (view_page) {

            $("div#named_users select#named_user_account_search_results").empty();
            $("div#named_users div.search_results_pagination").empty();

            if (named_user_accounts_data.accounts_found > 0) {
                var number_of_pages, page, acc_page_counter, acc_counter;

                number_of_pages = methods.calcPagination(named_user_accounts_data.accounts_found, "div#named_users div.search_results_pagination");
                page = 1;
                acc_page_counter = 1;
                acc_counter = 1;

                $("div#named_users div#search_results_summary").html(named_user_accounts_data.accounts_found + " " + (named_user_accounts_data.accounts_found === 1 ? "account" : "accounts") + " found");

                $.each(named_user_accounts_data.accounts, function (i, item) {

                    if (page === view_page) {
                        var newAccount = $("<option>" + acc_counter + " : "
                            + $(item).attr("organisation") + " (" + $(item).attr("acc_id") + ")</option>");

                        newAccount.attr("acc_id", $(item).attr("acc_id"));
                        newAccount.attr("organisation", $(item).attr("organisation"));
                        newAccount.attr("page", page);
                        newAccount.attr("class", "search_result");

                        $("div#named_users select#named_user_account_search_results").append(newAccount);
                    }

                    // increment account counter
                    acc_page_counter += 1;
                    acc_counter += 1;

                    // increment page counter and reset acc_page_counter if necessary
                    if (acc_page_counter > results_per_page) {
                        page += 1;
                        acc_page_counter = 1;
                    }

                });

                // Re-register selectors to work with newly added elements.
                $("div#named_users strong.search_results_page_link").namedUsers('clickViewPage');

                $("strong.search_results_page_link[page=" + view_page + "]").attr("style", "text-decoration:underline");
                $("strong.search_results_page_link[page!=" + view_page + "]").attr("style", "text-decoration:none");

                $("div#named_users select#named_user_account_search_results").focus();
            } else {
                $("div#named_users div#search_results_summary").html("0 accounts found");
            }
        },
        add : function () {
            this.click(function () {
                $("div#named_users select#named_user_account_search_results option:selected").each(function () {
                    var requested_account, selector, matched, new_child;

                    requested_account = $(this);

                    selector = '';
                    if ($("div#named_users").data('is_user') === 1) {
                        selector = 'named_users_current_named_users';
                    } else if ($("div#named_users").data('is_admin') === 1) {
                        selector = 'named_users_current_named_user_admins';
                    }

                    // Add to the current named users unless it's already there.
                    matched = false;
                    if ($("div#named_users select#" + selector + " option[acc_id=" + requested_account.attr("acc_id") + "]").length) {
                        matched = true;
                    }

                    if (!matched) {
                        new_child = $("<option>" + requested_account.attr("organisation") + " (" + requested_account.attr("acc_id") + ")</option>");
                        new_child.attr("acc_id", requested_account.attr("acc_id"));
                        $("div#named_users select#" + selector).append(new_child);
                    }
                });

                $("div#named_users select#named_user_account_search_results").focus();
            });
        },
        removeSelected: function () {
            var selector = '';
            if ($("div#named_users").data('is_user') === 1) {
                selector = 'named_users_current_named_users';
            } else if ($("div#named_users").data('is_admin') === 1) {
                selector = 'named_users_current_named_user_admins';
            }

            $("div#named_users select#" + selector + " option:selected").remove();

        },
        removeAll: function () {
            this.click(function () {
                var selector = '';
                if ($("div#named_users").data('is_user') === 1) {
                    selector = 'named_users_current_named_users';
                } else if ($("div#named_users").data('is_admin') === 1) {
                    selector = 'named_users_current_named_user_admins';
                }

                $("div#named_users select#" + selector + " option").remove();
            });
        },
        save : function () {

            this.click(function () {
                var status_div, error_class, is_admin, user_selector, max_users, params;

                named_user_acc_ids = '';
                status_div         = $("div#named_users div#named_users_update_summary");
                error_class        = 'ui-state-error';
                is_admin           = $("div#named_users").data("is_admin") === 1;
                user_selector      = is_admin
                    ? "div#named_users select#named_users_current_named_user_admins option"
                    : "div#named_users select#named_users_current_named_users option";

                status_div.html("Updating Named Users...").removeClass(error_class);

                params = $(user_selector).map(function () {
                    return 'named_user_acc_ids=' + $(this).attr('acc_id');
                });

                max_users = $("input#named_users_unlimited_max_users:checked").length
                          ? -1
                          : $("input#max_users").val();
                params.push('max_users=' + max_users);
                params.push('subs_id=' + $("form#sub input#subs_id").val());
                params.push('method=set');

                if (is_admin) {
                    params.push('is_user=0');
                    params.push('is_admin=1');
                } else {
                    params.push('is_user=1');
                    params.push('is_admin=0');
                }

                $.getJSON(
                    "/ajax_widgets/named_users.json?" + Array.prototype.join.call(params, '&'),
                    function (data) {
                        if ($.length) {
                            if (data.error !== undefined) {
                                status_div.html(data.error).addClass(error_class);
                            } else {
                                status_div.html("Named Users set");

                                if ($("div#named_users").data('is_user') === 1) {
                                    namedUserData = data;
                                    $("table#named_user_listing").namedUsers(
                                        'updateListing',
                                        { 'target' : 'user' }
                                    );
                                } else if ($("div#named_users").data('is_admin') === 1) {
                                    namedUserAdminData = data;
                                    $("table#named_user_listing").namedUsers(
                                        'updateListing',
                                        { 'target' : 'admin' }
                                    );
                                }
                                $("div#named_users").jqmHide();
                            }
                        } else {
                            status_div.html("An error occurred").addClass(error_class);
                        }
                    }
                );
            });
        },
        get: function (options) {

            this.each(function () {
                var user_or_admin, role_param;

                user_or_admin = options.target;

                role_param = '&' + user_or_admin + '=1';

                $.ajax({
                    url: "/ajax_widgets/named_users.json?method=get&subs_id=" + $("form#sub input#subs_id").attr("value") + role_param,
                    dataType: 'json',
                    type: 'POST',
                    async: true,
                    cache: false,
                    success: function (data, textStatus, jqXHR) {
                        if (user_or_admin === 'user') {
                            namedUserData = data;
                        } else if (user_or_admin === 'admin') {
                            namedUserAdminData = data;
                        }
                        options.callback();
                    }
                });
            });
        },
        updateListing: function (options) {

            this.each(function () {
                var user_or_admin, data;

                user_or_admin = options.target;

                if (user_or_admin === 'user') {
                    $("table#named_user_listing tbody").empty();
                    $("select#named_users_current_named_users").empty();
                    data = namedUserData;
                } else if (user_or_admin === 'admin') {
                    $("table#named_user_admin_listing tbody").empty();
                    $("select#named_users_current_named_user_admins").empty();
                    data = namedUserAdminData;
                }

                $("div#named_users div#named_users_update_summary").empty();

                if ($(data).length) {

                    if (data.max_users === -1) {
                        $("input#named_users_unlimited_max_users").attr("checked", "checked");
                        $("input#max_users").val("");
                    } else {
                        $("input#named_users_unlimited_max_users").attr("checked", "");
                        $("input#max_users").val(data.max_users);
                    }

                    if (data.named_users_found > 0) {

                        $.each(data.named_users, function (i, item) {
                            var user_row, newAccount;

                            user_row = $("<tr>");
                            $(user_row).append("<td><a href=\"viewedit_account.html?acc_id=" + $(this).attr("acc_id") + "\">" + $(this).attr("acc_id") + "</a></td>");
                            $(user_row).append("<td>" + $(this).attr("organisation") + "</td>");
                            $(user_row).append("<td>" + $(this).attr("username") + "</td>");
                            $(user_row).append("<td>" + $(this).attr("contact_given_name") + "</td>");
                            $(user_row).append("<td>" + $(this).attr("contact_family_name") + "</td>");

                            newAccount = $("<option>" + $(item).attr("organisation") + " (" + $(item).attr("acc_id") + ")</option>");
                            newAccount.attr("acc_id", $(item).attr("acc_id"));
                            newAccount.attr("organisation", $(item).attr("organisation"));

                            if (user_or_admin === 'user' && $(this).attr("is_user") === 1) {
                                $("table#named_user_listing tbody").append(user_row);
                                $('select#named_users_current_named_users').append(newAccount);
                            }
                            if (user_or_admin === 'admin' && $(this).attr("is_admin") === 1) {
                                $("table#named_user_admin_listing tbody").append(user_row);
                                $('select#named_users_current_named_user_admins').append(newAccount);
                            }

                        });


                        if (user_or_admin === 'user') {
                            $("table#named_user_listing").tableSortingPaging('update');
                        } else if (user_or_admin === 'admin') {
                            $("table#named_user_admin_listing").tableSortingPaging('update');
                        }
                    }
                    $.each(
                        // The table is named_user(_admin)_listing
                        // The tab is a href to #named_user(_admin)s
                        // (unfortunately this is wrapped in a li which does
                        // not match well - it uses administrators). The tab
                        // title is the correct way to refer to the current
                        // named users.
                        ["named_user", "named_user_admin"],
                        function (index, value) {
                            var table, title;

                            table = "table#" + value + "_listing tbody";
                            title = $("a[href='#" + value + "s_tab']").text();
                            if ($(table + " tr").length === 0) {
                                $(table).append('<tr><td colspan="5">No ' + title + '</td></tr>');
                            }
                        }
                    );
                }
            });
        },
        discard : function () {
            this.click(function () {
                if ($("div#named_users").data('is_user') === 1) {
                    $("table#named_user_listing").namedUsers('updateListing', { 'target' : 'user' });
                } else if ($("div#named_users").data('is_admin') === 1) {
                    $("table#named_user_listing").namedUsers('updateListing', { 'target' : 'admin' });
                }

                $("div#named_users").jqmHide();
            });
        },
        download: function () {
            this.click(function () {
                document.location.href = "/named_users/export.html?subs_id=" + $("form#sub input#subs_id").val() + "&is_user=1&is_admin=0";
            });
        },
        uploadSuccess: function (data, status, xhr, element) {
            var row_index = 1;

            if (data.problems) {

                $('div#upload_named_users input#upload_named_users_save_button').
                    addClass("ui-state-disabled").attr("disabled", "disabled");

                $.each(data.problems, function (i, item) {
                    var data_li = $("<li><span class='ui-state-error'><span class='inline_icon ui-icon ui-icon-alert'></span></span><span>" + item + "</span></li>");
                    $("ul#upload_named_user_validate_results").append(data_li);
                });
            }



            $.each(data.parsed_rows, function (i, item) {
                var data_li, span_icon, span_row_index, span_summary, problems;

                data_li = $("<li>");

                span_icon = $("<span><span class='inline_icon ui-icon'></span></span>");

                if ($(this).attr("valid") === "1") {
                    $(span_icon).children("span.inline_icon").addClass("ui-icon-check");
                } else {
                    $(span_icon).addClass("ui-state-error");
                    $(span_icon).children("span.inline_icon").addClass("ui-icon-alert");
                }

                $(data_li).append(span_icon);

                span_row_index = $("<span>Row " + row_index + "</span>");
                $(data_li).append(span_row_index);

                span_summary = $("<span>");

                if (item.account_id) {
                    $(span_summary).append("Use existing account: " + item.account_id);
                } else if (item.account) {
                    $(span_summary).append("Create new account: " + item.account.organisation + ", " + item.username);
                }

                $(data_li).append(span_summary);

                problems = $("<ul>");

                if (item.problems && item.problems.length > 0) {
                    $.each(item.problems, function (j, problem_item) {
                        $(problems).append("<li>" + problem_item + "</li>");
                    });
                }

                $(data_li).append(problems);

                $("ul#upload_named_user_validate_results").append(data_li);

                row_index += 1;
            });

            if (data.problems.length === 0) {
                // Enable the upload save button
                $('div#upload_named_users input#upload_named_users_save_button').
                    removeClass("ui-state-disabled")
                    .attr("disabled", "");

            }
        },
        uploadError: function () {
            alert("An error occurred, e.g. there may be no file to upload");
        },
        discardUpload: function () {
            this.click(function () {
                $("div#upload_named_users ul#upload_named_user_validate_results").empty();
                $('div#upload_named_users input#upload_named_users_save_button').
                        addClass("ui-state-disabled")
                        .attr("disabled", "disabled");
                $("div#upload_named_users").jqmHide();
            });
        },
        saveUploadSuccess: function (data, status, xhr) {
            $("table#named_user_listing").namedUsers('get', {
                'target': 'user',
                'callback': function () { $("table#named_user_listing").namedUsers('updateListing', {'target' : 'user'}); }
            });
            $("div#upload_named_users").jqmHide();
        }


    };

    $.fn.namedUsers = function (method) {

        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
        $.error('Method ' + method + ' does not exist on jQuery.namedUsers');

    };

}(jQuery));


(function ($) {
    "use strict";
    $(document).ready(function () {
        $().namedUsers('init');
    });

}(jQuery));
