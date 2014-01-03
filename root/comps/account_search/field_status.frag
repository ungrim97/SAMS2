<%args>
	$problems
	$status => ''
	$submitonenter => 0
</%args>
<&| /comps/label.frag, for => "status", problems => $problems &>Subscription status:</&>
<& /comps/select.frag, 
	problems => $problems,
	class => "drop",
	name => "status",
	options => [ 
				{empty => ""},
			    map { {$_ => $_} } $ams->subscription_status,
               ],
    selectedlabel => $status,
    submitonenter => $submitonenter,
&>
