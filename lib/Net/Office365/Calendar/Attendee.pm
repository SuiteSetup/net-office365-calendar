package Net::Office365::Calendar::Attendee;

use Moose;
with 'Net::Office365::Calendar::ToJson';
extends 'Net::Office365::Calendar::Person';
has [ qw( additionalGuests comment optional organizer resource responseStatus ) ], is => 'ro';

1;

