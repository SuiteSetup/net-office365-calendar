package Net::Office365::Calendar::RecurrencePattern;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( ArrayRef Num Enum);
use Net::Office365::Calendar::Types qw(DayOfWeek);
has [qw(dayOfMonth interval month)], isa => Num, is => 'ro';
has daysOfWeek => isa => ArrayRef[DayOfWeek], is => 'ro', default => sub { [] }, coerce => 1;
has firstDayOfWeek => isa => DayOfWeek, is => 'ro';
has index => isa => Enum[qw(first second third fourth last)], is => 'ro';
has type => isa => Enum[qw(daily weekly absoluteMonthly relativeMonthly absoluteYearly relativeYearly)], is => 'ro';
1;

# see https://docs.microsoft.com/en-us/graph/api/resources/recurrencepattern?view=graph-rest-1.0
