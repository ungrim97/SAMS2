<span title="<% $text %>" class="help inline_icon ui-icon ui-icon-help">&nbsp;</span>
<%args>
   $id 
</%args>
<%init>
   return unless $m->comp_exists("REQUEST:page_id");
   my $page = $m->scomp("REQUEST:page_id");
   my $text = '';#$help->for($page, $id);
   return unless $text;
</%init>
