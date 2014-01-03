<&| /comps/label.frag,
    for         => "status",
    problems    => $problems
&>Subscription status:</&>
<& /comps/select.frag,
	problems        => $problems,
	class           => "drop",
	name            => "status",
	options         => [$subscription_status],
    selectedlabel   => $status,
    submitonenter   => $submitonenter,
&>
<%args>
	$problems
	$status                 => ''
	$submitonenter          => 0
    $subscription_status    => {}
</%args>
