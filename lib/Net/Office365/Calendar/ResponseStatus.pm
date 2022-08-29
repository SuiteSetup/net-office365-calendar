package Net::Office365::Calendar::ResponseStatus;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Enum );
use Net::Office365::Calendar::Types qw(DateTime);
has [qw(response time)], is => 'ro';
has '+response', isa => Enum[qw(none organizer tentativelyAccepted accepted declined notResponded)];
has '+time',     isa => DateTime;
