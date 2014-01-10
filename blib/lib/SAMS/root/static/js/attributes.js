(function ($) {
    "use strict";
    // Good practice.
    // See http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it
    // Or  http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/
    var enable_attributes;

    enable_attributes = function (attribute_container) {
        var template, disable_button, enable_button, update_element_id,
            get_group_number, get_group, get_attribute_number, get_attribute,
            create_attribute, delete_attribute, update_attribute, renumber_attributes, check_attribute_name,
            create_group, delete_group, update_group, renumber_groups;

        // A really simple templating 'language'.
        // Was inspired by http://api.jquery.com/template-tag-html/
        // but don't want to use a beta plugin on SAMS.
        template = function (id, values) {
            var html, key;

            html = attribute_container.find('#' + id).html();
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

        // This disables the button, restoring any css classes relating to looking
        // disabled.
        disable_button = function (button) {
            button.attr('disabled', true);
            button.addClass('ui-button-disabled ui-state-disabled');
        }

        // This enables the button, as well as removing any classes which may make
        // it appear disabled.
        enable_button = function (button) {
            button.removeAttr('disabled');
            button.removeClass('ui-button-disabled ui-state-disabled');

            button.unbind();
            // IBI-141 : There is an event attached to the button by some other javascript that swallows tabs.
            // Unbinding the handlers directly attached to this does not appear to break anything, and it restores
            // correct tab behaviour. Very odd.
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

        // This will get the group number for the node passed in.
        // The node does not have to be the containing group div,
        // it can be any node within a group.
        get_group_number = function (node) {
            return parseInt(node.closest('fieldset.group').attr('id').replace('group_', ''), 10);
        };

        // Gets the group jQuery object.
        // Doing this allows for a very precise specifier.
        get_group = function (group_number) {
            return attribute_container.find('fieldset.group#group_' + group_number);
        };

        // This will get the attribute number for the node passed in.
        get_attribute_number = function (node) {
            return parseInt(node.closest('li.attribute').attr('id').replace(/attribute_\d+_/, ''), 10);
        };

        // Gets the attribute jQuery object.
        // Doing this allows for a very precise specifier.
        get_attribute = function (group_number, attribute_number) {
            return attribute_container.find('fieldset.group#group_' + group_number +
                        ' li.attribute#attribute_' + group_number + '_' + attribute_number);
        };

        // Creates a new blank attribute key value pair in the specified group
        create_attribute = function (group_number) {
            var group, attribute_number, html;

            group = get_group(group_number);
            attribute_number = group.find('li').length + 1;

            html = template('attribute_template', { 'group_id': group_number, 'attribute_id': attribute_number });
            group.find('ul').append(html);
        };
        // Deletes an attribute key value pair
        delete_attribute = function (group_number, attribute_number) {
            get_attribute(group_number, attribute_number).remove();
        };
        // Updates the attribute key value pair to have a delete button.
        // Will happen when the group becomes a named group.
        update_attribute = function (group_number, attribute_number) {
            enable_button(get_attribute(group_number, attribute_number).find('input:button'));
        };
        // Called after deleting an attribute, this will reduce the number of each attribute
        // that follows it to keep the numbering consistent. Do not just call this at any time
        // - it will not do anything fancy to detect other gaps.
        renumber_attributes = function (group_number, attribute_number) {
            var group;

            /*jslint unparam: true*/
            // The index parameter is unused.
            group = get_group(group_number);
            group.find('li.attribute').filter(function () {
                return get_attribute_number($(this)) > attribute_number;
            }).each(function (index, element) {
                var current_attribute_number, new_attribute_number;

                current_attribute_number = get_attribute_number($(element));
                new_attribute_number = current_attribute_number - 1;

                $(element).find('span').text(new_attribute_number);
                update_element_id($(element), 'attribute_' + group_number + '_' + new_attribute_number);
                $.each([ 'attribute_name_' + group_number + '_', 'attribute_value_' + group_number + '_' ], function (index, value) {
                    var old_id, new_id;

                    old_id = value + current_attribute_number;
                    new_id = value + new_attribute_number;

                    update_element_id($(element).find('#' + old_id), new_id);
                    update_element_id($(element).find('label[for="' + old_id + '"]'), new_id);
                });
            });
            /*jslint unparam: false*/
        };

        // This takes the name input field of the attribute and looks for duplicates
        // within the same group. Duplicates will be highlighted because they cannot
        // all be saved.
        // This will also clear warnings from attributes which have been renamed to be
        // unique.
        check_attribute_name = function (attribute) {
            var group, list;

            group = attribute.parents('fieldset.group');
            list = group.find('input.name[value="' + attribute.val() + '"]');

            if (list.length > 1) {
                // This has become a duplicate, or remains one
                list.addClass('warning');
            } else if (attribute.hasClass('warning')) {
                // This is no longer a duplicate, but was one.
                // When this happens need to find the other attributes
                // that have warnings to clear them, if appropriate.
                attribute.removeClass('warning');

                /*jslint unparam: true*/
                // The index parameter is unused.
                group.find('input.name.warning').each(function (index, element) {
                    if (group.find('input.name[value="' + $(element).val() + '"]').length === 1) {
                        $(element).removeClass('warning');
                    }
                });
                /*jslint unparam: false*/
            }
        };

        // Creates a new blank group at the bottom of the list.
        // This will contain a single attribute key value pair.
        create_group = function () {
            var group_number, html;

            group_number = $('fieldset.group').length + 1;

            html = template('group_template', { 'group_id': group_number, 'name': 'New Group' });
            if ($('fieldset.group').length) {
                $('fieldset.group').last().after(html);
            } else {
                $('h4:contains("Account Attributes")').after(html);
            }

            create_attribute(group_number);
        };
        // Deletes the group and all contained attributes.
        delete_group = function (group_number) {
            get_group(group_number).remove();
        };
        // Updates the group to have a name, and new attribute / delete group
        // buttons. The attributes contained within will also be updated.
        update_group = function (group_number) {
            var group;

            group = get_group(group_number);
            group.find('legend').text('Group ' + group_number);
            if (group.find('li.attribute').last().find('input:text[value!=""]').length) {
                enable_button(group.find('input:button.new_attribute'));
            }
            enable_button(group.find('input:button.delete_group'));
        };
        // Called after deleting a group, this will reduce the number of each group
        // that follows it to keep the numbering consistent. Do not just call this at any time
        // - it will not do anything fancy to detect other gaps.
        renumber_groups = function (group_number) {
            /*jslint unparam: true*/
            // The index parameter is unused.
            $('fieldset.group').filter(function () {
                return get_group_number($(this)) > group_number;
            }).each(function (index, element) {
                var current_group_number, new_group_number;

                current_group_number = get_group_number($(element));
                new_group_number = current_group_number - 1;

                if ($(element).find('legend').text() !== 'New Group') {
                    $(element).find('legend').text('Group ' + new_group_number);
                }
                update_element_id($(element), 'group_' + new_group_number);
                $(element).find('li.attribute').each(function (index, attribute) {
                    var attribute_number;

                    attribute_number = get_attribute_number($(attribute));
                    update_element_id($(attribute), 'attribute_' + new_group_number + '_' + attribute_number);

                    $.each([ 'attribute_name_', 'attribute_value_' ], function (index, value) {
                        var old_id, new_id;

                        old_id = value + current_group_number + '_' + attribute_number;
                        new_id = value + new_group_number + '_' + attribute_number;

                        update_element_id($(element).find('#' + old_id), new_id);
                        update_element_id($(element).find('label[for="' + old_id + '"]'), new_id);
                    });
                });
            });
            /*jslint unparam: false*/
        };

        // All of the button events are handled here.
        // Remember the click event is only fired for enabled buttons.
        attribute_container.delegate('fieldset.group li.attribute input:button',
                                     'click', function () {
            var group_number, attribute_number;

            if ($(this).is(':disabled')) {
                return;
            }

            group_number = get_group_number($(this));
            attribute_number = get_attribute_number($(this));

            delete_attribute(group_number, attribute_number);
            renumber_attributes(group_number, attribute_number);
        });
        attribute_container.delegate('fieldset.group input:button.new_attribute',
                                     'click', function () {
            if ($(this).is(':disabled')) {
                return;
            }

            create_attribute(get_group_number($(this)));
            disable_button($(this));
        });
        attribute_container.delegate('fieldset.group input:button.delete_group',
                                     'click', function () {
            var group_number;

            if ($(this).is(':disabled')) {
                return;
            }

            group_number = get_group_number($(this));

            delete_group(group_number);
            renumber_groups(group_number);

            // Always make sure there is at least one group
            if ($('fieldset.group').length === 0) {
                create_group();
            }
        });

        // This enables the attributes and groups as appropriate.
        // The data entry 'enabled' is used to see if the element has already been enabled.
        attribute_container.delegate('fieldset.group input:text',
                                     'change', function () {
            var attribute_number, group_number;

            attribute_number = get_attribute_number($(this));
            group_number = get_group_number($(this));

            update_group(group_number); // update new attribute button
            if (!get_group(group_number).data('enabled')) {
                create_group(); // you do not create groups manually, instead there is always one unused one
                get_group(group_number).data('enabled', true);
            }
            if (!get_attribute(group_number, attribute_number).data('enabled')) {
                update_attribute(group_number, attribute_number);
                get_attribute(group_number, attribute_number).data('enabled', true);
            }
            if ($(this).hasClass('name')) {
                check_attribute_name($(this));
            }
        });

        // Checks any existing values to enable the appropriate buttons.
        // When the page is loaded the groups and attributes will be created
        // with values, but all buttons will be disabled.
        // Obviously, should there be a database attribute entry with an empty
        // name and value then this will treat it as no value at all. I don't
        // think that is broken.
        /*jslint unparam: true*/
        // The index parameter is unused.
        attribute_container.find('input:text').each(function (index, element) {
            var attribute_number, group_number;

            if (!$(element).val()) {
                return;
            }
            attribute_number = get_attribute_number($(element));
            group_number = get_group_number($(element));

            if (!get_group(group_number).data('enabled')) {
                update_group(group_number);
                get_group(group_number).data('enabled', true);
            }
            if (!get_attribute(group_number, attribute_number).data('enabled')) {
                update_attribute(group_number, attribute_number);
                get_attribute(group_number, attribute_number).data('enabled', true);
            }
        });
        /*jslint unparam: false*/
    };

    $.fn.enableAttributes = function () {
        var attribute_container = $(this);
        $(document).ready(function () {
            enable_attributes(attribute_container);
        });
    };
}(jQuery));
