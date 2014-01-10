
// sams-admin.js was created by merging ams.js, admin-functions.js and admin-selectors.js
// sections are marked by // ### START ... END ...


// ### START ams.js
// @(#) $Id$

/*jslint undef: true, white: true, browser: true */


/*
 * Make the enter key always submit the form.
 * From the DHTML & Javascript cookbook:
 * http://www.webreference.com/programming/java_dhtml/chap8/2/2.html#77054
 * Attach this function to an onkeypress event handler.
 */
function submitViaEnter(evt) {
    evt = (evt) ? evt : event;
    var target = (evt.target) ? evt.target : evt.srcElement;
    var form = target.form;
    var charCode = (evt.charCode) ? evt.charCode :
                   ((evt.which)   ? evt.which    : evt.keyCode);
    if (charCode === 13 || charCode === 3) {
        form.submit();
        return false;
    }
    return true;
}

function swap_product_html(html) {
    if (document.main.site_id.value) {
        if (html) {
            document.getElementById('part2').innerHTML = html;
        } else {
            // pe_id must be initialised
            document.getElementById('part2').innerHTML =
            '<input type="hidden" name="pe_id" value="' + document.main.site_id.value + '" />';
        }
    } else {
        document.getElementById('part2').innerHTML = '';
    }
}

function check_subs_contact() {

    if ( ! document.getElementById( 'contact_acc_id' ) ) {

        if (!document.getElementById('contact_name').value) {
            alert("Please enter a contact surname.");
            return false;
        }
        if (!document.main.email.value) {
            alert("Please enter an email address");
            return false;
        }
        if (! document.getElementById('country_id').value) {
            alert("Please choose a country");
            return false;
        }
    }
}

function check_subs_details() {
    if (document.main.site_id && ! document.main.site_id.value) {
        alert("Please choose a site.");
        return false;
    }
    if ($("input[name=pe_id]:checked") || $("input[type=hidden]").value) {
        alert("There is a product.");
        return false;
    }else{
        alert("There is NO PRODUCT");
        return false;
    }
    if (!document.main.subscription_type_id.value) {
        alert("Please choose a Subscription type");
        return false;
    }
    if (!document.main.status.value) {
        alert("Please choose a Status");
        return false;
    }
    if (!document.main.concurrency.value) {
        alert("please enter a concurrency");
        return false;
    }

    return true;
}

function toggle_all() {
    var bool;
    // force an array if only one content_unit_id
    if  (! document.main.content_unit_id.length) {
        bool = document.main.content_unit_id.checked === true ? 'false' : 'true';
        document.main.content_unit_id.checked = bool;
        document.main.toggle.value = document.main.content_unit_id.checked ? 'Deselect all' : 'Select all';
    } else {
        bool = document.main.content_unit_id[0].checked === true ? 'false' : 'true';
        var mylength = document.main.content_unit_id.length;
        for (var i = 0; i < mylength; i++) {
            document.main.content_unit_id[i].checked = bool;
        }
        document.main.toggle.value = document.main.content_unit_id[0].checked ? 'Deselect all' : 'Select all';
    }
}

function replace_organisation(acc_id, name, existing) {
    if (existing) {
        document.getElementById('organisation').innerHTML = '<b>Existing organisation</b> ' + name;
        document.getElementById('account').className = 'greyed';
    } else {
        document.getElementById('organisation').innerHTML = '<b>Customer-supplied organisation</b> ' + name;
        document.getElementById('account').className = 'd';
    }
    document.main.overridden_acc_id.value = acc_id;
}

function reset_override() {
    document.main.overridden_acc_id.value = '';
}

function check_required_fields() {
    var foundempty = 0;
    for (var i = 0; i < arguments.length; i++) {
        var isundef = 0;
        if (document.main[arguments[i]] === undefined) {
            isundef++;
        }
        // if the field doesn't appear on the page, don't validate it
        if (isundef) {
            continue;
        }
        var myval = document.main[arguments[i]].value;
        if (! myval) {
            alert("Please fill in the required fields (" + arguments[i] + ")");
            foundempty++;
            break;
        }
    }
    return foundempty ? false : true;
}

function check_ips() {
    // dont' check if not present on form
    if (document.main.allowed_ips === undefined) {
        return true;
    }

    var input = document.main.allowed_ips.value;

    var lines = input.split(/[\n\r]/);
    for (var i = 0; i < lines.length; i++) {
        if (lines[i] !== '' && !isValidIP(lines[i])) {
            return false;
        }
    }
    return true;
}

function check_userpass() {
    // dont' check if not present on form
    if (document.main.userpass === undefined) {
        return true;
    }
    var input = document.main.userpass.value;
    var lines = input.split(/[\n\r]/);
    for (var i = 0; i < lines.length; i++) {
        if (lines[i] !== '' && ! isValidUserpass(lines[i])) {
            return false;
        }
    }
    return true;
}

function isValidUserpass(input) {
    var re = /\//;
    if (re.test(input)) {
        // contains /
        var inputparts = input.split(re);
        if (inputparts[0].length < 6 || inputparts[1].length < 6) {
            alert(input + " : Username and password must be at least 7 characters");
            return false;
        }
    } else {
        alert("Please check the format of the username field");
        return false;
    }
    return true;
}

function isValidIP(input) {
    var re = /\//;
    var inputparts;
    if (isValidIPaddressSyntax(input)) {
        // skip to range check
        inputparts[0] = input;
    } else if (re.test(input)) {
        // contains /
        inputparts = input.split(re);
        if (! (isValidIPaddressSyntax(inputparts[0]) &&
            inputparts[1] !== '' &&
            ! isNaN(inputparts[1]) &&
            inputparts[1] >= 0 &&
            inputparts[1] <= 32)) {
            alert("Ip range " + input + " has an incorrect format");
            return false;
        }
    } else {
        alert(input + " :unknown ip format");
        return false; // unknown format
    }
    // format is good
    // check the address or the range
    // does not fall within disallowed networks


    var lowerinput = '';
    var upperinput = '';
    if (inputparts[1] !== undefined && inputparts[1]) {
        // input is cidr
        lowerinput = aton(ntoa(netaddr(inputparts[0], inputparts[1])));
        upperinput = aton(ntoa(broadcast(inputparts[0], inputparts[1])));
    } else {
        // input is ip address
        lowerinput = upperinput = aton(ntoa(netaddr(inputparts[0], 32)));
    }

    // convert disallowed ranges to 32-bit numbers;
    var disallowed = [
        '10.0.0.0/8',
        '127.0.0.0/8',
        '172.16.0.0/12',
        '192.168.0.0/16',
        '224.0.0.0/3'
    ];

    for (var i = 0; i < disallowed.length; i++) {
        var disallowedparts = disallowed[i].split(re);
        var lower = aton(ntoa(netaddr(disallowedparts[0], disallowedparts[1])));
        var upper = aton(ntoa(broadcast(disallowedparts[0], disallowedparts[1])));
        // see if the disallowed range appears anywhere in the input range
        if ((lowerinput >= lower && lowerinput <= upper) ||
            (upperinput >= lower && upperinput <= upper)) {
            alert(input + " falls within a disallowed ip range (" + disallowed[i] + ")");
            return false;
        }
    }
    return true; // made it through all tests
}

function isValidIPaddressSyntax(ipaddr) {
    var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
    if (re.test(ipaddr)) {
        var parts = ipaddr.split(".");
        if (parseInt(parseFloat(parts[0]), 10) === 0) {
            return false;
        }
        for (var i = 0; i < parts.length; i++) {
            if (parseInt(parseFloat(parts[i]), 10) > 255) {
                return false;
            }
        }
        return true;
    } else {
        return false;
    }
}

function aton(ipstr) {
    var ipint = 0;
    var ipary = [];

    ipary = ipstr.split(".");
    ipint = (ipary[0] * 256 * 256 * 256) +
            (ipary[1] * 256 * 256) +
            (ipary[2] * 256) +
            (ipary[3] * 1);             // Convert to number.  Like awk...
    return ipint;
}

/*
 * Create a mask of a specified length.
 */
function mask(len) {
    var bits = 0;

    // Count up, but really work down from bit 31.
    for (var b = 0; b < len; b++) {
        bits |= (1 << (31 - b));
    }
    return bits;
}

/*
 * Return the broadcast address of a CIDR network.
 */
function broadcast(net, prefixlen) {
    var netmask = mask(prefixlen);

    return (aton(net) | ~netmask);
}

/*
 * Return the network address of a CIDR network.
 */
function netaddr(net, prefixlen) {
    var netmask = mask(prefixlen);

    return (aton(net) & netmask);
}

/*
 * Convert an Integer to an IP address string.
 */
function ntoa(ipint) {
    var ipary = [];
    var ipstr = "";

    // Use right shift with zero fill, to avoid coming out with a
    // negative number...
    ipary[0] = (ipint & 0xff000000) >>> 24;
    ipary[1] = (ipint & 0x00ff0000) >> 16;
    ipary[2] = (ipint & 0x0000ff00) >> 8;
    ipary[3] = (ipint & 0x000000ff);

    ipstr = ipary[0] + "." +
            ipary[1] + "." +
            ipary[2] + "." +
            ipary[3];
    return ipstr;
}

/* check the date is in the correct format and range */
function setDayNew(date, earliest, latest) {
    if (date.value === '') {
        return "";
    }
    var dayfield = date.value.split("/")[0];
    var monthfield = date.value.split("/")[1];
    var yearfield = date.value.split("/")[2];

    var dayearliest = earliest.value.split("/")[0];
    var monthearliest = earliest.value.split("/")[1];
    var yearearliest = earliest.value.split("/")[2];

    var daylatest = latest.value.split("/")[0];
    var monthlatest = latest.value.split("/")[1];
    var yearlatest = latest.value.split("/")[2];
    /*Yuk - two year date!! */
    if ((parseInt(yearfield, 10) > 70) && (parseInt(yearfield, 10) < 100)) {
        yearfield = 1900 + parseInt(yearfield, 10);
    } else if (parseInt(yearfield, 10) < 100) {
        yearfield = 2000 + parseInt(yearfield, 10);
    }
    /* make sure it's a proper date */
    if (parseInt(monthfield, 10) == 2 && parseInt(dayfield, 10) > 28) {
        if (isLeapYear(parseInt(yearfield, 10))) {
            dayfield = 29;
        } else {
            dayfield = 28;
        }
    }
    if (parseInt(monthfield, 10) > 12) {
        monthfield = 12;
    }
    if ((parseInt(monthfield, 10) == 4 ||
         parseInt(monthfield, 10) == 6 ||
         parseInt(monthfield, 10) == 7 ||
         parseInt(monthfield, 10) == 9 ||
         parseInt(monthfield, 10) == 11) &&
         parseInt(dayfield, 10) > 30) {
        dayfield = 30;
    } else if ((parseInt(monthfield, 10) == 1 ||
                parseInt(monthfield, 10) == 3 ||
                parseInt(monthfield, 10) == 5 ||
                parseInt(monthfield, 10) == 8 ||
                parseInt(monthfield, 10) == 10 ||
                parseInt(monthfield, 10) == 12) &&
                parseInt(dayfield, 10) > 31) {
        dayfield = 31;
    }
    /* make sure the date's not before the earliest date */
    if (parseInt(yearearliest, 10) > parseInt(yearfield, 10)) {
        yearfield = yearearliest;
        monthfield = monthearliest;
        dayfield = dayearliest;
    } else if ((parseInt(yearearliest, 10) == parseInt(yearfield, 10)) &&
               (parseInt(monthearliest, 10) > parseInt(monthfield, 10))) {
        monthfield = monthearliest;
        dayfield = dayearliest;
    } else if ((parseInt(yearearliest, 10) == parseInt(yearfield, 10)) &&
               (parseInt(monthearliest, 10) == parseInt(monthfield, 10)) &&
               (parseInt(dayearliest, 10) > parseInt(dayfield, 10))) {
        dayfield = dayearliest;
    }

    /* make sure the date's not beyond the latest date */
    if (parseInt(yearlatest, 10) < parseInt(yearfield, 10)) {
        yearfield = yearlatest;
        monthfield = monthlatest;
        dayfield = daylatest;
    } else if ((parseInt(yearlatest, 10) == parseInt(yearfield, 10)) &&
               (parseInt(monthlatest, 10) < parseInt(monthfield, 10))) {
        monthfield = monthlatest;
        dayfield = daylatest;
    } else if ((parseInt(yearlatest, 10) == parseInt(yearfield, 10)) &&
               (parseInt(monthlatest, 10) == parseInt(monthfield, 10)) &&
               (parseInt(daylatest, 10) < parseInt(dayfield, 10))) {
        dayfield = daylatest;
    }

    /* ensure the days and months are in correct format */
    if (monthfield.length < 2) {
        monthfield = 0 + monthfield;
    }
    if (dayfield.length < 2) {
        dayfield = 0 + dayfield;
    }
    date.value = dayfield + "/" + monthfield + "/" + yearfield;
    return date.value;
}

function setDay(change_what, month, year) {
    if (parseInt(month.value, 10) === 2 && parseInt(change_what.value, 10) > 28) {
        if (isLeapYear(parseInt(year.value, 10))) {
            change_what.value = 29;
        } else {
            change_what.value = 28;
        }
    }
    if ((parseInt(month.value, 10) == 4 ||
         parseInt(month.value, 10) == 6 ||
         parseInt(month.value, 10) == 9 ||
         parseInt(month.value, 10) == 11) &&
         parseInt(change_what.value, 10) > 30) {
        change_what.value = 30;
    }
}

function isLeapYear(y) {
    if (((y % 4) === 0) && (((y % 100) > 0) || ((y % 400) === 0))) {
        return true;
    } else {
        return false;
    }
}

/*
 * Used to toggle the display of sections of forms based
 * on the state of a checkbox. This is introduced for the
 * CUP version of the admin system.
 */
function toggle_block(id, state) {
    if (document.getElementById) {
        var element_style = document.getElementById(id).style;
        if (state) {
            element_style.display = "block";
        } else {
            element_style.display = "none";
        }
        return false;
    }
    return true;
}

function getkey(e) {
    if (window.event) {
        return window.event.keyCode;
    } else if (e) {
        return e.which;
    } else {
        return null;
    }
}

function goodchars(e, goods) {
    var keychar;
    var key = getkey(e);
    if (key === null) {
        return true;
    }

    // get character
    keychar = String.fromCharCode(key);
    keychar = keychar.toLowerCase();
    goods = goods.toLowerCase();

    // check goodkeys
    if (goods.indexOf(keychar) != -1) {
        return true;
    }
    // control keys
    if (key === null || key === 0 || key === 8 || key === 9 || key === 13 || key === 27) {
        return true;
    }

    return false;
}

/*
 * Turn other check boxes on or off depending on the value of this box.
 *
 * This code assumes that the input="checkbox" elements are all within
 * a parent element and that they have the ids "administrator",
 * "ipeditor" and "sslimited".
 */
function enforce_groups(myCheckbox) {
    var parentNode = myCheckbox.parentNode;
    var checkNodes, a;
    if (myCheckbox.id == "administrator" && !myCheckbox.checked) {
        // If the administrator group is unchecked then the
        // ipeditor and sslimited groups must be turned off
        checkNodes = parentNode.getElementsByTagName("input");
        for (a = 0; a < checkNodes.length; a++) {
            if (checkNodes[a].id === "ipeditor") {
                checkNodes[a].checked = false;
            }
            if (checkNodes[a].id === "sslimited") {
                checkNodes[a].checked = false;
            }
        }
    }
    else if ((myCheckbox.id == "ipeditor" || myCheckbox.id == "sslimited") && myCheckbox.checked) {
        // The administrator group needs to be turned on if
        // the ipeditor or sslimited groups are checked
        checkNodes = parentNode.getElementsByTagName("input");
        for (a = 0; a < checkNodes.length; a++) {
            if (checkNodes[a].id == "administrator") {
                checkNodes[a].checked = true;
            }
        }
    }
}

/*
 * This function checks that the password matches the
 * value in confirm password
 */
function verify_password(passwordID1, passwordID2) {
    if (document.getElementById(passwordID1).value == document.getElementById(passwordID2).value) {
        if (document.getElementById(passwordID1).value) {
            return true;
        } else {
            alert("The password cannot be blank, please enter a password");
            return false;
        }
    } else {
        alert("The passwords you typed do not match. Please retype the new password in both boxes.");
        return false;
    }
}

function track_changes(event) {
    var changedElementName = event.target.name;
    var re = /(pe_selector|pe_selector_|_delete|filter_)/;
    if ( ! re.test( changedElementName ) ) {
        $('#highlight').remove();
        if ( $('#change_indicator').length == 0 ) {
            $("<span id='change_indicator' title='Unsaved changes'>*</span>").appendTo(".pageHead:first");
        }
        window.onbeforeunload = function () { return "Are you sure you want to leave this page and discard your changes?" };  
    }
}
function clear_changes() {
    window.onbeforeunload = null;
}

/*
 * Given an element id , this will :
 * hide that element
 * disable all child input elements
 */
var input_types = ['input', 'select', 'textarea', 'radio'];

function hide_and_disable(element_id) {
    var obj = document.getElementById(element_id);
    if (obj) {
        for (var i = 0; i < input_types.length; i++) {
            var input_objs = obj.getElementsByTagName(input_types[i]);
            for (var j = 0; j < input_objs.length; j++) {
                input_objs[j].disabled = true;
            }
        }
        obj.className = 'token_hidden';
    }
}

function show_and_enable(element_id) {
    var obj = document.getElementById(element_id);
    if (obj) {
        for (var i = 0; i < input_types.length; i++) {
            var input_objs = obj.getElementsByTagName(input_types[i]);
            for (var j = 0; j < input_objs.length; j++) {
                input_objs[j].disabled = false;
            }
        }
        obj.className = 'token_visible';
    }
}

function is_saved(form) {
    if (form.changed === 1) {
        if (confirm('Save Changes?')) {
            var hidden = document.createElement('input');
            hidden.setAttribute('type', 'hidden');
            hidden.setAttribute('name', 'update');
            hidden.setAttribute('value', 'Save Changes');
            form.appendChild(hidden);
            form.submit();
            return 0;
        } else {
            //return 0 for cancel
            return 0;
        }
    }
    return 1;
}

function addLoadEvent(func) {
    var oldonload = window.onload;
    if (typeof window.onload != 'function') {
        window.onload = func;
    } else {
        window.onload = function () {
            if (oldonload) {
                oldonload();
            }
            func();
        };
    }
}

function update_group_subs(pe_id) {
    if (document.getElementById('group_subs_id_container')) {
        $("#group_subs_id_container").load("subscription_groups_by_product.html?pe_id=" + pe_id);
    }
}

function show_error(msg) {
    $('#info').html('<strong>' + msg + '<br/>&nbsp;</strong>').show();
}


/*
 * Tooltip script 
 * powered by jQuery (http://www.jquery.com)
 * 
 * written by Alen Grakalic (http://cssglobe.com)
 * 
 * for more info visit http://cssglobe.com/post/1695/easiest-tooltip-and-image-preview-using-jquery
 *
 */

this.tooltip = function(){ 
    /* CONFIG */      
    xOffset = 10;
    yOffset = 20;     
    // these 2 variable determine popup's distance from the cursor
    // you might want to adjust to get the right result      
    /* END CONFIG */     
    $(".help").hover(function(e){                                   
            this.t = this.title;
            this.title = "";                            
            $("body").append("<p id='tooltip'>"+ this.t +"</p>");
            $("#tooltip")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");     
            },
            function(){
            this.title = this.t;    
            $("#tooltip").remove();
            });  
    $("a.tooltip").mousemove(function(e){
            $("#tooltip")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px");
            });         
};

// vim: set ai et sw=4 :

// ### END ams.js; START admin-functions.js
// Functions for use in Admin Services
// Please just define functions in here, and apply them in the 
// 'admin-selectors.js' file. With meaningful names, this should 
// make it easier to understand what's going on...

jQuery.fn.hideNestedModalDiv = function ( hash, parent_modal_div_selector ) {

    hash.w.hide();
    hash.o.remove();

    if ( $.browser.msie && $.browser.version <7 ){
        $( parent_modal_div_selector ).jqmHide(); 
        $( parent_modal_div_selector ).jqmShow();
    }
}



jQuery.fn.submitAccountForm = function () {
    var hidden_update = $("<input id='save_changes' type='hidden' name='update' value='Save Changes'/>");
    $('#acc').append( hidden_update );
    $("form#acc").submit();
}

// Function to enable elements in a jqm dialog as these will be set to disabled by
// JQUI tabs. Called by the onShow callback.
var enableDialogElements = function(args) {
    // iterate over child form elements and set disabled property to false.
    args.w.find(':input').each( function(index, element) {
            element.disabled = false;
        } );
    // Show the dialog
    args.w.show();
}

initialiseSubscriptionContactDetails = function() {

    // Set up event handler
    $( 'input[type="radio"][name="contact_details_source"]' ).bind( 'click', function() {
            contactDetailsSourceControlClicked();
    });

    // Set up related account select modal dialog
    $( 'div#contact_details_source_account' ).jqm( {
        modal: true, 
        toTop: true,
        trigger: "input#select_contact_account_button",
        onShow: enableDialogElements
    });
    
    // Set up its help dialog
    $('div#contact_details_source_account_help').jqm({
        modal:      true, 
        toTop:      true,
        onHide:     function(hash){ jQuery.fn.hideNestedModalDiv( hash, 'div#contact_details_source_account') },
        trigger:    "div#contact_details_source_account div#display_contact_details_source_account_help"
    });

    // Set up dialog set button event handler
    $( 'input#set_contact_acc_id' ).bind( 'click', function() {
            var selectedValue = $( 'select#candidate_contact_details_account' ).val();
            setContactAccId( selectedValue );
            setRelatedContactAccId( selectedValue );
            setContactAccOrganisationLabel( $( 'select#candidate_contact_details_account option[value="' + selectedValue + '"]'  ).text() );
    });

    // Set enabled/disabled state of form controls depending on radio option selected.
    var selectedContactDetailsSource = $( 'input[type="radio"][name="contact_details_source"]:checked' ).val();
    changeContactDetailsFormState( selectedContactDetailsSource );
}

changeContactDetailsFormState = function( selectedContactDetailsSource ) {

    // Disable / enable relevent parts of form (these are the parts that have class contingent).
    if ( selectedContactDetailsSource == 'account' || selectedContactDetailsSource == 'related_account' ) {
        $('#subscription_contact_details .contingent').attr( 'disabled', 'disabled' );
    }
    else {
        $('#subscription_contact_details .contingent').removeAttr( 'disabled' );
    }

    if ( selectedContactDetailsSource == 'account' || selectedContactDetailsSource == 'subscription' ) {
        $( 'input#select_contact_account_button' ).attr( 'disabled', 'disabled' );
    }
    else {
        $( 'input#select_contact_account_button' ).removeAttr( 'disabled' );
    }
}

contactDetailsSourceControlClicked = function() {

    var selectedContactDetailsSource = $( 'input[type="radio"][name="contact_details_source"]:checked' ).val();

    changeContactDetailsFormState( selectedContactDetailsSource );

    // Set contact_acc_id hidden form field value
    switch ( selectedContactDetailsSource ) {
        case 'account':
            setContactAccId( $( 'input#acc_id' ).val() );
            break;

        case 'related_account':
            setContactAccId( $( 'input#related_account_id' ).val() );
            break;

        case 'subscription':
            setContactAccId( '' );
            break;
    }
}

setContactAccId = function( selectedAccountId ) {

    // Set this value in form hidden field
    $( 'input#contact_acc_id' ).val( selectedAccountId );
}

setContactAccOrganisationLabel = function( organisationName ) {

    $( 'span#organisation_name_label' ).text( organisationName );
}

setRelatedContactAccId = function( selectedAccountId ) {

    $( 'input#related_account_id' ).val( selectedAccountId );
}

navToggle = function(element, speed){
    $(element).next().toggle(speed);
    $(element).parent().toggleClass("closed");
    $(element).children('.inline_icon').toggleClass('ui-icon-triangle-1-n');
    $(element).children('.inline_icon').toggleClass('ui-icon-triangle-1-s');
    return false;
}

// Serialize menu current collapsed state to a cookie
navSerialize = function(e){
    var mnus = $.cookie('nav_state');
    var data = mnus ? mnus.split('|') : [];
    if($(e).next().is(":hidden")) {
        var ndata = [];
        for (x in data) {
            if(data[x] != e.id) ndata.push(data[x]);
        }
        data = ndata;
    } else {
        data.push(e.id);
    }
    $.cookie('nav_state', data.join('|'));
}

// when an error link is clicked, switch to that tab
jQuery.fn.setupTabSwitchOnError = function(){
    $('body.account #problems a').click(jQuery.fn.showTabForId);
}

// when a form is submitted and is deemed to be invalid, switch to that tab
jQuery.fn.setupTabSwitchOnSubmitValidate = function(){
    $('form input[type="submit"]').click( function(){

        if( typeof ( this.form.checkValidity ) != 'function') {
            return;
        }

        if ( !this.form.checkValidity() ){

            // if form is invalid, then find the first invalid element
            // and focus on it (and show the tab)
            var focussed = false;
            $( 'input[required], select[required]', $(this.form) ).each( function(){
                if ( !focussed && ! this.checkValidity()  ){
                    // find this elements parent ui-tabs-panel and show it.
                    var selector = $(this).parents(".ui-tabs-panel");
                    showTab(selector);
                    // set the focussed flag so we only focus on the first
                    // invalid input
                    focussed = true;
                    return;
                }

            });
        }
    });
}


// updates or adds a hidden form field to preserve tabs across submits
var updateShowTabField = function(event, ui) {
    // get the ID of the current tab
    var targetRef = ui.tab.toString();
    targetRef = targetRef.replace(/^.*#/, '');

    // get the form we're in
    var theTab = event.currentTarget;
    var theForm = $(theTab).closest('form');

    // add the showtab parameter to the form action
    // N.B. we don't support a pre-existing querystring in the HTML, it will be destroyed.
    var formAction = $(theForm).attr('action');
    if ( formAction.match('[?]') ) {
        // already has querystring, destroy it.
        formAction = formAction.replace(/[?].*$/, '');
    }
    formAction = formAction + '?showtab=' + targetRef;

    theForm.attr('action', formAction);
}

showTabByQueryString = function () { 
    var hrefRegex = new RegExp('[?&]showtab=([^&#]*)');
    var regexResults = hrefRegex.exec( window.location.href );
    if (regexResults && regexResults[1] != "") {
        showTab('#' + regexResults[1]);
    }
}

jQuery.fn.setupTabs = function(){

    // find items in the 'tab_wrapper' and make into tabs
    $('.tab_wrapper').tabs();

    // auto-select the results tab if there are any results 
    if($('#results').length > 0){
        $('.tab_wrapper').tabs( "option", "selected", 1);
    }

    // account form wants to preserve tab on submit
    // store the current tab in a hidden form field
    $('body.account .tab_wrapper').bind('tabsshow', updateShowTabField);

    // if a 'showtab' parameter is mentioned in the query string, use it
    showTabByQueryString();

    showTabByClassName('.ui-tabs .ui-tabs-panel');

    // switch to the relevant tab when an error message is clicked
    jQuery.fn.setupTabSwitchOnError();

    jQuery.fn.setupTabSwitchOnSubmitValidate();
}

/**
 * Causes the first tab panel that is matched by selector and 
 * has class 'showtab' to be displayed.
 */
showTabByClassName = function(selector) {
    var showTabSelector = selector + '.showtab';
    $(showTabSelector).each(function(index) {
            var tabId = $(this).attr('id');
            var tabSet = $(this).parents('.ui-tabs');
            tabSet.tabs('select', tabId);
        });
}

// shows the correct tab for an ID in the current page
jQuery.fn.showTabForId = function(){
    var selector = $(this).attr('href');
    showTab(selector);
};

/**
 * Causes the tab that contains the element specified by selector to be
 * displayed.
 */
showTab = function (selector) {
    var elToShow = $(selector);
    var panelsToShow = $(elToShow).parents(".ui-tabs-panel").andSelf().filter('.ui-tabs-panel');
    panelsToShow.each(function(i, panel){
            var panelId = $(panel).attr('id');
            var panelSelector =  "#" + panelId;
            var tabs = $(panel).parents(".tab_wrapper");
            $(tabs).tabs("select", panelSelector);
        });
}


jQuery.fn.setupDatePickers = function(){
    $('.calInput').datepicker({ "dateFormat" : "dd/mm/yy", 'changeMonth': true,
            'changeYear': true}).attr("autocomplete", "off");
    // Grab min and max date from document, restrict range of calendars
    var maxDate = $("input[name='latest_date']").val();
    if(maxDate){
        $('.calInput').datepicker("option","maxDate",maxDate);
    }
    var minDate = $("input[name='earliest_date']").val();
    if(minDate){
        $('.calInput').datepicker("option","minDate",minDate);
    }

    set_min_max_report_dates( $( 'select#period' ).val() );
    
    // Set the class on the actual datepicker div
    // so we can change it's display accordingly.
    $('.report_date').datepicker( "option", "beforeShow", 
        function(foo,bar){
            if ( $( 'select#period' ).val() == 'historical' ){
                $('#ui-datepicker-div').addClass('month_only');
            }else{
                $('#ui-datepicker-div').removeClass('month_only');
            }
        } 
    );

    // set Month only start dates to 1st
    $( "#start_date.report_date" ).datepicker( "option", "onClose",
        function(dateText, inst) {
            if ( $( 'select#period' ).val() == 'historical' ){
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, 1));
            }
        }
    );

    // set Month only end dates to last
    $( "#end_date.report_date" ).datepicker( "option", "onClose",
        function(dateText, inst) {
            if ( $( 'select#period' ).val() == 'historical' ){
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, (32 - ( new Date( year, month, 32).getDate() ) ) ));
            }
        }
    );


};

function set_min_max_report_dates( period ){
    var earliest_selector = "input[name='earliest_" + period  + "_date']";
    var latest_selector = "input[name='latest_" + period  + "_date']";

    // Grab min and max date from document, restrict range of calendars
    var minDate = $( earliest_selector ).val();

    if( minDate ){
        $('.report_date').datepicker("option","minDate",minDate);
    }
    
    var maxDate = $( latest_selector ).val();
    if(maxDate){

        // For historical report end dates, put the date to last day in month.
        if ( period == 'historical'){
            var max_date_split = maxDate.split('/');
            var maxDateObj = new Date( max_date_split[2], max_date_split[1] - 1, 
                (32 - ( new Date( max_date_split[2], max_date_split[1] - 1, 32).getDate() ) ) 
            );
            maxDate = maxDateObj.getDate() + '/' + ( maxDateObj.getMonth() + 1 ) + '/' + maxDateObj.getFullYear();
        }

        $('.report_date').datepicker("option","maxDate",maxDate);
    }

    $( "#earliest_report_date" ).html( minDate );
    $( "#latest_report_date" ).html( maxDate );

}

function change_report_dates(){
    set_min_max_report_dates( this.value );
}

function calc_pagination ( num_items, pagination_selector ){
    var number_of_pages = 1;

    if ( num_items % results_per_page ){
        number_of_pages = Math.floor( num_items / results_per_page ) + 1;
    }else{
        number_of_pages = num_items / results_per_page;
    }

    if ( number_of_pages > 1 ){
        for (var i = 1; i <= number_of_pages ; i++ ){
            var pagination = $("<strong class='search_results_page_link'>" + i + "</strong>");
            pagination.attr("page", i);
            $( pagination_selector ).append( pagination );
        }
    }

    return number_of_pages;
}


jQuery.fn.setupProductSelectors = function(){
    $('.productSelector').treeview({'animated':true, 'collapsed': true});
    $('.productSelector li:first').addClass("first");
    $('.productSelector input[name=pe_id]').click(function(){
            //deselect all site_id radios in this tree
            $(this).parents(".productSelector").find('input[name=site_id]').attr('checked', false);
            //select any parent site IDs if available
            $(this).parents("li").find('input[name=site_id]').attr('checked', true);
            });
    $('.productSelector input[name=site_id]').parent().click(function(){
            //deselect all products when selecting a different site
            $(this).parents("li.expandable").find(".hitarea").click();
            //deselect all products when selecting a different site
            $(this).parents(".productSelector").find('input[name=pe_id]').attr('checked', false);
            });
};

jQuery.fn.setupReportScheduleSelectors = function() {
    $( "input#emailed, input#ftp, input#dav" ).each(function() {
        if ( $( this ).attr( 'checked' ) ){
            $("div#report_schedule").attr( 'style', 'display:block');
        }else{
            $("div#report_schedule").attr( 'style', 'display:none');
        }
    });

    $( "#report_delivery_options input[type='radio']" ).change(function(){
        if ( $( "input#ftp:checked").length > 0 || $("input#emailed:checked" ).length > 0 || $("input#dav:checked").length > 0) {
            $("div#report_schedule").attr( 'style', 'display:block');
        }else{
            $("div#report_schedule").attr( 'style', 'display:none');
        }
    });
};

var setupReportDeliverySelectors = function () {
    // Set initial state
    if ($('input#emailed:checked').length > 0) {
        $('fieldset#email_options_container').attr('style', 'display: block');
    }
    else {
        $('fieldset#email_options_container').attr('style', 'display: none');
    }

    if ($('input#ftp:checked').length > 0) {
        $('fieldset#ftp_options_container').attr('style', 'display: block');
    }
    else {
        $('fieldset#ftp_options_container').attr('style', 'display: none');
    }

    if ($('input#dav:checked').length > 0) {
        $('fieldset#dav_options_container').attr('style', 'display: block');
    }
    else {
        $('fieldset#dav_options_container').attr('style', 'display: none');
    }

    // Set event handler to show/hide dav_options_container as appropriate
    $('#report_delivery_options input[type="radio"]').change(function () {
        if ($('input#dav:checked').length > 0) {
            $('fieldset#dav_options_container').attr('style', 'display: block');
        }
        else {
            $('fieldset#dav_options_container').attr('style', 'display: none');
        }
        if ($('input#emailed:checked').length > 0) {
            $('fieldset#email_options_container').attr('style', 'display: block');
        }
        else {
            $('fieldset#email_options_container').attr('style', 'display: none');
        }
        if ($('input#ftp:checked').length > 0) {
            $('fieldset#ftp_options_container').attr('style', 'display: block');
        }
        else {
            $('fieldset#ftp_options_container').attr('style', 'display: none');
        }
    } );
}        


jQuery.fn.setupReportScheduleDayorDate = function(){

    $(this).children('optgroup').children('option').each(function() {
            var selector = "#" + $(this).attr( 'value' ) + "_selects";
            if ( $(this).attr( "selected" ) ){
            $( selector ).attr( "style", "display:block" );
            }else{
            $( selector ).attr( "style", "display:none" );
            }
            });

    $(this).children('optgroup').children('option').click(function() {
            var selector = "#" + $(this).attr( 'value' ) + "_selects";
            $( selector ).attr( "style", "display:block" );

            $(this).siblings('option').each( function(i,option){
                var selector = "#" + $(option).attr( 'value' ) + "_selects";
                $( selector ).attr( "style", "display:none" );
                });
            });
};

// Setup the day/date/month/time selects for the chosen preset
jQuery.fn.selectReportSchedulePreset = function(){

    $(this).change(function() {

            if ( $(this).attr( 'value' ) == 'preset_1' ){
            $( "#day_selects" ).attr( "style", "display:block" );
            $( "#date_selects" ).attr( "style", "display:none" );
            $( "#schedule_run_day" ).children( 'option' ).attr("selected", true );
            $( "#schedule_run_date" ).children( 'option' ).attr( "selected", false );

            $( "#schedule_run_month" ).children( 'option' ).attr( "selected", true );
            $( "#schedule_run_time" ).children( 'option[value="00:00:00"]' ).attr( "selected", true );
            $( "#schedule_run_time" ).children( 'option[value!="00:00:00"]' ).attr( "selected", false );
            }

            else if ( $(this).attr( 'value' ) == 'preset_2' ){
            $( "#day_selects" ).attr( "style", "display:block" );
            $( "#date_selects" ).attr( "style", "display:none" );

            $( "#schedule_run_day" ).children( 'option[value="6"]' ).attr("selected", false );
            $( "#schedule_run_day" ).children( 'option[value="7"]' ).attr("selected", false );
            $( "#schedule_run_day" ).children( 'option[value="1"]' ).attr("selected", true );
            $( "#schedule_run_day" ).children( 'option[value="2"]' ).attr("selected", true );
            $( "#schedule_run_day" ).children( 'option[value="3"]' ).attr("selected", true );
            $( "#schedule_run_day" ).children( 'option[value="4"]' ).attr("selected", true );
            $( "#schedule_run_day" ).children( 'option[value="5"]' ).attr("selected", true );


            $( "#schedule_run_date" ).children( 'option' ).attr( "selected", false );
            $( "#schedule_run_month" ).children( 'option' ).attr( "selected", true );
            $( "#schedule_run_time" ).children( 'option[value="09:00:00"]' ).attr( "selected", true );
            $( "#schedule_run_time" ).children( 'option[value!="09:00:00"]' ).attr( "selected", false );
            }

            else if ( $(this).attr( 'value' ) == 'preset_3' ){
                $( "#day_selects" ).attr( "style", "display:block" );
                $( "#date_selects" ).attr( "style", "display:none" );
                $( "#schedule_run_day" ).children( 'option[value="1"]' ).attr("selected", true );

                $( "#schedule_run_day" ).children( 'option[value="2"]' ).attr("selected", false );
                $( "#schedule_run_day" ).children( 'option[value="3"]' ).attr("selected", false );
                $( "#schedule_run_day" ).children( 'option[value="4"]' ).attr("selected", false );
                $( "#schedule_run_day" ).children( 'option[value="5"]' ).attr("selected", false );
                $( "#schedule_run_day" ).children( 'option[value="6"]' ).attr("selected", false );
                $( "#schedule_run_day" ).children( 'option[value="7"]' ).attr("selected", false );

                $( "#schedule_run_date" ).children( 'option' ).attr( "selected", false );
                $( "#schedule_run_month" ).children( 'option' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value="09:00:00"]' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value!="09:00:00"]' ).attr( "selected", false );

            }

            else if ( $(this).attr( 'value' ) == 'preset_4' ){
                $( "#day_selects" ).attr( "style", "display:none" );
                $( "#date_selects" ).attr( "style", "display:block" );
                $( "#schedule_run_day" ).children( 'option' ).attr("selected", false );

                $( "#schedule_run_date" ).children( 'option[value="1"]' ).attr( "selected", true );
                $( "#schedule_run_date" ).children( 'option[value!="1"]' ).attr( "selected", false );

                $( "#schedule_run_month" ).children( 'option' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value="00:00:00"]' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value!="00:00:00"]' ).attr( "selected", false );

            }

            else if ( $(this).attr( 'value' ) == 'day' ){
                $( "#day_selects" ).attr( "style", "display:block" );
                $( "#date_selects" ).attr( "style", "display:none" );

                $( "#schedule_run_day" ).children( 'option[value="1"]' ).attr("selected", true );
                $( "#schedule_run_day" ).children( 'option[value!="1"]' ).attr("selected", false );

                $( "#schedule_run_date" ).children( 'option' ).attr( "selected", false );
                $( "#schedule_run_month" ).children( 'option' ).attr( "selected", true );

                $( "#schedule_run_time" ).children( 'option[value="09:00:00"]' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value!="09:00:00"]' ).attr( "selected", false );
            }

            else if ( $(this).attr( 'value' ) == 'date' ){
                $( "#day_selects" ).attr( "style", "display:none" );
                $( "#date_selects" ).attr( "style", "display:block" );
                $( "#schedule_run_day" ).children( 'option' ).attr("selected", false );

                $( "#schedule_run_date" ).children( 'option[value="1"]' ).attr( "selected", true );
                $( "#schedule_run_date" ).children( 'option[value!="1"]' ).attr( "selected", false );

                $( "#schedule_run_month" ).children( 'option[value="1"]' ).attr( "selected", true );
                $( "#schedule_run_month" ).children( 'option[value!="1"]' ).attr( "selected", false );

                $( "#schedule_run_time" ).children( 'option[value="00:00:00"]' ).attr( "selected", true );
                $( "#schedule_run_time" ).children( 'option[value!="00:00:00"]' ).attr( "selected", false );

            }

            // just for niceness, focus on the first selected option
            if ( $( "#day_selects" ).attr( "style" ) == "display: block;" )  {
                $( "#schedule_run_day" ).children( 'option:checked:first').focus();
            }else{
                $( "#schedule_run_date" ).children( 'option:checked:first').focus();
            }

            $( "#schedule_run_month" ).children( 'option:checked:first').focus();
            $( "#schedule_run_time" ).children( 'option:checked:first').focus();

    });

}

// ### END admin-functions.js START admin-selectors.js
// Selectors that apply functions to elements in Admin.
// Please define functions in admin-functions.js
// with meaningful names, so we can see what's going on.


jQuery.fn.changeAccID = function () {
    return this.each(function() {
            $(this).change(function () {
                    jQuery.fn.getAccountInstitutions( $(this).attr("value") );
                });
            });

}

jQuery.fn.getAccountInstitutions = function ( acc_id ) {
    // empty the list regardless
    $("select#institutions").empty();

    $.getJSON(
            "/ajax_widgets/account_institutions.html?acc_id=" + acc_id,
            function( data ){ jQuery.fn.handleAccountInstitutions( data );}
    );
}

jQuery.fn.handleAccountInstitutions = function (account_institution_data) {

    // empty the list regardless
    $("select#institutions").empty();

    $.each(account_institution_data, function(i, item) {
            var acc_id, organisation;

            for (var key in item) {
                acc_id = key;
                organisation = item[key];
            }
            var newInstitution = $('<option value="' +  acc_id + '">' + organisation + '</option>');
            $("select#institutions").append(newInstitution);
    });
}
 
$(document).ready(function () {

    // IE 4 and 5 seem to attempt to run the code, but have various problems.
    // Therefore, we detect them and get out.
    if ( $.browser.msie && $.browser.version <6 ) return;

    // Use jQuery to run a setup function when the page loads.
       $('input.number').blur(function (event) {
            if (!this.value.match(/^-?\d+$/)) {
            show_error("'" + this.value + "' does not look like a number");
            }
            });

    // starting the script on page load
    tooltip();

    setTimeout(function() {
        $('select').append(" ");
    }, 2000);

    if ($('#platform *').length == 0) {
        $('#platform_nav').addClass('ui-state-disabled');
    }

    if ($('#site *').length == 0) {
        $('#site_nav').addClass('ui-state-disabled');
    }

    // ==
    // check all feature. 
    // needs: a fieldset class="check_all_enabled"
    // and an input type="checkbox" class="check_all"
    // check_all should be checked by default, if that's the default behaviour (when nothing's selected)
    // changing any other checkbox will unset check_all.

    // Find check_all and add handler to set all others equal to it
    $('fieldset.check_all_enabled input.check_all').click(
        function () {
            $(this).parents('fieldset:eq(0)').find(':checkbox').attr('checked', this.checked);
        });

    // Find all other checkboxes in the fieldset, and add handler to unset check_all
    $('fieldset.check_all_enabled input:not(.check_all)').click(
        function () {
            $(this).parents('fieldset:eq(0)').find(':checkbox.check_all').attr('checked', false);
        });

    jQuery.fn.setupTabs();

    jQuery.fn.setupDatePickers();    

    $('select#period').change( change_report_dates );

    jQuery.fn.setupProductSelectors();

    // Applying the icons is VERY slow in IE 8
    if ( ( ! $.browser.msie ) || ( $.browser.msie && $.browser.version > 8 ) ) {
        $('.link_button_icon_return a').button({ icons: { primary : "ui-icon-arrowreturnthick-1-w" } });
        $('.action_button_icon_document a').button({ icons: { primary : "ui-icon-document" } });
        $('.action_button_icon_calculator a').button({ icons: { primary : "ui-icon-calculator" } });
        $('.action_button_icon_mail_closed a').button({ icons: { primary : "ui-icon-mail-closed" } });
        $('.action_button_icon_copy a').button({ icons: { primary : "ui-icon-copy" } });
        $('.action_button_icon_suitcase a').button({ icons: { primary : "ui-icon-suitcase" } });
        $('.action_button_icon_document-b a').button({ icons: { primary : "ui-icon-document-b" } });
    }

    $('.action-toolbar a, input[type=submit], input[type=button], .link_button a').button();
    $('input, select, textarea').addClass('ui-widget ui-corner-all'); 
    $('input[type=text], textarea').addClass('ui-widget-content');

    //Focus email radio when clicking inside email address box
    $('.outputOptions #email').focus(function(){
        $('#emailed').attr('checked','checked');
    });

    //Toggle concurrency etc text inputs if unlimited is checked
    $("input.unlimited").click(function(){
        $(this).siblings("input[type='text']").attr("disabled", this.checked);
    });

    //Behaviour for subscription start/end date
    $(".subsDate input[type=text], .subsDate select").click(function(){
        //Select the radio button next to our input when we're changed
        $(this).siblings("input[type='radio']").attr('checked', true);

        // UI tweak to reflect the fact the duration will override the fixed date.
        // see SAM-1250, SAM-1253:
        if ( $('#end_method_duration').attr('checked') ) { 
            $('#end_date').val('');
        }
        if ( $('#end_method_date').attr('checked') ) { 
            $('#subs_duration_id option[value=""]').attr('selected', 'selected');
        } 
        // End of tweak
    });

    $('form.track_changes').change(track_changes);
    $('form.track_changes').submit(clear_changes);

    //Behaviour for Scheduled Reports dropdowns.
    // Show/hide the schedule options depending on the delivery selection
    jQuery.fn.setupReportScheduleSelectors();
    setupReportDeliverySelectors();

    // Show or hide days/dates selectors depending on value of dropdown.
    $("#schedule_day_or_date").setupReportScheduleDayorDate();
    $("#schedule_day_or_date").selectReportSchedulePreset();

    // navbar toggling. 
    // first, add the click-handler that expands and collapses things
    $('.navbar .headerText').click(function () { navToggle(this, 'fast'); navSerialize(this); });

    // Deseralize menu collpased state from cookie
    var mnus = $.cookie('nav_state');
    var mnuData = (mnus ? mnus.split('|') : []);
    $('.navbar .headerText').each(function () {
        for (x in mnuData) {
            if (mnuData[x] == this.id) navToggle(this);
        }
    });

    // now, call it on level 2 items to collapse them now
    $('.navbar .level_2 .headerText').each(function () { if ( $(this).parent().find('.topnavactive').length == 0 ) { navToggle(this)  } });

    // 'error' class items should have the theme error class added
    $('.error').addClass('ui-state-error');

    $('#product_selector.regex').multilevel_combobox();

    $('#product_selector.ajax').autocompleteAJAX({
        enable_sites : $('#product_selector.ajax').attr('data-enable-sites'),
        enable_products : $('#product_selector.ajax').attr('data-enable-products')
    });

    $('#group_subs_id.autocomplete.ajax').autocompleteAJAX();

    // Make #product_selector_category update pe_id and site_id hidden fields when changed.
    // NB. multilevel_combobox widget will trigger a change event on this hidden fields as
    // changing the value via dhtml doesn't trigger this event.
    $('#product_selector_category').bind('change', function() {
            var category = $('#product_selector_category')[0].value;
            var value = $('#product_selector_value')[0].value;
            if (category == 'Sites') {
                $('#product_selector_pe_id').val('');
                $('#product_selector_site_id').val(value);
            }
            else {
                $('#product_selector_pe_id').val(value);
                $('#product_selector_site_id').val('');
            }
        });

    // unchecking libcard should uncheck libcode
    $( '#allow_libcard_default' ).bind('change', function(){
        if ( ! $( '#allow_libcard_default' ).attr('checked') ){
            $( '#require_libcode_default' ).attr('checked', false );
        }
    });

    $( '#require_libcode_default' ).bind('change', function(){
        // checking libcard should check libcode
        if ( $( '#require_libcode_default' ).attr('checked') ){
            $( '#allow_libcard_default' ).attr('checked', true );
        }
    });


    $('#email_test').submit(function () { $('input[type=submit]', this).addClass('ui-state-disabled').attr('disabled', 'disabled') });

    $('div#report_details #save_submit').click(function () { 
        $( 'input#showtab' ).val("saved_reports");
    });

    $("div#report_details:has( select#institutions ) input#acc_id ").changeAccID();

    // Init the table sorting and paging for account and subscription listings with default sort order on first col asc.
    $("table#subscription_listing").tableSortingPaging( 'init',{ sortList: [[0,0]] });
    $("table#inherited_subscription_listing").tableSortingPaging( 'init',{ sortList: [[0,0]] });
    $("table#named_user_subscription_listing").tableSortingPaging( 'init',{ sortList: [[0,0]] });

    // Open popup window containing logo preview on click
    $("#logo_preview_popup").bind("click", function(event) {
        var width = $(this).data("logo").img_x;
        var height = $(this).data("logo").img_y;
        var url = $(this).data("logo").image_url;
        var features = "width=" + width + ",height=" + height;
        window.open(url, "LogoPreview", features, true);
        event.preventDefault();
    } );

    // Set up platform content unit block initial visibility and show/hide event handler
    $('fieldset.platform_content_units div.content_units:not(.visible)').hide();
    $('fieldset.platform_content_units h4').bind('click', function () {
            var visibleSiblings = $(this).siblings('div.content_units:visible');
            var hiddenSiblings = $(this).siblings('div.content_units:hidden');
            visibleSiblings.hide();
            hiddenSiblings.show();
            var iconSpan = $(this).find('span.ui-icon'); 
            iconSpan.toggleClass('ui-icon-triangle-1-n ui-icon-triangle-1-s');
        });

    $(".small_ui_icon").each(function(){

        // Assume standard jQuery UI icon image dimensions.
        var current_x = 256;
        var current_y = 240;

        // The desired scale of the icon
        var required_scale_percent = 66;

        var unit_pattern = /[%|px|]/g;

        // Get the top/left background positions, assume it's in px
        var background_position = $(this).css("background-position");

        // if we can't figure out background position, we won't be able
        // to rescale and adjust, so give up silently.
        if ( background_position === undefined ){
            return;
        }

        background_position = background_position.replace(unit_pattern, "");
        var background_positions = background_position.split(" ");

        // Adjust the background position offset by the required percentage.
        var new_position_left = background_positions[0] * ( required_scale_percent / 100 );
        var new_position_top = background_positions[1] * ( required_scale_percent / 100 );

        // Adjust the background size the required percentage.
        var new_background_size_x = current_x * ( required_scale_percent / 100 );
        var new_background_size_y = current_y * ( required_scale_percent / 100 );
        
        // Also need to adjust the size of our container
        var new_size_x = $(this).css("width");
        new_size_x = new_size_x.replace(/px/g, "");

        var new_size_y = $(this).css("height");
        new_size_y = new_size_y.replace(/px/g, "");

        new_size_x = new_size_x * ( required_scale_percent / 100 );
        new_size_y = new_size_y * ( required_scale_percent / 100 );

        // And finally apply the new background size/position and container size 
        $(this).css({ 
            "background-position" : new_position_left + "px " + new_position_top + "px",
            "background-size"     : new_background_size_x + "px " + new_background_size_y + "px",
            "width" : new_size_x + "px",
            "height": new_size_y + "px"
         });

    });
    
    $('.check_required').change(function() { 
        checkAllFieldContents();
    });
    
    // SAMS-1462
    var checkAllFieldContents = function() { 
        var filledField = false;
        $('.check_required').each(function() {
            // Check if value detected - also that spaces are ignored
            var inputCheck = jQuery.trim($(this).val());
            if (inputCheck != '') {
                filledField = true;
                return false;
            }
        });
    
        if (filledField) {
            $('span.required_attribute').show();
        }
        else {
            $('span.required_attribute').hide();
        }
    }

    checkAllFieldContents();
    
    // ensure the modal div is direct child of body
    $('body').append($('div#ajaxBusyModal')); 

    $('div#ajaxBusyModal').jqm({
        modal:      true, 
        toTop:      true,
    });

    $(document).ajaxStart(
    function () {
        $('div#ajaxBusyModal').jqmShow();
    }).ajaxStop(function () {
        $('div#ajaxBusyModal').jqmHide();
    }); 


});


// ### END admin-selectors.js
