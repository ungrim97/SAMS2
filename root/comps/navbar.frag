<!-- $Id$ -->
<%init>

use Digest::MD5 qw(md5_hex);
my @items = $m->comp('/comps/navbar_contents.frag');
my $currPage = $m->scomp("REQUEST:navitem") || $m->scomp("REQUEST:title");

</%init>
<ul class="navbar">
% foreach my $item (@items) {
<& .nav_item, currPage => $currPage, item => $item, depth => 1 &>
% }
</ul>
%#--------------------------------------------------------------------- 
<%def .nav_item>
<%args>
$currPage
@item
$depth
</%args>
<%perl>

# this compares the title from the nav bar list (above) with the navitem method
# of the compenent (will use the title if navitem is not defined). 
# If the same it's 'topnavactive'

my $liClass = $item[0] eq  $currPage ? 'topnavactive' : "";

# If our item's an array, then we're the heading for sub-nav items
$liClass = join(" ", "header",$liClass,"level_$depth") if ref $item[1] eq 'ARRAY';
$liClass = "class=\"$liClass\"" if $liClass;

my $span_class = $depth == 1 ? 'ui-widget-header' : '';

</%perl>
<li <% $liClass|n %>>
% if (ref $item[1] eq 'ARRAY') {
    <span id="nav<% md5_hex($item[0]) %>" class="headerText <% $span_class%>"><span class="inline_icon ui-icon ui-icon-triangle-1-n"></span><% $item[0] %></span>
    <ul>
% foreach (@{$item[1]}) {
%  ##
%  # navigation bar item may be set to 'undef' e.g. in readonly mode
%  if ( defined $_ && $_ ){
    <& .nav_item, currPage => $currPage, item => $_ , depth => $depth + 1&>
%  }
% }
    </ul>
% } else {
    <a href="<% $item[1] %>"><% $item[0] %></a>
% }
</li>

</%def>
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
