<%args>
    $problems
    $administered_by => undef
    $required => 0
</%args>
<&| /comps/label.frag, for => "administered_by", problems => $problems &>Administered by:</&><% ($required) ? '<span class="message">*</span>' : '' |n %>
<& /comps/administered_by_select.frag, 
    problems => $problems,
    selectedlabel => $administered_by,
&>
