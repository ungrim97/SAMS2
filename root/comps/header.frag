<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <title><% $labels->{titles}{application_title} %> : <% $title %></title>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta http-equiv="imagetoolbar" content="no" />

    <& /comps/include_css.frag &>
    <& /comps/include_js.frag &>

</head>
<body <% $bodyClass %>>
    <div class="header">
        <h1 class="logo">
            <a href="/"><img src="/static/img/sams-logo.png" border="0" alt="<% $labels->{titles}{application_title} %>" /></a>
        </h1>
    </div>

    <& header_title.frag, labels => $labels &>
    <& navbar.frag, %ARGS &>

<!-- /////////////////////////////////////////////////// -->
<!-- start main content here -->
<!-- /////////////////////////////////////////////////// -->
    <div class="content">
        <& /comps/highlight.frag, problems => $errors &>
<%args>
 $errors    => undef
 $user      => undef
 $labels    => {}
</%args>
<%init>
my $title = $m->scomp('REQUEST:title', labels => $labels);
$title =~ s/<.*?>//sg;

#Give the body some classes so we can show & hide stuff using css and js
#to add a class to the body, implement a body_class method in a called frag
my $bodyClass = "withNav";
if($m->comp_exists('REQUEST:body_class')){
    $bodyClass = "$bodyClass " . $m->scomp('REQUEST:body_class');
}
$bodyClass = "class=\"$bodyClass\"" if $bodyClass;


</%init>
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
