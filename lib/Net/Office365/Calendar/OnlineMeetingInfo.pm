package Net::Office365::Calendar::OnlineMeetingInfo;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( ArrayRef Str );
use Net::Office365::Calendar::Types qw(PhoneNumber);
has [qw(conferenceId joinUrl quickdial tollNumber)], isa => Str, is => 'ro';
has tollFreeNumbers => isa => ArrayRef[Str], is => 'ro', default => sub { [] };
has phones => isa => ArrayRef[PhoneNumber], is => 'ro', default => sub { [] }, coerce => 1;

1;
