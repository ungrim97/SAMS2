<div id="problems" class="problems ui-widget ui-state-error ui-corner-all">
    <span class="inline_icon ui-icon ui-icon-alert">Errors:</span>
% for my $problem (@$problems) {
    <span class="errors"><% $problem->error_message %></span>
% }
</div>
<%args>
  $problems => undef
</%args>
<%init>
return unless $problems;
</%init>
%# vim: set ai et sw=4 syntax=mason :
