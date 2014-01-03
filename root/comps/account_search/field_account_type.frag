<%args>
	$problems
	$account_type_id    => ''
	$submitonenter      => 0
    $account_types      => {}
</%args>
<&| /comps/label.frag, for => "account_type_id", problems => $problems &>Account type:</&>
<& /comps/select.frag, 
    problems => $problems,
    class => "drop",
    name => "account_type_id",
    options => [$account_types],
    selectedlabel => $account_type_id,
    submitonenter => $submitonenter,
&>
