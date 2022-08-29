package Net::Office365::Calendar::TimeSlot;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Enum );
use Net::Office365::Calendar::Types qw(DateTimeTimeZone);
has [qw(start end)], isa => DateTimeTimeZone, is => 'ro', coerce => 1;
