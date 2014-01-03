/**
 * Clearable Autocomplete control.
 * Displays items as you type. Based on autocomplete, but with added clear button.
 *
 * $Id$
 */

/* Don't conflict $ */
(function( $ ) {

    $.widget( "ui.clearable_autocomplete", $.ui.autocomplete, {
        options: {
	        select: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_val').val(ui.item.val);
            },
	        focus: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_val').val(ui.item.val);
            },
        },
        _create: function() {
            // Inherit from autocomplete prototype.
            $.ui.autocomplete.prototype._create.call(this);

            // Set up handler to show menu when user clicks into control.
            $(this.element).bind('mousedown', { element: this.element }, function(event) {
                    // show all items matching contents of input field
                    event.data.element.clearable_autocomplete("search", event.target.value);
                });

            // Add hidden field to contain the "val" value.
            var val_hidden_input = $('<input type="hidden" />')
                .attr('name', this.element[0].name + '_val')
                .attr('id', this.element[0].id + '_val')
                .insertAfter(this.element);

            // Wrap input field in a div.
            this.element.wrap('<div style="position: relative; float: left;">');

            // Add clear button
            var clear_button = $('<span class="ui-icon ui-icon-closethick" style="background-color:white"></span>')
                .attr('name', this.element[0].name + '_clear')
                .attr('id', this.element[0].id + '_clear')
                .css({'position': 'absolute', 'right': '7px'})
                .bind('click', { element: this.element, hidden_element: val_hidden_input}, function(event) {
                        event.data.element.val('');
                        event.data.hidden_element.val('');
                        event.data.element.focus();
                    })
                .insertAfter(this.element);

            // Position clear button
            var widget_height = this.element.innerHeight();
            var button_height = 16;
            var offset_top = 5.5;
            if (button_height < widget_height) {
                offset_top = ( ( widget_height - button_height ) / 2 );
            }
            clear_button.css('margin-top', this.element.css('margin-top'));
            clear_button.css('top', offset_top + 'px');

            // If default value, set this in hidden _val field
            var default_val = this.options.defaultVal;
            val_hidden_input.val(default_val);

            // If _val field has value then set control value to corresponding item
            if (val_hidden_input.val() != "") {
                var default_label;
                var index = 0;
                while (! default_label && index < this.options.source.length) {
                    if (this.options.source[index].val == val_hidden_input.val()) {
                        default_label = this.options.source[index].label;
                    }
                    index ++;
                }
            }
            if (default_label) {
                this.element.val(default_label);
            }
        }
    } );
})(jQuery);
