<%args>
	$problems
	$country_id => undef
	$submitonenter => 0
</%args>
<&| /comps/label.frag, for => "country_id", problems => $problems &>Country:</&>
<& /comps/select.frag, 
    problems => $problems,
    class => "drop",
    name => "country_id",
    options => [
        { empty => '' },
        map { { $_->country_id => $_->name } } $ams->countries,
    ],
    selectedlabel => $country_id,
    submitonenter => $submitonenter,
&>
