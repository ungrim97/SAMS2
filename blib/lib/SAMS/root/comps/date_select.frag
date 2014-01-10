<%args>
    $problems
    $name
    $required => 0
	$months => ''
	$years => ''
</%args>

<%init>
	unless ($months) {

		my %default_months;

		$default_months{'01'} = 'January';
		$default_months{'02'} = 'February';
		$default_months{'03'} = 'March';
		$default_months{'04'} = 'April';
		$default_months{'05'} = 'May';
		$default_months{'06'} = 'June';
		$default_months{'07'} = 'July';
		$default_months{'08'} = 'August';
		$default_months{'09'} = 'September';
		$default_months{'10'} = 'October';
		$default_months{'11'} = 'November';
		$default_months{'12'} = 'December';

		$months = \%default_months;
	}
	
	unless ($years) {
		my @default_years;
		my $thisyear = (localtime())[5] + 1900 + 5;

		foreach my $year (2000 .. $thisyear) {
			push( @default_years, $year );
		}
		$years = \@default_years;
	}
</%init>

<& "/comps/select.frag",
	name => $name.'_day',
	class => '',
	options => [ {'' => ''}, map { { $_ => $_ } } (1 .. 31) ],
	selectedlabel => $ARGS{$name.'_day'},
	problems => $problems,
        javascript => qq{onchange="setDay(this.form.${name}_day, this.form.${name}_month, this.form.${name}_year )"},
&>
/
<& "/comps/select.frag",
	name => $name.'_month',
	class => '',
	options => [ {'' => ''}, map { { $_ => $$months{$_} } } sort keys %$months ],
	selectedlabel => $ARGS{$name.'_month'},
	problems => $problems,
        javascript => qq{onchange="setDay(this.form.${name}_day, this.form.${name}_month, this.form.${name}_year )"},
&>
/
<& "/comps/select.frag",
	name => $name.'_year',
	class => '',
	options => [ {'' => ''}, map { { $_ => $_ } } sort @$years ],
	selectedlabel => $ARGS{$name.'_year'},
	problems => $problems,
        javascript => qq{onchange="setDay(this.form.${name}_day, this.form.${name}_month, this.form.${name}_year )"},
&>

