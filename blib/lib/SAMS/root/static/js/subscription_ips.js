/*global document, jQuery, alert */
/*jslint browser: true*/
(function ($) {
    "use strict";

    var subscriptionIPData, methods;

    methods = {
        init : function (options) {

            $("table#subscription_ips_listing").subscriptionIP('get', {
                'callback' : function () {
                    $("table#subscription_ips_listing").subscriptionIP('updateListing');
                }
            });

            if ($('div#subscription_ips').length === 1) {
                // Init the Named Users IP dialogs
                $('div#subscription_ips').jqm({
                    modal:   true,
                    toTop:   true,
                    trigger: "input#modify_subscription_ips"
                });

                //Help
                $('div#subscription_ips_help').jqm({
                    modal:   true,
                    toTop:   true,
                    onHide:  function (hash) { jQuery.fn.hideNestedModalDiv(hash, 'div#subscription_ips'); },
                    trigger: "div#subscription_ips div#display_subscription_ips_help"
                });

                // Whois
                $('div#subscription_ips_whois').jqm({
                    modal:      true,
                    toTop:      true,
                    onHide:     function (hash) { jQuery.fn.hideNestedModalDiv(hash, 'div#subscription_ips'); }
                });

                // Init the Named Users Upload dialog
                $('div#upload_subscription_ips').jqm({
                    modal:   true,
                    toTop:   true,
                    trigger: "input#upload_subscription_ips_window_trigger"
                });

                // Init the Named Users Upload Help dialog
                $('div#upload_subscription_ips_help').jqm({
                    modal:   true,
                    toTop:   true,
                    onHide:  function (hash) { jQuery.fn.hideNestedModalDiv(hash, 'div#upload_subscription_ips'); },
                    trigger: "div#upload_subscription_ips div#display_upload_subscription_ips_help"
                });


                // move them all to be direct descendants of body
                $('body').append($('div#subscription_ips'));
                $('body').append($('div#subscription_ips_whois'));
                $('body').append($('div#subscription_ips_help'));
                $('body').append($('div#upload_subscription_ips'));
                $('body').append($('div#upload_subscription_ips_help'));
                $("body").subscriptionIP(
                    'escKey',
                    'div#subscription_ips, div#subscription_ips_whois, div#subscription_ips_help, div#upload_subscription_ips, div#upload_subscription_ips_help'
                );

                // and the event handlers.
                $("div#subscription_ips input#subscription_ip_value").subscriptionIP('enterKey');
                $("div#subscription_ips input#subscription_ip_whois_button").subscriptionIP('whois');
                $("div#subscription_ips input#subscription_ip_add_ip").subscriptionIP('add');
                $("div#subscription_ips select#subscription_ips_current_ips").subscriptionIP('reviewCurrentIP');
                $("div#subscription_ips input#remove_selected_subscription_ips").click(methods.removeSelected);
                $("div#subscription_ips select#subscription_ips_current_ips").subscriptionIP('delKey');
                $("div#subscription_ips input#remove_all_subscription_ips").subscriptionIP('removeAll');
                $("div#subscription_ips input#save_subscription_ips").subscriptionIP('save');
                $("div#subscription_ips input#discard_subscription_ips").subscriptionIP('discard');


                $('div#upload_subscription_ips form#upload_subscription_ips_form').ajaxForm({
                    beforeSubmit: function () {
                        $("ul#upload_subscription_ips_validate_results").empty();
                        $('div#upload_subscription_ips input#upload_subscription_ips_save_button').
                            addClass("ui-state-disabled")
                            .attr("disabled", "disabled");
                    },
                    success: methods.uploadSuccess,
                    error: methods.uploadError,
                    dataType: 'json',
                    iframe: true
                });

                $('div#upload_subscription_ips form#upload_subscription_ips_save_form').ajaxForm({
                    success: methods.saveUploadSuccess,
                    error: methods.uploadError,
                    dataType: 'json',
                    iframe: true
                });

                $("div#upload_subscription_ips input#discard_upload_subscription_ips").subscriptionIP('discardUpload');

                $("#download_subscription_ips").subscriptionIP('download');

                $("table#subscription_ips_listing").tableSortingPaging('init');
            }

        },
        enterKey : function () {
            this.keydown(function (event) {
                if (event.keyCode === '13') {
                    event.preventDefault();
                }
            });
        },
        escKey : function (modalDivsToCheck) {
            this.keydown(function (event) {
                if (event.keyCode === '27') {
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
        delKey : function () {
            this.keydown(function (event) {
                if (event.keyCode === '46') {
                    event.preventDefault();
                    methods.removeSelected();
                }
            });
        },
        whois : function () {

            this.click(function () {

                if ($('div#subscription_ips input#subscription_ip_value').val() === '') {
                    return;
                }

                $("div#subscription_ips_whois div#subscription_ips_whois_text").html();

                var requestData = {
                    'method'  :  'whois',
                    'subs_id' :  $("form#sub input#subs_id").attr("value"),
                    'subscription_ips' :  [ { 'ip_address' : $('div#subscription_ips input#subscription_ip_value').val() } ]
                };
                $.ajax({
                    url: "/ajax_widgets/subscription_ips.json",
                    dataType: 'json',
                    data: { data: JSON.stringify(requestData) },
                    type: 'POST',
                    success: function (data, textStatus, jqXHR) {
                        if ($(data).length && data.subscription_ips.length) {
                            var whois_error_array, whois_text_array;

                            // This creates an array of all of the errors in the data.subscription_ips.
                            // If this array has length, there are errors. This array is suitable for joining.
                            whois_error_array = $.map(
                                $.grep(
                                    data.subscription_ips,
                                    function (val) { return val.errors; }
                                ),
                                function (val) { return val.errors; }
                            );

                            if (whois_error_array.length) {
                                alert(whois_error_array.join("\n"));
                            } else {
                                $("div#subscription_ips_whois").jqmShow();

                                // This time the filtering does not need to occur,
                                // so this just gets the whois text data for joining.
                                whois_text_array = $.map(data.subscription_ips, function (val) {
                                    return val.whois_text;
                                });
                                $("div#subscription_ips_whois div#subscription_ips_whois_text").html(whois_text_array.join("\n\n"));
                            }
                        } else {
                            alert("An error occurred");
                        }
                    }
                });
            });
        },
        add : function () {
            this.click(function () {

                if ($('div#subscription_ips input#subscription_ip_value').val() === '') {
                    return;
                }

                var requestData = {
                    'method'     :  'validate',
                    'subs_id' :  $("form#sub input#subs_id").attr("value"),
                    'ip_address' :  $('div#subscription_ips input#subscription_ip_value').val()
                };

                $.ajax({
                    url: "/ajax_widgets/subscription_ips.json",
                    dataType: 'json',
                    data: { data: JSON.stringify(requestData) },
                    type: 'POST',
                    success: function (data, textStatus, jqXHR) {
                        if ($(data).length) {
                            if (data.valid === 1) {
                                var notes, ips_list, i, ip, new_ip;

                                // The data now has the valid ip addresses to add under the 'ips' key.
                                // Add all of them along with the provided notes, after removing any
                                // duplicates.
                                notes = $('div#subscription_ips textarea#subscription_ips_notes').val();
                                ips_list = $("div#subscription_ips select#subscription_ips_current_ips");

                                for (i in data.ips) {
                                    if (data.ips.hasOwnProperty(i)) {
                                        ip = data.ips[i].replace("/32", "");

                                        ips_list.find("option[value=" + ip + "]").remove();

                                        new_ip = $("<option>" + ip + "</option>");
                                        new_ip.val(ip);
                                        new_ip.data('notes', notes);
                                        $("div#subscription_ips select#subscription_ips_current_ips").append(new_ip);
                                    }
                                }

                            } else {
                                alert(data.error);
                            }
                        }
                    }
                });
            });
        },
        removeSelected : function () {
            $("div#subscription_ips select#subscription_ips_current_ips option:selected").remove();
        },
        removeAll : function () {
            this.click(function () {
                $("div#subscription_ips select#subscription_ips_current_ips option").remove();
            });
        },
        save : function () {
            this.click(function () {
                var requestData = {
                    'method'  :  'set',
                    'subs_id' :  $("form#sub input#subs_id").attr("value"),
                    'subscription_ips' : []
                };

                $('select#subscription_ips_current_ips option').each(function (i, item) {
                    requestData.subscription_ips[i] = {
                        'ip_address' : $(item).val(),
                        'notes' : jQuery.data(item, 'notes')
                    };
                });

                $.ajax({
                    url: "/ajax_widgets/subscription_ips.json",
                    dataType: 'json',
                    data:  { data: JSON.stringify(requestData) },
                    type: 'POST',
                    async: true,
                    cache: false,
                    success: function (data, textStatus, jqXHR) {
                        subscriptionIPData = data;
                        $("table#subscription_ips_listing").subscriptionIP('updateListing');
                        $("div#subscription_ips").jqmHide();
                    },
                    error: function () {
                        alert("An error occurred");
                    }
                });
            });
        },
        get : function (options) {

            this.each(function () {
                var requestData = {
                    'method'  :  'get',
                    'subs_id' :  $("form#sub input#subs_id").attr("value")
                };
                $.ajax({
                    url: "/ajax_widgets/subscription_ips.json",
                    dataType: 'json',
                    data:  { data: JSON.stringify(requestData) },
                    type: 'POST',
                    async: true,
                    cache: false,
                    success: function (data, textStatus, jqXHR) {
                        subscriptionIPData = data;
                        options.callback();
                    }
                });
            });
        },
        updateListing : function () {
            this.each(function () {
                $("table#subscription_ips_listing tbody").empty();
                $("div#subscription_ips select#subscription_ips_current_ips").empty();

                if ($(subscriptionIPData).length) {

                    var ips_found = 0;

                    if (subscriptionIPData.subscription_ips_found > 0) {
                        $.each(subscriptionIPData.subscription_ips, function (i, item) {
                            var ip_row, notes, new_ip;

                            ip_row = $("<tr>");
                            $(ip_row).append("<td class=\"ip\">" + $(item).attr("ip_address") + "</td>");

                            notes = $(item).attr("notes") !== null ?
                                    $(item).attr("notes") : "";
                            $(ip_row).append("<td>" + notes + "</td>");

                            $("table#subscription_ips_listing tbody").append($(ip_row).clone());

                            new_ip = $("<option>" + $(item).attr("ip_address") + "</option>");
                            new_ip.val($(item).attr("ip_address"));
                            new_ip.data('notes', $(item).attr("notes"));

                            $("div#subscription_ips select#subscription_ips_current_ips").append(new_ip);

                        });

                    } else {
                        $("table#subscription_ips_listing tbody").append("<tr><td colspan=\"2\">No Named User IPs</td></tr>");
                    }
                }

                $("table#subscription_ips_listing").tableSortingPaging('update');
            });
        },
        discard : function () {
            this.click(function () {
                $("table#subscription_ips_listing").subscriptionIP('updateListing');
                $("div#subscription_ips").jqmHide();
            });
        },
        reviewCurrentIP : function () {
            this.bind('click change', function () {
                $('div#subscription_ips input#subscription_ip_value').val($(this).children('option').filter(':selected').filter(':first').val());
                $('div#subscription_ips textarea#subscription_ips_notes').val($(this).children('option').filter(':selected').filter(':first').data('notes'));
            });
        },
        download : function () {
            this.click(function () {
                document.location.href = "/named_users/export_ips.html?subs_id=" + $("form#sub input#subs_id").val();
            });
        },
        uploadSuccess : function (data, status, xhr, element) {
            var row_index = 1;

            if (data.problems) {

                $.each(data.problems, function (i, item) {
                    var data_li = $("<li><span class='ui-state-error'><span class='inline_icon ui-icon ui-icon-alert'></span></span><span>" + item + "</span></li>");
                    $("ul#upload_subscription_ips_validate_results").append(data_li);
                });


                $('div#upload_subscription_ips input#upload_subscription_ips_save_button').
                    addClass("ui-state-disabled")
                    .attr("disabled", "disabled");

            }

            $.each(data.source_rows, function (i, item) {
                var data_li, span_icon, span_row_index, problems;

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

                problems = $("<ul>");

                if (item.problems && item.problems.length > 0) {
                    $.each(item.problems, function (j, problem_item) {
                        $(problems).append("<li>" + problem_item + "</li>");
                    });
                }

                $(data_li).append(problems);

                $("ul#upload_subscription_ips_validate_results").append(data_li);

                row_index += 1;
            });

            if (data.problems.length === 0) {
                // Enable the upload save button
                $('div#upload_subscription_ips input#upload_subscription_ips_save_button').
                    removeClass("ui-state-disabled")
                    .attr("disabled", "");

            }
        },
        uploadError : function () {
            alert("An error occurred");
        },
        discardUpload : function () {
            this.click(function () {
                $("div#upload_subscription_ips ul#upload_subscription_ips_validate_results").empty();
                $('div#upload_subscription_ips input#upload_subscription_ips_save_button').
                        addClass("ui-state-disabled")
                        .attr("disabled", "disabled");
                $("div#upload_subscription_ips").jqmHide();
            });
        },
        saveUploadSuccess : function (data, status, xhr) {
            $("table#subscription_ips_listing").subscriptionIP('get', {
                'callback' : function () { $("table#subscription_ips_listing").subscriptionIP('updateListing'); }
            });
            $("div#upload_subscription_ips").jqmHide();
        }
    };


    $.fn.subscriptionIP = function (method) {

        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
        $.error('Method ' +  method + ' does not exist on jQuery.subscriptionIP');

    };

}(jQuery));


(function ($) {
    "use strict";
    $(document).ready(function () {
        $().subscriptionIP('init');
    });

}(jQuery));
