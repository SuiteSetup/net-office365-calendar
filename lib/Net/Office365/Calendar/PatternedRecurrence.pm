package Net::Office365::Calendar::PatternedRecurrence;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( ArrayRef Str );
use Net::Office365::Calendar::Types qw(RecurrencePattern RecurrenceRange);
has [qw(pattern range)], is => 'ro';
has pattern => isa => RecurrencePattern, is => 'ro', coerce => 1;
has range   => isa => RecurrenceRange,   is => 'ro', coerce => 1;

1;

# see https://docs.microsoft.com/en-us/graph/api/resources/patternedrecurrence?view=graph-rest-1.0
