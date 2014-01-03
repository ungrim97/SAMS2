<%args>
	$problems
	$org_size_id
	$submitonenter => 0
</%args>
<&| /comps/label.frag, for => "org_size_id", problems => $problems &>Organisation size:</&>
<& /comps/select.frag, 
    problems => $problems,
    class => "drop",
    name => "org_size_id",
    options => [ { empty => '' }, map { { $_->org_size_id => $_->description } } grep { exists $oklist{$_->org_size_id} } $ams->org_sizes, ],
    selectedlabel => $org_size_id,
    submitonenter => $submitonenter,
&>
<%init>
# only show org sizes which could possibly have been chosen by a customer from subscriber services
# these are a subset of the full list
my %oklist;
for (qw /4 6 8 9 10 11 13 14 15/ ) {
    $oklist{$_}++;
}
</%init>
