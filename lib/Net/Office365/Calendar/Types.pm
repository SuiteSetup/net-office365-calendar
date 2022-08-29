package Net::Office365::Calendar::Types;

use Type::Library
   -base,
   -declare => qw(  DefaultReminder NotificationSettings ListOfNotificationSettings
                    CalendarListEntry Date CalendarId
                    Person Attendee EmailAddress
                    Event ItemBody
                    Location Address Coordinates
                    OnlineMeetingInfo PhoneNumber ResponseStatus
                    PatternedRecurrence RecurrencePattern RecurrenceRange
                    Date DateTime DateTimeTimeZone TimeSlot DayOfWeek
                    CBool
                );
use Type::Utils -all;
use Types::Standard -types;

class_type DefaultReminder,         { class => 'Net::Office365::Calendar::DefaultReminder' };
class_type NotificationSettings,    { class => 'Net::Office365::Calendar::NotificationSettings' };
class_type CalendarListEntry,       { class => 'Net::Office365::Calendar::Calendar' };
class_type Person,                  { class => 'Net::Office365::Calendar::Person' };
class_type EmailAddress,            { class => 'Net::Office365::Calendar::EmailAddress' };
class_type Attendee,                { class => 'Net::Office365::Calendar::Attendee' };
class_type Date,                    { class => 'Net::Office365::Calendar::Date' };
class_type Event,                   { class => 'Net::Office365::Calendar::Event' };
class_type ItemBody,                { class => 'Net::Office365::Calendar::ItemBody' };
class_type Location,                { class => 'Net::Office365::Calendar::Location' };
class_type Address,                 { class => 'Net::Office365::Calendar::Address' };
class_type Coordinates,             { class => 'Net::Office365::Calendar::Coordinates' };
class_type OnlineMeetingInfo,       { class => 'Net::Office365::Calendar::OnlineMeetingInfo' };
class_type PhoneNumber,             { class => 'Net::Office365::Calendar::PhoneNumber' };
class_type ResponseStatus,          { class => 'Net::Office365::Calendar::ResponseStatus' };
class_type PatternedRecurrence,     { class => 'Net::Office365::Calendar::PatternedRecurrence' };
class_type RecurrencePattern,       { class => 'Net::Office365::Calendar::RecurrencePattern' };
class_type RecurrenceRange,         { class => 'Net::Office365::Calendar::RecurrenceRange' };
class_type TimeSlot,                { class => 'Net::Office365::Calendar::TimeSlot' };
class_type DateTimeTimeZone,        { class => 'Net::Office365::Calendar::DateTimeTimeZone' };
class_type DateTime,                { class => 'DateTime' };

declare ListOfNotificationSettings,
  as ArrayRef[NotificationSettings];

declare CBool, as Bool, where { !!$_ || !$_ };

declare CalendarId, as Str, where { 1 };

declare DayOfWeek, as Enum[qw(sunday monday tuesday wednesday thursday friday saturday)];

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
coerce EmailAddress,
    from HashRef, via { 'Net::Office365::Calendar::EmailAddress'->new($_) };
coerce Attendee,
    from HashRef, via { 'Net::Office365::Calendar::Attendee'->new($_) };
coerce Date,
    from HashRef, via { 'Net::Office365::Calendar::Date'->new($_) };
coerce Event,
    from HashRef, via { 'Net::Office365::Calendar::Event'->new($_) };
coerce ItemBody,
    from HashRef, via { 'Net::Office365::Calendar::ItemBody'->new($_) };
coerce Location,
    from HashRef, via { 'Net::Office365::Calendar::Location'->new($_) };
coerce Address,
    from HashRef, via { 'Net::Office365::Calendar::Address'->new($_) };
coerce Coordinates,
    from HashRef, via { 'Net::Office365::Calendar::Coordinates'->new($_) };
coerce OnlineMeetingInfo,
    from HashRef, via { 'Net::Office365::Calendar::OnlineMeetingInfo'->new($_) };
coerce PhoneNumber,
    from HashRef, via { 'Net::Office365::Calendar::PhoneNumber'->new($_) };
coerce ResponseStatus,
    from HashRef, via { 'Net::Office365::Calendar::ResponseStatus'->new($_) };
coerce TimeSlot,
    from HashRef, via { 'Net::Office365::Calendar::TimeSlot'->new($_) };
coerce DateTimeTimeZone,
    from HashRef, via { 'Net::Office365::Calendar::DateTimeTimeZone'->new($_) };
coerce ItemBody,
    from HashRef, via { 'Net::Office365::Calendar::ItemBody'->new($_) };
coerce PatternedRecurrence,
    from HashRef, via { 'Net::Office365::Calendar::PatternedRecurrence'->new($_) };
coerce RecurrencePattern,
    from HashRef, via { 'Net::Office365::Calendar::RecurrencePattern'->new($_) };
coerce RecurrenceRange,
    from HashRef, via { 'Net::Office365::Calendar::RecurrenceRange'->new($_) };

coerce ListOfNotificationSettings,
    from HashRef, via { [ map { to_NotificationSettings($_) } @{ $_->{notifications} } ] };

1;

