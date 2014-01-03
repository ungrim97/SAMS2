<%args>
    $problems
    $subscription_type_id => ''
    $submitonenter => 0
    $required => 0
</%args>
<&| /comps/label.frag, for => "subscription_type_id", problems => $problems &>Subscription type:<% ($required) ? '<span class="message">*</span>' : '' |n %></&>
<& "/comps/subscription_type_select.frag", 
    problems => $problems,
    subscription_type_id => $subscription_type_id,
    submitonenter => $submitonenter,
&>
