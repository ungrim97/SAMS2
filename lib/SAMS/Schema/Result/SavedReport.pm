package SAMS::Schema::Result::SavedReport;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components('InflateColumn::DateTime');

__PACKAGE__->table('saved_report');

__PACKAGE__->add_columns(
    'saved_report_id' => {
        data_type     => 'integer',
        is_numeric => 1,
        is_auto_increment => 1,
    },
    'last_update_id' => {
        data_type => 'text',
     is_nullable => 1
    },
    'last_update_time' => {
        data_type     => 'timestamp with time zone',
        default_value => \'now()',
        inflate_datetime => 1,
        is_nullable   => 1,
    },
    'report_class' => {
        data_type => 'text',
    },
    'report_path' => {
        data_type => 'text',
    },
);

__PACKAGE__->set_primary_key('saved_report_id');

__PACKAGE__->has_many(
    'saved_report_args',
    'SAMS::Schema::Result::SavedReportArg',
    'saved_report_id',
    { cascade_copy              => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
    'saved_report_schedules',
    'SAMS::Schema::Result::SavedReportSchedule',
    'saved_report_id',
    { cascade_copy              => 0, cascade_delete => 0 },
);

1;
