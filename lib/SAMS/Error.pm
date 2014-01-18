package SAMS::Error;

use Moose;
use Moose::Util::TypeConstraints;

enum 'error_level', ['Critical', 'Error', 'Warn', 'Debug', 'Info'];

has level => (
    is  => 'rw',
    isa => 'error_level',
    default => 'Error',
);

has error_message => (
    is  => 'rw',
    isa => 'Str',
);

has error_code => (
    is => 'rw',
    isa => 'Str',
);

1;
