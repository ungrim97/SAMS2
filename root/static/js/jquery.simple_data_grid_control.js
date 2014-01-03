/**
 * jquery.grid_control:
 * A simple data grid control.
 * $Id$
 * @author: Simon Rees
 */

( function( $ ) {

    $.fn.simpleDataGridControl = function( config ) {

        return this.each( function() {
            // Check config
            var required_properties = [ 'headingHTML', 'rowHTML', 'variables', 'deleteRowButtonClass', 'addRowButtonClass' ];
            for ( var i = 0; i < required_properties.length; i ++ ) {
                if ( ! config[ required_properties[i] ] ) {
                    throw new Error( "configuration doesn't contain " + required_properties[i] + " property" );
                }
            }
            // Initialise rowCounter
            config.rowCounter = 0;
            // Attach config to element (which should be a table)
            $(this).data( 'simpleDataGridControl.config', config );
            // Create heading row
            $( 'thead', this ).append( '<tr></tr>' );
            $( 'thead tr', this ).append( config.headingHTML );
            // Set up add button(s)
            var table = this;
            $( '.' + config.addRowButtonClass ).bind( 'click', { table: table }, function() {
                $(table).simpleDataGridControlAppendRow();
            } );

        } );
    }

	$.fn.simpleDataGridControlstripeRows = function() {
		return this.each( function() {
			$( 'tbody', this ).find( 'tr:even' )
				.addClass( 'highlight' )
			.end().find( 'tr:odd' )
				.removeClass( 'highlight' )
			.end();
		} );
	}

    $.fn.simpleDataGridControlAppendRow = function( data ) {
        return this.each( function() {
            $(this).closest('table').show();
            var config = $(this).data( 'simpleDataGridControl.config' );
            config.rowCounter ++;
            // Create a row in the tbody element
            $( 'tbody', this ).append( '<tr>' + config.rowHTML + '</tr>' );
            for ( var i = 0; i < config.variables.length; i ++ ) {
                var variableName = config.variables[i];
                var control = $( 'tbody tr:last td .' + variableName, this );
                // If at least one control was found, set up the name and possibly the id and value.
                if ( control ) {
                    var controlName = variableName + '[' + config.rowCounter + ']';
                    $(control).attr( 'name', controlName );
                    // Only set id if there is only one instance of the class in this row.
                    if ( control.size() == 1 ) {
                        $(control).attr( 'id', controlName );
                    }
					// Set the control's value if supplied data for it.
                    if ( data && data[variableName] ) {
                        setControlData( control, data[variableName] );
                    }
                    else {
                        setControlData( control, '' );
                    }
                }
                else {
                    // warn that no control could be found
                    // would like to send a warning to the console here
                    // Maybe it would be better to check the variables have matching controls when the table is set up.
                }
            }
            // Stripe the rows
			$( this ).simpleDataGridControlstripeRows();
            // Set up delete button handler
            var deleteButton = $( 'tbody tr:last td .' + config.deleteRowButtonClass, this );
            deleteButton.bind( 'click', function() {
                // Locate parent table before removing the tr for use in the stripeRows call.
				var parentTable = $( this ).parentsUntil( 'table' ).parent( 'table' );
                $( this ).parentsUntil( 'tbody' ).filter( 'tr' ).remove();
                if ( parentTable.children('tbody').children('tr').length == 0 ) {
                    parentTable.hide();
                }
		parentTable.simpleDataGridControlstripeRows();
            } );
        } );

		/*
		 * Sets control to value using whatever technique the weirdnesses of html require.
		 * Currently supports the following control types:
		 * text input
		 * hidden input
		 * checkbox
		 * single select list
		 */
        function setControlData( control, value ) {

            $( control ).filter( 'input:text' ).attr( 'value', value );
            $( control ).filter( 'input:hidden' ).attr( 'value', value );
            $( control ).filter( 'input:checkbox' ).attr( 'checked', ( value ? 'checked' : '' ) );
            // Only works for single select controls
			$( control ).filter( 'select' ).attr( 'selectedIndex', 
												  $( control ).filter( 'select' ).find( 'option[value="' + value + '"]' ).attr( 'index' ) 
												);
        }
    }

} ) ( jQuery );


