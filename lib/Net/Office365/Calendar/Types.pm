package Net::Office365::Calendar::Types;

use Type::Library
   -base,
   -declare => qw(  DefaultReminder NotificationSettings ListOfNotificationSettings
                    CalendarListEntry Person Attendee Date CalendarId
                    Event
                    DateTime
                    CBool
                );
use Type::Utils -all;
use Types::Standard -types;

class_type DefaultReminder,         { class => 'Net::Office365::Calendar::DefaultReminder' };
class_type NotificationSettings,    { class => 'Net::Office365::Calendar::NotificationSettings' };
class_type CalendarListEntry,       { class => 'Net::Office365::Calendar::Calendar' };
class_type Person,                  { class => 'Net::Office365::Calendar::Person' };
class_type Attendee,                { class => 'Net::Office365::Calendar::Attendee' };
class_type Date,                    { class => 'Net::Office365::Calendar::Date' };
class_type Event,                   { class => 'Net::Office365::Calendar::Event' };
class_type DateTime,                { class => 'DateTime' };

declare ListOfNotificationSettings,
  as ArrayRef[NotificationSettings];

declare CBool, as Bool, where { !!$_ || !$_ };

declare CalendarId, as Str, where { 1 };

coerce CBool,
    from Any, via { !!$_ };
coerce CalendarId,
    from CalendarListEntry, via { $_->id };
coerce CalendarId,
    from Str, via { $_ };
coerce DefaultReminder,
    from HashRef, via { 'Net::Office365::Calendar::DefaultReminder'->new($_) };
coerce NotificationSettings,
    from HashRef, via { 'Net::Office365::Calendar::NotificationSettings'->new($_) };
coerce CalendarListEntry,
    from HashRef, via { 'Net::Office365::Calendar::Calendar'->new($_) };
coerce Person,
    from HashRef, via { 'Net::Office365::Calendar::Person'->new($_) };
coerce Attendee,
    from HashRef, via { 'Net::Office365::Calendar::Attendee'->new($_) };
coerce Date,
    from HashRef, via { 'Net::Office365::Calendar::Date'->new($_) };
coerce Event,
    from HashRef, via { 'Net::Office365::Calendar::Event'->new($_) };

coerce ListOfNotificationSettings,
    from HashRef, via { [ map { to_NotificationSettings($_) } @{ $_->{notifications} } ] };

1;

