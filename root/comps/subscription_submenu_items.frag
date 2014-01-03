<%args>
  $subscription => undef
</%args>
Subscription Details,#subscription_details
Contact,#contact
% if ( $subscription ) {
Named Users,#named_users_tab
Named User Administrators,#named_user_admins_tab
Subscription IPs,#subscription_ips_tab
% }
Credentials,#credentials
Attributes,#attributes
