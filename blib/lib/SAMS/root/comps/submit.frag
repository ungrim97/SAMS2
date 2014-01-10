<%args>
    $title    => ''
    $name     => ''
    $value    => ''
    $id       => $name
    $onclick  => ''
    $class    => ''
    $disabled => 0
</%args>
<%perl>
    my $help_id = $id;
    $id   = 'id="' . $id . '" ' if $id;
    $name = 'name="' . $name . '" ' if $name;
    $onclick = 'onclick="' . $onclick . ';" ' if $onclick;
</%perl>
<input <% ( $disabled ) ? 'disabled' : '' %> type="submit" <% $id |n %> <% $name |n %> class="<% $class %>" value="<% $value %>" title="<% $title %>" <% $onclick |n %>/>
<& '/comps/contextual_help.frag', id => $help_id &>
%## $Id$
%# vim: syntax=mason:
