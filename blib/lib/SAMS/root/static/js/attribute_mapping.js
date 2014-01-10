(function ($) {
    "use strict";
    // Good practice....
    // See http://stackoverflow.com/questions/1335851/what-does-use-strict-do-in-javascript-and-what-is-the-reasoning-behind-it
    // Or  http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/
    var enable_attributes;

    enable_attributes = function (details_container, attributes_container, mapping) {
        var set_details_field_value, get_details_field_selector,
            update_details_fields, get_attribute, get_attribute_value,
            get_attribute_selector, set_attribute_value, create_attribute;

        // This sets the value of the  Details field that corresponds with the
        // selector provided.
        set_details_field_value = function (selector, value) {
            // IE9 will stringify these values to 'null' etc rather than to blank strings.
            if (value === undefined || value === null) {
                value = "";
            }

            details_container.find('input:text[name="' + selector + '"]').val(value);
        };

        // This gets the selector of the  Details field that has been passed in.
        get_details_field_selector = function (field) {
            return $(field).attr('name');
        };

        update_details_fields = function () {
            /*jslint unparam: true*/
            // The i parameter is unused.
            $.each(mapping, function (field_id, attribute_name) {
                set_details_field_value(field_id, get_attribute_value(attribute_name));
            });
            /*jslint unparam: false*/
        };

        // This gets the containing attribute for the selector provided. The containing attribute
        // is the DOM element that contains the name and value input fields.
        // If there is no appropriate attribute for this selector then this will return null.
        get_attribute = function (selector) {
            var attribute_names;

            attribute_names = attributes_container.find('.group .attribute input:text[value="' + selector + '"]');
            if (!attribute_names.length) {
                return null;
            }

            return attribute_names.first().parents('.attribute');
        };

        // This gets the value of the first attribute with a name that matches the selector
        // provided. If there is no such attribute then this will return null.
        get_attribute_value = function (selector) {
            var attribute;

            attribute = get_attribute(selector);
            if (!attribute) {
                return null;
            }
            return attribute.find('input:text[id*="_value_"]').val();
        };

        // This gets the selector of the Attribute field that has been passed in.
        // If the name of the attribute does not correspond to a valid selector then
        // this will return null.
        get_attribute_selector = function (field) {
            var name;

            name = $(field).closest('.attribute').find('input:text.name').val();
            if (mapping.hasOwnProperty(name)) {
                return name;
            }
            return null;
        };

        // This sets the value of the first attribute which has a name that matches the
        // selector provided. If this successfully updates an attribute it returns true.
        // If this cannot find an appropriate attribute to update then this returns false.
        set_attribute_value = function (selector, value) {
            var attribute;

            attribute = get_attribute(selector);
            if (!attribute) {
                return false;
            }

            attribute.find('input:text[id*="_value_"]').val(value);
            return true;
        };

        // This creates a new attribute that has a name that matches the selector provided,
        // and has a value that matches the value provided.
        create_attribute = function (selector, value) {
            var last_group;

            // This works on the implicit assumption that the last group is always blank.
            // The last group is currently always the 'New Group' group, which stops being
            // the last group when a change event fires on one of the input fields for it.
            last_group = attributes_container.find('fieldset.group').last();
            last_group.find('input:text.name').last().val(selector);
            last_group.find('input:text[id*="_value_"]').last().val(value);

            // This triggers the change event which will cause this group to stop being the
            // last group. To be doubly sure, a new blank attribute is also added to this
            // group.
            last_group.find('input:text[id*="_value_"]').last().trigger('change');
            last_group.find('input:button.new_attribute').trigger('click');
        };

        // This updates or creates the attribute associated with the  Details
        // field that has been updated.
        $.each(mapping, function (field_id, attribute_name) {
            details_container.delegate('input:text[name="' + field_id + '"]', 'change', function () {
                var selector, value;

                selector = get_details_field_selector(this);
                value = $(this).val();
                if (!set_attribute_value(selector, value)) {
                    create_attribute(selector, value);
                }
            });
        });

        // This updates the  Details field that corresponds to this attribute,
        // provided that this attribute corresponds to a  Details field.
        // This does not use the value of this, as it cannot be guarenteed to be first.
        // (cannot come up with a selector that triggers on the value when the name is :first).
        attributes_container.delegate('.group .attribute input:text[id*="_value_"]', 'change', function () {
            var selector;

            selector = get_attribute_selector(this);
            if (selector) {
                set_details_field_value(selector, get_attribute_value(selector));
            }
        });

        // This updates both  Details fields whenever the name of an attribute changes.
        // It is difficult to make this more specific without tracking old names - which seems like
        // a very brittle approach.
        attributes_container.delegate('.group .attribute input:text.name', 'change', function () {
            update_details_fields();
        });

        // This triggers an update of the  Details fields after an attribute or
        // group is deleted. There needs to be a short delay before executing the update, otherwise
        // the to-be-deleted values can still be read.
        // 100 ms is an acceptable 'instantaneous' update, see things like:
        // http://stackoverflow.com/questions/536300/what-is-the-shortest-perceivable-application-response-delay
        attributes_container.delegate('.group input:button.delete_group, input:button[value="Delete Attribute"]', 'click', function () {
            setTimeout(update_details_fields, 100);
        });

        // This is called for the case where a new entity is being created, or an
        // existing one is being edited, and an error occurs on submission.
        // When this happens the attributes tab can have the updated values, while the
        //  Details fields have the old values (or no value at all). This will
        // force the front end fields into sync with the attributes tab.
        // (This is able to clear the fields if the associated attributes have been removed).
        update_details_fields();
    };

    // This is called on the tab that has the fields that need to be mirrored to the attributes tab.
    // The attributes tab itself should be the second argument.
    // The final argument is a dict of the "from id" to the "attribute name"
    $.fn.enableAttributeMappings = function (attribute_container, mapping) {
        var details_container = $(this);
        $(document).ready(function () {
            enable_attributes(details_container, $(attribute_container), mapping);
        });
    };
}(jQuery));
