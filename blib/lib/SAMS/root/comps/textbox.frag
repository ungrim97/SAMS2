<% $on_focus_initialize %>
<input type="<% $type %>" name="<% $name %>" 
    id="<% $id %>" class="<% $class %>" <% $on_focus %> <% $disabled_attr |n %> <% $readonly_attr |n %> <% $on_key_press |n %> 
    title="<% $title %>" value="<% $value %>" size="<% $size %>" <% $maxlength_attr |n %> 
    <% $placeholder_attr |n%> <% $required_attr |n%> <% $onchange |n %> <% $multiple ? 'multiple' : () %> <% $hidden_attr |n %>/>
<& '/comps/contextual_help.frag', id => $id &>
<%doc>
    This produces a text entry widget for a form. This also doubles up as a
    password entry widget because the only difference is the type attribute.

    This text entry widget can also be enhanced using various bits of
    javascript. The form can be submitted when the enter key is pressed, and
    the text that is entered can be limited to a certain character range.
    Currently if the 'class' is 'number' then the entry into the text box is
    limited to 0-9 (and unprintables such as backspace).
</%doc>
<%args>
    $class
    $name
    $problems => undef

    $title => ''
    $id => $name
    $value => ''
    $clearonfocus => 0
    $maxlength => ''
    $size => 15
    $is_password => 0
    $submitonenter => 0
    $onchange => ''
    $disabled => 0
    $type => undef
    $required => 0
    $placeholder => undef
    $readonly => ''
    $hidden => ''
    $multiple => ''
</%args>

<%init>
    my $on_focus_initialize = '';
    my $on_focus = '';
    my $on_key_press = '';

    my $required_attr = ''; 
    my $placeholder_attr = '';
    my $maxlength_attr = '';
    my $disabled_attr = '';
    my $readonly_attr = '';
    my $hidden_attr = '';

    unless ($type) {
        $type = $is_password ? 'password' : 'text';
    }
    if ($required) {
        $required_attr = q{required="required" };
        $class .= ' required';
    }
    if ($placeholder) {
        $placeholder_attr = qq{placeholder="$placeholder" };
    }
    if ($maxlength) {
        $maxlength_attr = qq{maxlength="$maxlength" };
    }
    if ($disabled) {
      $disabled_attr = 'disabled="disabled" ';
    }
    if ($readonly) {
        $readonly_attr = 'readonly="readonly" ';
    }
    if ($hidden) {
        $hidden_attr = 'hidden="hidden"';
    }

    # Set up the onfocus event handler so that the text is cleared
    if ( $clearonfocus ) {
        $on_focus = qq {onfocus="$name+=1;if ($name==1) this.value='';"};
        # set the variable on demand (unique to this widget)
        $on_focus_initialize = qq {
            <script language="JavaScript" type="text/javascript">
                var $name=0
            </script>
        };
    }


    # Set up the onkeypress event handler.
    # If the class is 'number' then the onkeypress will
    # restrict the entry to being numeric only.
    # This can be combined with the $submitonenter code.
    if ($submitonenter) {
        # The javascript command 'submitViaEnter' is loaded on to every page.
        # It can be obtained from http://www.webreference.com/programming/java_dhtml/chap8/2/2.html#77054
        $on_key_press = qq{onkeypress="return submitViaEnter(event);"};
    }

    # HANDLE PROBLEMS!!
    if ($problems && $problems->get($name)) {
        $class = "error $class";
        $title = $problems->as_string($name);
    }
</%init>

%# $Id$
%# Local Variables:
%# mode: cperl
%# cperl-indent-level: 4
%# indent-tabs-mode: nil
%# End:
%# vim: set ai et sw=4 :
