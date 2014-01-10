/**
 * Multilevel Combobox
 * Displays items by category.
 * Requires the "source" data element to be set to a JSON structure containing:
 * { label: "Label displayed", value: aValue, category: itsCategory }
 * If the "value" and "category" data elements are set then these control the initial
 * value of the control.
 *
 * $Id$
 */

/* Don't conflict $ */
(function( $ ) {

    $.widget( "ui.multilevel_combobox", $.ui.autocomplete, {
        options: {
            source: function(request, response_callback) {
                var suggestion_condition = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                var data_source = this.element.data('source');
                var suggestions = new Array();
                for (var index in data_source) {
                    var data_item = data_source[ index ];
                    if (suggestion_condition.test(data_item.label)) {
                        suggestions.push(data_item);
                    }
                }
                response_callback(suggestions);
            },
	        select: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_value').val(ui.item.value);
                $('#' + element_id + '_category').val(ui.item.category);
                // Trigger change event on changed hidden fields.
                $('#' + element_id + '_value').trigger('change');
                $('#' + element_id + '_category').trigger('change');
	            return false;
            },
	        focus: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_value').val(ui.item.value);
                $('#' + element_id + '_category').val(ui.item.category);
                // Trigger change event on changed hidden fields.
                $('#' + element_id + '_value').trigger('change');
                $('#' + element_id + '_category').trigger('change');
	            return false;
            },
            minLength: 0
        },

        _create: function() {
            // call super protoclassything
            $.ui.autocomplete.prototype._create.call(this);
            // add event handler to show all options when field gets focus, content changes or mouse is clicked in field
            $(this.element).bind('mousedown', { element: this.element }, function(event) {
                    // show all items matching contents of input field
                    event.data.element.multilevel_combobox("search", event.target.value);
                });
            // set initial label if value and category data items are set
            var widget_value = this.element.data('value');
            var widget_category = this.element.data('category');
            if (widget_value != '' && widget_category != '') {
                var data_source = this.element.data('source');
                for (var index in data_source) {
                    var data_item = data_source[ index ];
                    if (data_item.value == widget_value && data_item.category == widget_category) {
                        this.element.val(data_item.label);
                    }
                }
            }

            // Wrap the widget in a div for positioning the clear button.
            this.element.wrap('<div />');
            this.element.parent('div').css({'position': 'relative', 'float': 'left'});

            // Add hidden fields for value and category.
            $( '<input type="hidden" />' )
                .attr('name', this.element[0].name + '_value')
                .attr('id', this.element[0].id + '_value')
                .insertAfter(this.element);
            $( '<input type="hidden" />' )
                .attr('name', this.element[0].name + '_category')
                .attr('id', this.element[0].id + '_category')
                .insertAfter(this.element);

            // If defaults have been set then update the *_value and *_category hidden fields.
            if (widget_value != '' && widget_category != '') {
                var element_id = this.element[0].id;
                $('#' + element_id + '_value').val(widget_value);
                $('#' + element_id + '_category').val(widget_category);
                // Trigger change event on changed hidden fields.
                $('#' + element_id + '_value').trigger('change');
                $('#' + element_id + '_category').trigger('change');
            }

            // Add clear button
            var clear_button = $('<span class="ui-icon ui-icon-closethick" style="background-color:white"></span>')
                .attr('name', this.element[0].name + '_clear')
                .attr('id', this.element[0].id + '_clear')
                .css({'position': 'absolute', 'right': '7px'})
                .bind('click', { element: this.element }, function(event) {
                        event.data.element.val('');
                        event.data.element.focus();
                        var element_id = event.data.element[0].id;
                        $('#' + element_id + '_value').val('');
                        $('#' + element_id + '_category').val('');
                        // Trigger change event on changed hidden fields.
                        $('#' + element_id + '_value').trigger('change');
                        $('#' + element_id + '_category').trigger('change');
                        $('#' + element_id ).trigger('mousedown');
                    })
                .insertAfter(this.element);
            // and calculate vertical position.
            var widget_height = this.element.innerHeight();
            var button_height = 16;
            var offset_top = 5.5;
            if (button_height < widget_height) {
                offset_top = ( ( widget_height - button_height ) / 2 );
            }
            clear_button.css('margin-top', this.element.css('margin-top'));
            clear_button.css('top', offset_top + 'px');

        },

        _renderMenu: function( ul, items ) {
	        var self = this,
    	    currentCategory = "";
	        $.each( items, function( index, item ) {
	            if ( item.category != currentCategory ) {
	                ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
                    currentCategory = item.category;
                }
	            self._renderItem( ul, item );
            });
	    }
    } );

})(jQuery);

