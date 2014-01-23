<select
    <% $disabled |n %>
    <% $javascript |n %>
    id="<% $id %>"
    name="<% $name %>"
    class="<% $class %>"
    <% $onkeypress |n %>
    title="<% $title %>"
    <%$onchange |n %>
    <%$style |n %>
    <% $multiple ? "multiple='multiple'" : "" |n %>
    <% $multiple ? "size='$size'" : "" |n %>
    <% $required_attr |n%>
>

% if (@$option_groups){
<& .option_groups,
    option_groups   => $option_groups,
    options         => $options,
    selected_label   => $selected_label,
    multiple        => $multiple,
    selected_labels  => $selected_labels
&>
% } else {
<& .options,
    options         => $options,
    selected_label   => $selected_label,
    multiple        => $multiple,
    selected_labels  => $selected_labels
&>
% }

</select>
<& '/comps/contextual_help.frag', id => $id &>

<%doc>
Display a select list. 
The contents of the list are constructed from $options, which is an array of hashrefs where the value is the key and the label is the
value. It is probably a mistake to pass options in this fashion, but it can't be changed for legacy reasons. This means that if a
hashref contains more than one key an exception is thrown.
Note. The arguments include $selected_label and $selected_labels - these actually refer to the value that is selected rather than
the label. I'm unable to correct this error because so much code depends on this mistake...
EXAMPLE OF USAGE
<& /comps/select.frag ,
 title =>'i am the title',
 name=>'select_name',
 class => 'dropdown',
 options => [ { 1 => 'hamandeggs' },  { 2 => 'fishandchips' } , { 3 => 'peasncheese' } ],
 selected_label => 3,
&>
</%doc>
<%args>
$title => ''
$name
$id => $name
$class
$option_groups => []
$options
$selected_label => ''
$selected_labels => []
$problems => ''
$submitonenter => 0
$javascript => ''
$disabled => undef
$also_at_top => ''
$onchange => ''
$style =>''
$multiple => 0
$size => 0
$required => ''
</%args>
<%init>
# HANDLE PROBLEMS!!
if ($problems && $problems->get($name)) {
    $class = "error " . $class;
    $title = $problems->as_string( $name );
}

# This JS function is loaded in to every page...  It can be obtained
# from:
# http://www.webreference.com/programming/java_dhtml/chap8/2/2.html#77054
my $onkeypress = $submitonenter ? 'onkeypress="return submitViaEnter(event)"' : '';

if ($disabled) {
    $disabled = 'disabled="disabled"';
}
else {
    $disabled = '';
}

my $required_attr = '';
if ( $required ) {
    $required_attr = q{ required="required" };
}
</%init>
<%def .options>
<%args>
    $options
    $selected_label => ''
    $multiple => 0
    $selected_labels => []
</%args>
<%init>
foreach my $option (@{$options}) {
    # $option is a hashref. It should contain one key which is used as the value, while the value
    # is used as the label.

    # Sort keys to ensure that the drop down options are always in the same order
    for my $value (sort $a <=> $b, keys %$option){
        my $selected_attribute;
        $value = '' if $value eq 'empty';
        next unless $value;
        my $label = $option->{$value};

        if (($selected_label && $selected_label eq $value) ||
            ($multiple && scalar(@{$selected_labels}) > 0 && grep(/^$value$/, @$selected_labels))
        ){
            $selected_attribute = 'selected="selected"';
        }

        $value = $m->interp()->apply_escapes($value, 'h');
        $label = $m->interp()->apply_escapes($label, 'h'); # starting to regret using print in an init block...
        $m->print(qq!<option ${selected_attribute}value="$value">$label</option>!);
    }
}
</%init>
</%def>

<%def .option_groups>
<%args>
    $option_groups
    $selected_label
    $multiple => 0
    $selected_labels => []
</%args>
<%init>
foreach my $option_group (@$option_groups) {
    # $option_group is a hashref. It should contain one key which is used as the value, while the value
    # is an arrayref of options.
    my @keys = keys(%{$option_group});
    die "More than one key for option_group" if scalar(@keys) > 1;
    my $value = $keys[0];
    my $options = $option_group->{$value};
    $m->print(qq{<optgroup label="$value">});
    $m->comp(".options", options => $options, selected_label => $selected_label, multiple => $multiple, selected_labels => $selected_labels);
    $m->print(qq{</optgroup>});
}
</%init>
</%def>
%# $Id$ 
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 syntax=mason :
