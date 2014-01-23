package SAMS::Schema::Result::SavedReportSchedule;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('saved_report_schedule');

__PACKAGE__->add_columns(
    'saved_report_schedule_id' => {
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
    'run_time' => {
        data_type     => 'time',
        default_value => \'localtime',
        is_nullable   => 1,
    },
    'run_day' => {
        data_type     => 'integer[]',        # isa array of ints
        default_value => \"'{}'::integer[]", # default is an empty array of ints
    },
    'run_date' => {
        data_type     => 'integer[]',
        default_value => \"'{}'::integer[]",
    },
    'run_month' => {
        data_type     => 'integer[]',
        default_value => \"'{}'::integer[]",
    },
);

__PACKAGE__->set_primary_key('saved_report_schedule_id');

__PACKAGE__->belongs_to(
    'saved_report',
    'SAMS::Schema::Result::SavedReport',
    'saved_report_id',
    { is_deferrable => 1, on_delete => 'NO ACTION', on_update => 'NO ACTION' },
);

1;
