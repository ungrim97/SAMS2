<%doc>
    Generates a tabbed submenu.
    Arg submenu_items is an array of arrayrefs. Each arrayref contains a label as
    its first member and a target id for the link as its second member. The label 
    string is converted to an html id by replacing spaces with underscores.
</%doc>
<%args>
@submenu_items => ()
</%args>
% unless (scalar @submenu_items == 0) {
    <ul class="subnavmenu">
%   foreach my $submenu_item (@submenu_items) {
      <& .nav_item, item => $submenu_item &>
%   }
    </ul>
% }
%#--------------------------------------------------------------------- 
<%def .nav_item>
<%args>
@item
</%args>
<%perl>
my $target = $item[1];
my $id = lc($item[0])."_nav";
$id =~ s! !_!g;
</%perl>
<li class="subnavitem" id="<% $id %>"><a href="<% $target %>"><% $item[0] %></a></li>
</%def>
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
