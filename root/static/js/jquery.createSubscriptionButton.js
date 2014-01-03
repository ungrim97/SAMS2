/**
 * jquery.createSubscriptionButton
 * JQuery plugin to set up the create subscription button from the account screen.
 * The button is initially disabled.
 * A change handler is set up for an element #pe_id
 * When #pe_id changes the button is enabled.
 * If the form that contains the control has been changed but not saved, the user
 * is prompted as to whether they would like to discard their changes.
 * 
 * $Id$
 * @author: Simon Rees
 */

( function( $ ) {

    $.fn.createSubscriptionButton = function() {

        return this.each( function() {
            var theButton = $(this);
            // Disable the button initially
            theButton.button('disable');
            // Set up change handler for element identified by pe_id_element_id
            var pe_id_element_selector = '#' + theButton.data('pe_id_element_id');
            $(pe_id_element_selector).bind('change', {theButton: theButton}, function(event) {
                    var theButton = event.data.theButton;
                    var pe_id = $(event.target).val();
                    // enable button if a pe_id is available.
                    if ( pe_id != '') {
                        theButton.button('enable');
                        var href = new jsUri(theButton.data('base_uri'));
                        href.addQueryParam('acc_id', theButton.data('acc_id'));
                        href.addQueryParam('pe_id', pe_id);
                        theButton.attr('href', href);
                    }
                    else {
                        theButton.button('disable');
                        theButton.removeAttr('href');
                    }
                } );
        } );
    }
} ) ( jQuery );
