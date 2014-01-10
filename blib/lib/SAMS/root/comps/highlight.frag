<%args>
    $message => ''
    $problems => undef
    $display => 1
</%args>
<%init>
    my $display_none = "style=\"display:none\"";
</%init>
<div>
% if ( $problems ) {
<& '/comps/problems.frag', problems => $problems &>
% }
% if ( $message ne '' ) {
<div id="highlight" class="ui-widget ui-state-highlight ui-corner-all">
    <span class="inline_icon ui-icon ui-icon-info"></span><% $message |n%>
</div>
% }
</div>
