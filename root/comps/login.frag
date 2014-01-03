<form action="<% $auth_url %>" method="post" class="alertBox" id="login_form">
<h4>Log in</h4>
<input type="hidden" name="sessionid" value="87612 3gjkdsa876" />
<% $message |n %>
	<div>
	<&| /comps/label.frag, for => "username", problems => $problems &>Username</&>
	<& /comps/textbox.frag,
		problems => $problems,
		class => "login",
		name => "username",
		maxlength => 100,
	&>
</div>
<div>
	<&| /comps/label.frag, for => "password", problems => $problems &>Password</&>
	<& /comps/textbox.frag,
		problems => $problems,
		class => "login",
		name => "password",
		maxlength => 100,
		is_password => 1,
	&>
</div>
	<& /comps/submit.frag,
		problems => $problems,
		class => "button",
		value => "Log In",
	&>
</form>

<script language="JavaScript" type="text/javascript">
<!-- 
    addLoadEvent(function() {
        document.getElementById('username').focus();
    })

//-->
</script>

<%args>
	$errormessage   => ''
    $auth_url       => '/AUTH'
</%args>

<%init>
my $problems = new SAMS::Problems;
my $message = $errormessage ;
#if ($SEMANTICO::ACM::ACSFilter::session{__destination} ne '/' && ! $errormessage)  { 
#    $message = 'Sorry, the page you requested is only available to authenticated users';
#}
$message = qq!<p class="message">$message</p><br />! if $message;

</%init>
