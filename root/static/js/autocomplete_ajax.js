/**
 * jQueryUI autocomplete using AJAX requests to JSON endpoint with optional result_limit 
 * Requires multilevel_combobox.js
 *
 * $Id$
 */

/* Don't conflict $ */
(function( $ ) {
    
    var data_prefix = "__autocomplete";

    var methods = {
        init : function( extra_search_options ) {

            $(this).data( data_prefix + "extra_search_options", extra_search_options );
            $(this).data( data_prefix + "result_limit", $(this).attr('data-result-limit'));
            $(this).data( data_prefix + "url", $(this).attr('data-url'));
            $(this).data( data_prefix + "response_cache", {});
            $(this).data( data_prefix + "term_cache", []);
            $(this).data( data_prefix + "json_data", {});

            // enable multilevel combobox functionality on this element
            $(this).multilevel_combobox({
                minLength: 3,
                delay: 800,
                source : function(request, response_callback){
                    if ( $(this.element).data( data_prefix + "response_cache" )[request.term] == undefined ){ 
                        methods.get_json_data($(this.element), request.term, response_callback);
                    }else{
                        response_callback($(this.element).data( data_prefix + "response_cache" )[request.term]);
                    }
                }
            });
        },
        get_json_data : function (element, q, response_callback){
            var search_data = {
                q : q,
                result_limit : $(element).data( data_prefix + "result_limit" )
            };
            
            for ( var opt in $(element).data( data_prefix + "extra_search_options" ) ){
                search_data[opt] = $(element).data( data_prefix + "extra_search_options" )[opt];
            }
            
            $.ajax({
                dataType: "json",
                data: search_data,
                processData: true,
                async: true,
                url: $(element).data( data_prefix + "url" ),
                success: function(data, textStatus, jqXHR) { 
                    methods.handle_json_data(element, data, search_data, response_callback); 
                }
            });

        },

        handle_json_data : function (element, json_data, search_data, response_callback){

            // If the limit has been exceeded, give the user the option to view anyway.
            if ( parseInt(json_data.result_count) > parseInt($(element).data( data_prefix + "result_limit" )) ){
                if ( !confirm(json_data.result_count + " matches found.\nDo you wish to view them?") ){
                    response_callback();
                    return;
                }else{
                    search_data.result_limit = 0;

                    $.ajax({
                        dataType: "json",
                        data: search_data,
                        processData: true,
                        async: true,
                        url: $(element).data( data_prefix + "url" ),
                        success: function(data, textStatus, jqXHR) { 
                            methods.display_json_data(element, data, response_callback);
                        }
                    });
                }
            }else{
                methods.display_json_data(element, json_data, response_callback);
            }
        },

        display_json_data : function (element, json_data, response_callback){
            // if there's already 5 items in the cache, clear the first one.
            if ( $(element).data( data_prefix + "term_cache" ).length >= 5 ){
                $(element).data( data_prefix + "term_cache" , term_cache.slice(1));
                $(element).data( data_prefix + "response_cache" )[data.q] = undefined;
            }

            // Push these results onto cache.
            $(element).data( data_prefix + "term_cache" ).push(json_data.q);
            $(element).data( data_prefix + "response_cache" )[json_data.q] = json_data.data;

            response_callback(json_data.data);
        }
    };
    
    
    $.fn.autocompleteAJAX = function( method ) {
        
        // Method calling logic
        if ( methods[method] ) {
            return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.autocompleteAJAX' );
        }

    };

})(jQuery);

