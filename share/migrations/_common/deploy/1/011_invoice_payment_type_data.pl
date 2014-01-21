use strict;
use warnings;
use DBIx::Class::Migration::RunScript;

migrate {
    my $invoice_payment_type_rs = shift->schema->resultset('InvoicePaymentType');

    $invoice_payment_type_rs->populate([
            ['name', 'last_update_id'],
            ['Cheque', 'dbseed'],
            ['Credit Card', 'dbseed'],
            ['Wire Transfer', 'dbseed'],
        ]);
}
