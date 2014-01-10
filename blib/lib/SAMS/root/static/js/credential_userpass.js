/*global document, jQuery */
(function ($) {
    "use strict";
    // Good practice.
    // See http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it
    // Or  http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/

    $(document).ready(function () {
        var template, update_element_id, get_table, get_credential_number,
            get_credential, create_credential, delete_credential, renumber_credentials;

        // A really simple templating 'language'.
        // Was inspired by http://api.jquery.com/template-tag-html/
        // but don't want to use a beta plugin on SAMS.
        template = function (id, values) {
            var html, key;

            html = $('div#userpasses #' + id).html();
            for (key in values) {
                // values is a hash so can't use the three argument for.
                // Still should be sure we are operating on a property and not a function or something.
                // See http://stackoverflow.com/questions/1963102/what-does-the-jslint-error-body-of-a-for-in-should-be-wrapped-in-an-if-statemen
                if (values.hasOwnProperty(key)) {
                    html = html.replace(new RegExp('{' + key + '}', 'g'), values[key]);
                }
            }

            return html;
        };

        // Will update the id of the element, along with any name or for if appropriate.
        // It is not an error to call this on something without an id - updating labels
        // will be done in this way.
        update_element_id = function (element, new_id) {
            /*jslint unparam: true*/
            // The index parameter is unused.
            $.each([ 'id', 'name', 'for' ], function (index, value) {
                if (element.attr(value)) {
                    element.attr(value, new_id);
                }
            });
            /*jslint unparam: false*/
        };

        get_table = function () {
            return $('div#userpasses table#credential_table');
        };

        // This will get the credential number for the node passed in.
        get_credential_number = function (node) {
            return parseInt(node.closest('tr.credential').attr('id').replace(/credential_/, ''), 10);
        };

        // Gets the credential jQuery object.
        // Doing this allows for a very precise specifier.
        get_credential = function (credential_number) {
            return $('div#userpasses table#credential_table tbody tr#credential_' + credential_number);
        };

        // Creates a new blank credential key value pair
        create_credential = function () {
            var credential_number, tbl, html;

            tbl = get_table();

            credential_number = tbl.find('tbody').find('tr').length + 1;

            html = template('credential_template', { 'credential_id': credential_number });

            tbl.find('tbody').append(html);
        };

        // Deletes an credential key value pair
        delete_credential = function (credential_number) {
            get_credential(credential_number).remove();
        };

        // Called after deleting a credential, this will reduce the number of each credential
        // that follows it to keep the numbering consistent. Do not just call this at any time
        // - it will not do anything fancy to detect other gaps.
        renumber_credentials = function (credential_number) {
            /*jslint unparam: true*/
            // index parameter is unused in both loops that define it
            get_table().find('tr.credential').filter(function () {
                return get_credential_number($(this)) > credential_number;
            }).each(function (index, element) {
                var current_credential_number, new_credential_number;

                current_credential_number = get_credential_number($(element));
                new_credential_number = current_credential_number - 1;

                update_element_id($(element), 'credential_' + new_credential_number);
                $.each([ 'credential_username_', 'credential_password_', 'credential_encrypted_password_', 'credential_groups_'], function (index, value) {
                    var old_id, new_id;

                    old_id = value + current_credential_number;
                    new_id = value + new_credential_number;

                    update_element_id($(element).find('#' + old_id), new_id);
                });
            });
            /*jslint unparam: false*/
        };

        // All of the button events are handled here.
        // Remember the click event is only fired for enabled buttons.
        $('div#userpasses table#credential_table').delegate('input:button[value="Delete"]', 'click', function () {
            var credential_number;

            if ($(this).is(':disabled')) {
                return;
            }

            credential_number = get_credential_number($(this));

            delete_credential(credential_number);
            renumber_credentials(credential_number);
        });

        $('div#userpasses').delegate('input:button[value="Add"]', 'click', function () {
            if ($(this).is(':disabled')) {
                return;
            }

            create_credential();
        });
    });
}(jQuery));
