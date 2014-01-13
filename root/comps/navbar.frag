<ul class="navbar">
% foreach my $item (@items) {
    <& .nav_item, currPage => $currPage, item => $item, depth => 1 &>
% }
</ul>
<%args>
    $user => undef
</%args>
<%init>
my @items = $m->comp('/comps/navbar/navbar_contents.frag', user => $user);
my $currPage;

if ($m->comp_exists("REQUEST:navitem")) {
    $currPage = $m->scomp("REQUEST:navitem");
}
elsif ($m->comp_exists("REQUEST:title")){
    $currPage = $m->scomp("REQUEST:title");
}
else{
    return;
}
</%init>

<%def .nav_item>
<li <% $liClass|n %>>
% if (ref $item[1] eq 'ARRAY'){
    <span class="headerText <% $span_class%>"><% $item[0] %><span class="inline_icon ui-icon ui-icon-triangle-1-n"></span></span>
    <ul>
% foreach (@{$item[1]}) {
    <& .nav_item, currPage => $currPage, item => $_ , depth => $depth + 1&>
% }
    </ul>
% }else{
    <a href="<% $item[1] %>"><% $item[0] %></a>
% }
</li>

<%args>
$currPage
@item
$depth
</%args>
<%init>
# this compares the title from the nav bar list (above) with the navitem method
# of the compenent (will use the title if navitem is not defined). 
# If the same it's 'topnavactive'

my $liClass = $item[0] eq  $currPage ? 'topnavactive' : "";

# If our item's an array, then we're the heading for sub-nav items
$liClass = join(" ", "header",$liClass,"level_$depth") if ref $item[1] eq 'ARRAY';
$liClass = "class=\"$liClass\"" if $liClass;

my $span_class = $depth == 1 ? 'ui-widget-header' : '';
</%init>
</%def>
%# vim: set ai et sw=4 syntax=mason :
