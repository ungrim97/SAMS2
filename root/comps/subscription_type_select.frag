<%args>
    $problems
    $subscription_type_id => ''
    $submitonenter => 0
    $subscription_types => {}
    $required => 0
</%args>

<& "/comps/select.frag", 
    problems => $problems,
    class => "drop",
    name => "subscription_type_id",
    options => [$subscription_types],
    selectedlabel => $subscription_type_id,
    submitonenter => $submitonenter,
&>
