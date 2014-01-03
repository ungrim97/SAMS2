<%args>
	$problems
	$trial_only
</%args>
<&| /comps/label.frag, for => "trial_only", problems => $problems &>Search trial subscriptions only:</&>
<& /comps/checkbox.frag, 
	problems => $problems,
	name => "trial_only",
	type => "checkbox",
    checked => $trial_only,
&>
