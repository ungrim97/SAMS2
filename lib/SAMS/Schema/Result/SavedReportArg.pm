package SAMS::Schema::Result::SavedReportArg;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('saved_report_args');

__PACKAGE__->add_columns(
    'saved_report_arg_id' => {
        data_type         => 'integer',
        is_numeric        => 1,
        is_auto_increment => 1,
    },
    'saved_report_id' => {
        data_type      => 'integer',
        is_numeric     => 1,
        is_foreign_key => 1,
    },
    'last_update_id' => {
        data_type   => 'text',
        is_nullable => 1
    },
    'last_update_time' => {

        data_type        => 'timestamp with time zone',
        default_value    => \'now()',
        inflate_datetime => 1,
        is_nullable      => 1,
    },
    'arg_name'  => { data_type => 'text', },
    'arg_value' => {
        data_type   => 'text',
        is_nullable => 1
    },
);

__PACKAGE__->set_primary_key('saved_report_arg_id');

__PACKAGE__->add_unique_constraint(
    'saved_report_args_uniq_arg_name_saved_report_id',
    [ 'arg_name', 'saved_report_id' ],
);

__PACKAGE__->belongs_to(
    'saved_report',
    'SAMS::Schema::Result::SavedReport',
    'saved_report_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
