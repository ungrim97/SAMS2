/*global jQuery */
/*jslint browser: true*/
/*
    Interface to the tablesorter plugin with our default sorting/paging options and styles
*/
(function ($) {
    "use strict";

    var methods = {
        init : function (sortOptions) {
            var defaultSortOptions, optionName;

            defaultSortOptions = {
                cancelSelection: true,
                cssAsc: 'headerSortDesc',
                cssDesc: 'headerSortAsc',
                textExtraction: methods.tablesorter_extraction
            };

            if (sortOptions === null || sortOptions === undefined) {
                sortOptions = defaultSortOptions;
            } else {
                for (optionName in defaultSortOptions) {
                    if (defaultSortOptions.hasOwnProperty(optionName) && sortOptions[optionName] === null) {
                        sortOptions[optionName] = defaultSortOptions[optionName];
                    }
                }
            }

            this.each(function () {
                $(this).tablesorter(sortOptions);

                $(this).bind("sortEnd", function () {
                    $(":parent th").each(function () {
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-1-n');
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-1-s');
                        $("span.ui-icon", this).addClass('ui-icon-triangle-2-n-s');
                    });

                    // descending order.
                    $(":parent th.headerSortDesc").each(function () {
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-1-n');
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-2-n-s');
                        $("span.ui-icon", this).addClass('ui-icon-triangle-1-s');
                    });

                    // ascending order.
                    $(":parent th.headerSortAsc").each(function () {
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-1-s');
                        $("span.ui-icon", this).removeClass('ui-icon-triangle-2-n-s');
                        $("span.ui-icon", this).addClass('ui-icon-triangle-1-n');
                    });
                });
            });

            $('div.pager .first').button({ text: false, icons: { primary : "ui-icon-arrowthickstop-1-w" } });
            $('div.pager .prev').button({ text: false, icons: { primary : "ui-icon-arrowthick-1-w" } });
            $('div.pager .next').button({ text: false, icons: { primary : "ui-icon-arrowthick-1-e" } });
            $('div.pager .last').button({ text: false, icons: { primary : "ui-icon-arrowthickstop-1-e" } });


            this.each(function () {
                var pagerId, session_size, page_size;

                pagerId = "#" + $(this).attr("id") + "_pager";

                // Deseralize page size value from session cookie
                session_size = $.cookie('pagination_per_page');
                page_size = session_size || 100;

                if ($(pagerId).size()) {
                    $(this).tablesorterPager(
                        {
                            container: $(pagerId),
                            size: page_size,
                            positionFixed: false
                        }
                    );
                }
            });

        },
        tablesorter_extraction : function (node) {
            var text, split, chars, joiner;

            text = "";
            if ($(node).children('time[datetime]').length > 0) {
                text = $(node).children('time').attr('datetime');
            }
            if ($(node).hasClass('ip')) {
                text = $(node).text();
                // Nasty way to turn an ip address, of any form, into
                // a single fixed length number. That way string comparison
                // will sort it correctly.
                // This strips any ranges, cidr block defintion, and wildcards
                // and then turns the IP address into a 12 digit number.
                text = text.replace(/-[0-9.\/]*/, '')
                           .replace(/\*/g, 255)
                           .replace(/\/[0-9.\/]*/g, '');

                // A tiny bit of IPv6 handling. If the string has a : then it is v6.
                // Otherwise v4.
                if (text.indexOf(":") !== -1) {
                    text = text.toLowerCase()
                               .replace(/(^|:)([0-9a-f])($|:)/g,                 "$1000$2$3")
                               .replace(/(^|:)([0-9a-f][0-9a-f])($|:)/g,         "$100$2$3")
                               .replace(/(^|:)([0-9a-f][0-9a-f][0-9a-f])($|:)/g, "$10$2$3")
                               .toLowerCase();
                    // An IPv6 address can contain the string ::
                    // This indicates any number of zeros, and will be expanded
                    // such that the address then has 128 bits (aka 32 chars)
                    if (text.indexOf("::") !== -1) {
                        // This will work on strings like ::1 and 1::
                        split = text.split("::", 2);
                        // The :: can hide any number of internal :s so have to strip
                        // them from the individual splits to make this easy.
                        split[0] = split[0].replace(/:/g, "");
                        split[1] = split[1].replace(/:/g, "");
                        // http://stackoverflow.com/questions/1877475/repeat-character-n-times
                        chars = 32 - (split[0].length + split[1].length);
                        (joiner = []).length = chars + 1;
                        text = split[0] + (joiner.join("0")) + split[1];
                    } else {
                        text = text.replace(/:/g, "");
                    }
                } else {
                    text = text.replace(/(^|\.)(\d)(?:$|(?=\.))/g,   "$100$2")
                               .replace(/(^|\.)(\d\d)(?:$|(?=\.))/g, "$10$2")
                               .replace(/\./g, "");
                }
            } else {
                text = $(node).text();
            }
            return text;
        },
        update : function () {
            $(this).each(function () {
                $(this).trigger('update');
            });
        }
    };

    $.fn.tableSortingPaging = function (method) {

        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        }
        if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
        $.error('Method ' +  method + ' does not exist on jQuery.tableSortingPaging');
    };

}(jQuery));

// Seralize page size value to session cookie
function serialize_page_size(value) {
    "use strict";
    jQuery.cookie('pagination_per_page', value, { path : '/' });
}
