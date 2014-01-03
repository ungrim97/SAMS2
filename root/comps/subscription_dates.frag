<%args>
    $start_date => undef
    $end_date => undef
    $ignore_start => undef
    $ignore_end => undef
    $subs_duration_id => undef
    $show_widget => 1
    $onchange => undef
    $required => 1
    $problems
    $disabled => 0
</%args>
<%init>
    my $markup;
    # Unfortunately create_newsub.html passes true|false for $ignore_start and $ignore_end while
    # viewedit_sub.html passes normal Perl boolean values. Trying to resolve this is an extreme
    # can of worms.
    # Because the /comps/radio.frag expects a Perl boolean value, true|false must be converted.
    if ($ignore_start eq 'true') {
        $ignore_start = 1;
    }
    elsif ($ignore_start eq 'false') {
        $ignore_start = 0;
    }
    if ($ignore_end eq 'true') {
        $ignore_end = 1;
    }
    elsif ($ignore_end eq 'false') {
        $ignore_end = 0;
    }
</%init>

<h4>Subscription Start 
% if ( $required ) {
    <span class="required_mark">*</span>
%}
</h4>
<div class="subsDate" id="subs_start_date">

% $markup = 'Fixed start date';
% if ($show_widget )  {
    <&| /comps/label.frag, for => "start_date", problems => $problems &><% $markup |n %></&>
% } else {
    <input type="hidden" name="start_date" value="<% $start_date %>" />
    <% $markup |n %>
% }
% if ($show_widget )  {
    <& '/comps/radio.frag', 
        disabled => $disabled, 
        id =>'start_method_date', 
        name => 'start_method', 
        value => 'date', 
        checked => ! $ignore_start 
    &>
    <& /comps/cal_select.frag,
        disabled => $disabled, 
        field_name => "start_date",
        date => $start_date,
        problems => $problems,
        onchange => $onchange,
    &>
% } else {
    <p class="inputContainer"><% $start_date %></p>
% }
% if ($show_widget)  {
    <&| /comps/label.frag, for => "start_method_ignore", problems => $problems &>Ignore start date</&>
% } else {
    Ignore start date
% }
% if ($show_widget)  {
    <span class="inputContainer">
        <& '/comps/radio.frag', disabled => $disabled, id => 'start_method_ignore', 
            name=> 'start_method', value => 'ignore' , checked => $ignore_start &>
    </span>
% } else {
    <% $ignore_start eq 'true' ? '<p class="message">YES</p>' : '<p class="message">NO</p>' |n %>
    <input type="hidden" name="ignore_start" value="<% $ignore_start %>" />
%} 
</div>

<h4>Subscription End
% if ( $required ) {
    <span class="required_mark">*</span>
%}
</h4>
<div class="subsDate" id="subs_end_date">
% if ($show_widget)  {
    <&| /comps/label.frag, for => "subs_duration_id", problems => $problems &>Duration</&>
    <span class="inputContainer">
        <& '/comps/radio.frag', disabled => $disabled,  id => 'end_method_duration', 
            name=> 'end_method', value => 'duration', checked => $subs_duration_id &>

        <& "/comps/duration_select.frag", 
            disabled => $disabled,
            problems => $problems, 
            subs_duration_id => $subs_duration_id,
            name => 'subs_duration_id',
            empty_option => 1,
            onchange => $onchange &>

    </span><br />
% } 

% $markup = 'Fixed end date';
% if ($show_widget)  {
    <&| /comps/label.frag, for => "end_date", problems => $problems &><% $markup |n %></&>
% } else {
    <input type="hidden" name="end_date" value="<% $end_date %>" />
    <p class="label"><% $markup |n %></p>
% }

% if ($show_widget)  {
    <& '/comps/radio.frag', 
        disabled => $disabled, 
        id => 'end_method_date', 
        name => 'end_method', 
        value => 'date', 
        checked => ($end_date && !$ignore_end) 
    &>
    <& /comps/cal_select.frag,
        disabled => $disabled,
        field_name => "end_date",
        date => $end_date,
        problems => $problems,
        cal_name => 'cal2',
        onchange => $onchange,
     &>
% } else {
    <p class="inputContainer"><% $end_date %></p>
% }
    
% if ($show_widget)  {
    <&| /comps/label.frag, for => "end_method_ignore", problems => $problems &>Ignore end date</&>
% } else {
    Ignore end date
% }
    
% if ($show_widget)  {
    <span class="inputContainer">
        <& '/comps/radio.frag', 
            disabled => $disabled,
            id => 'end_method_ignore', 
            name => 'end_method', 
            value => 'ignore', 
            checked => $ignore_end  &>
    </span>
% } else {
   <% $ignore_end eq 'true' ? '<p class="message">YES</p>' : '<p class="message">NO</p>' |n %> 
   <input type="hidden" name="ignore_end" value="<% $ignore_end %>" />
% }
</div>
