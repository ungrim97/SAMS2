<%args>
	$problems
	$group_subs_id => undef
	$submitonenter => 0
    $result_limit => $stg->{product_site_selector_result_limit}
</%args>
<&| /comps/label.frag, for => "group_subs_id", problems => $problems &>Controlling consortium/supplier:</&>
<input id="group_subs_id" 
       name="group_subs_id" 
       class="searchme autocomplete ajax" 
       type="text"
       data-url="/ajax_widgets/consortia_selector_search.json"
       data-result-limit="<% $result_limit %>"
/>
