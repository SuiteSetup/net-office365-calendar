package Net::Office365::Calendar::RecurrenceRange;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( ArrayRef Str Num Enum);
use Net::Office365::Calendar::Types qw(Date);
has [qw(endDate numberOfOccurrences recurrenceTimeZone startDate type)], is => 'ro';
has ['+startDate', '+endDate'], isa => Date, coerce => 1;
has '+numberOfOccurrences', isa => Num;
has '+recurrenceTimeZone', isa => Str;
has '+type', isa => Enum[qw(endDate noEnd numbered)];
1;
