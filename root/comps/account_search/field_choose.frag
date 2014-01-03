<&| /comps/label.frag, for => "query", problems => $problems &>Search:</&>
<& /comps/textbox.frag,
    problems => $problems,
    class => "searchme ui-widget ui-widget-content ui-corner-all",
    name => "query",
    maxlength => 100,
    value => $query,
    submitonenter => $submitonenter,
&>
<&| /comps/label.frag, for => "field", problems => $problems &>Choose a field:</&>
<& /comps/select.frag, 
    problems => $problems,
    class => "drop ui-widget ui-corner-all",
    name => "field",
    options => [$account_search_fields],
    selectedlabel => $field || "organisation",
    submitonenter => $submitonenter,
&>

<%args>
    $problems
    $query
    $field
    $submitonenter          => 0
    $account_search_fields  => {}
</%args>

