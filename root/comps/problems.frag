<div id="problems" <% $hidden %> class="problems ui-widget ui-state-error ui-corner-all" >
    <span class="inline_icon ui-icon ui-icon-alert"></span>
    <span>Errors:</span>
    <ul>
% for my $problem (@$problems) {
        <li><% $problem->level%>: <% $problem->error_message %></li>
% }
    </ul>
</div>
<%args>
  $problems => undef
</%args>
<%init>
    my $hidden = scalar @$problems ? '' : 'hidden=hidden';
</%init>
%# vim: set ai et sw=4 syntax=mason :
