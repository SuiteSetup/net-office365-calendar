package Net::Office365::Calendar::Event;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Kavorka qw(method multi);
use Try::Tiny;
use Net::Office365::Calendar::Attendee;
use Net::Office365::Calendar::Date;
use Net::Office365::Calendar::Person;
use Types::Standard qw( Str Int ArrayRef Enum);
use Net::Office365::Calendar::Types qw( CBool Person Attendee Date DateTime );

has [ qw( kind etag creator organizer attendees created
        endTimeUnspecified gadget
        hangoutLink htmlLink iCalUID locked originalStartTime
        privateCopy recurringEventId reminders source start end
        updated
    ) ], is => 'ro';
has [ qw( anyoneCanAddSelf attendeesOmitted colorId description
        extendedProperties guestsCanInviteOthers guestsCanSeeOtherGuests
        id location recurrence sequence status summary
        transparency visibility
    ) ], is => 'rw';

has '+kind' => default => 'calendar#event';

has [ qw( +creator +organizer ) ], isa => Person, coerce => 1;
has '+attendees', isa => ArrayRef[Attendee], default => sub { return []; }, coerce => 1;
has [ qw( +anyoneCanAddSelf +attendeesOmitted
        +guestsCanInviteOthers +guestsCanSeeOtherGuests
        +locked +privateCopy
    ) ], isa => CBool, coerce => 1;

has [qw( +start +end +originalStartTime )], isa => Date, coerce => 1, lazy => 1, builder => '_build_empty_date';
method _build_empty_date { Net::Office365::Calendar::Date->new }

has '+status',       isa => Enum[qw(confirmed tentative cancelled)];
has '+transparency', isa => Enum[qw(opaque transparent)];
has '+visibility',   isa => Enum[qw(default public private confidential)];

# compatibility methods for Net::Google::Calendar::Entry

method uid { $self->id }

multi method title ($title) {
    $self->summary($title);
}

multi method title () {
    $self->summary;
}

multi method content ($content) {
    $self->description($content);
}

multi method content () {
    $self->description;
}

multi method when (DateTime $start, DateTime $end, CBool $is_all_day) {
    $self->start->set($start, $is_all_day);
    $self->end->set($end, $is_all_day);
}

multi method when () {
    my ($start_dt, $start_all_day) = $self->start->get();
    my ($end_dt, $end_all_day) = $self->end->get();
    return ($start_dt, $end_dt, $start_all_day && $end_all_day);
}

# see https://docs.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0

1;
