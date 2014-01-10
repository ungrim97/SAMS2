/**
 * Control that provides autocomplete select functionality. It is based on the JQuery UI autocomplete
 * control, but adds a separate hidden field that is set to the value of the selected option, rather
 * than setting the value of the control that the widget was applied to. In this sense the control
 * behaves more like a select control.
 * The selected value is set in a hidden input control named <controName>_value.
 * The control accepts the same options as the JQuery UI autocomplete control that it is based upon.
 * A clear button (marked as 'x') is displayed towards the right hand side of the control which clears
 * the currently selected value. If the control contents are changed without an item being selected 
 * from the list then the <controlName>_value field is set to an empty string.
 */

/* Don't conflict $ */
(function( $ ) {

    $.widget( "ui.combobox", $.ui.autocomplete, {
        options: {
            change: function(event, ui) {
                var element_id = event.target.id;
                $('#' + element_id + '_value').val('');
            },
	        select: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_value').val(ui.item.value);
                // Trigger change event on changed hidden fields.
                $('#' + element_id + '_value').trigger('change');
	            return false;
            },
	        focus: function(event, ui) {
    	        $(event.target).val(ui.item.label);
                var element_id = event.target.id;
                $('#' + element_id + '_value').val(ui.item.value);
                // Trigger change event on changed hidden fields.
                $('#' + element_id + '_value').trigger('change');
	            return false;
            }
        },
        _create: function() {
            $.ui.autocomplete.prototype._create.call(this);

            // Wrap the widget in a div for positioning the clear button.
            this.element.wrap('<div />');
            this.element.parent('div').css({'position': 'relative', 'float': 'left'});

            // Add hidden fields for value
            $( '<input type="hidden" />' )
                .attr('name', this.element[0].name + '_value')
                .attr('id', this.element[0].id + '_value')
                .insertAfter(this.element);

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
                        // Trigger change event on changed hidden fields.
                        $('#' + element_id + '_value').trigger('change');
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
        }
    } );

})(jQuery);
