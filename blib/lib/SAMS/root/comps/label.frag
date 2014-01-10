<label for="<% $for %>" class="<% $class %>" title="<% $title%>" <% $id ? qq{id="$id"} : '' |n%>><% $m->content |n %>
% if ( $required ) {
    <span class="required_mark">*</span>
% }
</label>
<%args>
$title => ''
$class => 'label'
$problems => ''
$for
$id => undef
$required => 0
</%args>
<%init>
# Make any problems show up as a nifty tooltip!
$title = $problems->as_string( $for )
    if $problems && $problems->get( $for );
</%init>
%# @(#) $Id$
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 :
