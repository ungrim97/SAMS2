
<& "/comps/ajaxBusyModal.frag" &>
</div><!-- end content div -->
<p class="copyright"><a href="#top"><img src="/img/totop.png" width="18" height="21" border="0" alt="back to top" title="back to top" /></a><br />
% if(exists($stg->{scar_properties})) {
%    if(exists($stg->{scar_properties}->{name})) {
      Version: <% $stg->{scar_properties}->{name} %>.<br/>
%    } 
%    if(exists($stg->{scar_properties}->{revision})){
      Revision: <% $stg->{scar_properties}->{revision} %>.<br/>
%    }
% }
<a href="http://www.semantico.com/" target="_blank">&copy; Semantico <% $year %></a></p>
</body>
</html>

<%init>
my $year = POSIX::strftime("%Y", gmtime);
</%init>
