/*global document, jQuery */
(function ($) {
    "use strict";
    // Good practice.
    // See http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it
    // Or  http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/

    var expand_server, collapse_server, disable_edit, enable_edit,
        add_server, edit_server, save_server, delete_server;

    // Expands the server to show the editable fields.
    expand_server = function (server) {
        server.find('.long').removeClass('hidden');
        server.find('.short').addClass('hidden');
    };

    // Collapse the server to just the name.
    collapse_server = function (server) {
        server.find('.long').addClass('hidden');
        server.find('.short').removeClass('hidden');
    };

    // Disables the edit button on all the servers. Only one server can be
    // edited at any one time. That server will already be expanded (so no need
    // for edit button).
    // This also disables the add button, as that triggers editing of the added
    // server.
    disable_edit = function () {
        $('.oauth_client_server .short input:button, .oauth input:button.addbtn')
            .attr('disabled', 'disabled')
            .addClass('ui-button-disabled')
            .addClass('ui-state-disabled');
    };

    enable_edit = function () {
        $('.oauth_client_server .short input:button, .oauth input:button.addbtn')
            .removeAttr('disabled')
            .removeClass('ui-button-disabled')
            .removeClass('ui-state-disabled');
    };

    // Called when the add button is clicked. This should add the server and
    // expand it to allow it to be edited.
    add_server = function () {
        var button;

        button = $(this).closest('.button-wrapper');
        button.before($('body.oauth #oauth_client_server_template').html());

        disable_edit();
        expand_server($('body.oauth .oauth_client_server').last());
    };

    // Called when the edit button is clicked. This should expand the selected
    // server. This should also collapse all other servers and make sure that
    // the edit buttons on them are not useable.
    edit_server = function () {
        var server = $(this).closest('.oauth_client_server');

        disable_edit();
        expand_server(server);
    };

    // Called when the save button is clicked. This should call the
    // ajax_widgets/save_oauth_server.json endpoint with the details.
    save_server = function () {
        var server, id, name, image_url, data;

        server = $(this).closest('.oauth_client_server');
        id = server.find('input[name="real-id"]').val();
        name = server.find('select[name="server_id"]').val();
        image_url = server.find('input[name="image_url"]').val();

        data = {
            'oauth_client_server_id': name,
            'image_url': image_url,
            'client_id':
                server.find('input[name="client_id"]').val(),
            'client_secret':
                server.find('input[name="client_secret"]').val()
        };
        if (id) {
            data.id = id;
        }

        $.ajax({
            url: "/ajax_widgets/update_oauth_client_server.json",
            data: data,
            success: function (data, textStatus, jqXHR) {
                if (data.problems !== '') {
                    alert("Update failed: " + data.problems);
                } else {
                    server.find('div.short div.name').text(name);
                    server.find('div.image img').attr('src', image_url);
                    collapse_server(server);
                }
            }
        });
        enable_edit();
    };

    // Called when the delete button is clicked. This should call the
    // ajax_widgets/delete_oauth_client_server.json endpoint with the details,
    // as well as removing the row when the request is complete.
    delete_server = function () {
        var server, id;

        server = $(this).closest('.oauth_client_server');
        id = server.find('input[name="real-id"]').val();

        if (id) {
            $.ajax({
                url: "/ajax_widgets/delete_oauth_client_server.json",
                data: {'id': id},
                success: function (data, textStatus, jqXHR) {
                    if (data.problems !== '') {
                        alert("Deletion failed: " + data.problems);
                    } else {
                        server.remove();
                    }
                }
            });
        } else {
            server.remove();
        }

        enable_edit();
    };

    $(document).ready(function () {
        $('.oauth').delegate(
            'input:button.addbtn',
            'click',
            add_server
        );
        $('.oauth').delegate(
            'input:button.editbtn',
            'click',
            edit_server
        );
        $('.oauth').delegate(
            'input:button.savebtn',
            'click',
            save_server
        );
        $('.oauth').delegate(
            'input:button.delbtn',
            'click',
            delete_server
        );
    });
}(jQuery));
