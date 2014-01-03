<h2 class="pageHead">
<& REQUEST:title &>
% my $subtitle = $m->scomp("REQUEST:subtitle");
% if ($subtitle ne '') {
&raquo;
<span class="message"><% $subtitle |n%></span>
% }
</h2>
