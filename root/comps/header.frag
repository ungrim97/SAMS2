<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

% my $title = $m->scomp('REQUEST:title');
% $title =~ s/<.*?>//sg;

<title><& /comps/site_name.frag &>: <% $title %></title>

<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" type="text/css" href="static/css/jqModal.css" />
<link rel="stylesheet" type="text/css" href="static/css/jq.datePicker.css" />

<& /comps/jquery_ui_theme.frag &>

<link rel="stylesheet" type="text/css" href="static/css/jquery.treeview.css" />
<link rel="stylesheet" type="text/css" href="static/css/ams.css" />

% my $google_analytics_id;
<& '/comps/include_js.frag' &>
</head>

<%perl>
#Give the body some classes so we can show & hide stuff using css and js
#to add a class to the body, implement a body_class method in a called frag
my $bodyClass = "withNav";
if($m->comp_exists('REQUEST:body_class')){
    $bodyClass = "$bodyClass " . $m->scomp('REQUEST:body_class');
}
$bodyClass = "class=\"$bodyClass\"" if $bodyClass;
</%perl>

<body <% $bodyClass|n%>>
<div class="header">
    <h1 class="logo">
        <a href="/"><img src="static/img/sams-logo.png" border="0" alt="<& /comps/site_name.frag &>" /></a>
    </h1>
</div>

<& header_title.frag &>
<& navbar.frag &>
<!-- /////////////////////////////////////////////////// -->
<!-- start main content here -->
<!-- /////////////////////////////////////////////////// -->
<div class="content">

%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
