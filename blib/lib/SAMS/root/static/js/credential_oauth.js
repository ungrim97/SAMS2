/*global document, jQuery */
(function ($) {
    "use strict";
    // Good practice.
    // See http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it
    // Or  http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/

    $(document).ready(function () {
        $('#oauth #oauth_table .credential').delegate('input:button', 'click', function () {
            var row, id;

            row = $(this).closest('.credential');
            id = row.attr('data-id');
            $.ajax({
                url: "/ajax_widgets/delete_credential_oauth.json",
                data: {'credential_oauth_id': id},
                success: function (data, textStatus, jqXHR) {
                    row.remove();
                }
            });
        });
    });
}(jQuery));
