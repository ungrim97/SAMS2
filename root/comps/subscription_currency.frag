<%args>
  $problems
  $currency
  $onchange => ''
  $disabled => 0
</%args>


        <& /comps/select.frag,
                disabled => $disabled,
                problems => $problems,
                class => "drop",
                name => "currency",
                options => [ { empty => ''}, {'GBP' => 'Sterling'}, {'USD' => 'US Dollars' }, {'CAD' => 'Canadian Dollars'} ],
                selectedlabel => $currency,
                onchange => $onchange,
        &>

