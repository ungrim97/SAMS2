<%args>
	$problems
	$account_type_id => ''
	$submitonenter => 0
</%args>
<&| /comps/label.frag, for => "account_type_id", problems => $problems &>Account type:</&>
<& /comps/select.frag, 
    problems => $problems,
    class => "drop",
    name => "account_type_id",
    options => [ { empty => '' }, map { { $_->account_type_id => $_->description } } $ams->account_types, ],
    selectedlabel => $account_type_id,
    submitonenter => $submitonenter,
&>
