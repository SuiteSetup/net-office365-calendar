package Net::Office365::Calendar::Attendee;

use Moose;
with 'Net::Office365::Calendar::ToJson';
extends 'Net::Office365::Calendar::Person';
use Types::Standard qw( Enum );
use Net::Office365::Calendar::Types qw(TimeSlot ResponseStatus);

has [ qw( proposedNewTime status type ) ], is => 'ro';
has '+proposedNewTime', isa => TimeSlot, coerce => 1;
has '+status',     isa => ResponseStatus, coerce => 1;
has '+type',       isa => Enum[qw(required optional resource)];

1;

