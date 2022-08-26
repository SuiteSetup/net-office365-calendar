package Net::Office365::Calendar::Calendar;

use Moose;
use Kavorka;
use Try::Tiny;
use Types::Standard qw( Str Int ArrayRef HashRef );
use Net::Office365::Calendar::Types qw( CBool DefaultReminder ListOfNotificationSettings);
use Net::Office365::Calendar::DefaultReminder;
use Net::Office365::Calendar::NotificationSettings;

has [ qw( kind etag id accessRole deleted description location primary summary timeZone ) ], is => 'ro';
has [ qw(   summaryOverride
            colorId backgroundColor foregroundColor
            hidden selected
            defaultReminders notificationSettings
    )], is => 'rw';

has '+kind' => default => 'calendar#calendarListEntry';
has '+defaultReminders'       => isa => ArrayRef[DefaultReminder], coerce => 1;
has '+notificationSettings'   => isa => ListOfNotificationSettings, coerce => 1;

has [qw( +deleted +primary +hidden +selected )], isa => CBool, coerce => 1;

=pod
{
  "kind": "calendar#calendarListEntry",
  "etag": etag,
  "id": string,
  "summary": string,
  "description": string,
  "location": string,
  "timeZone": string,
  "summaryOverride": string,
  "colorId": string,
  "backgroundColor": string,
  "foregroundColor": string,
  "hidden": boolean,
  "selected": boolean,
  "accessRole": string,
  "defaultReminders": [
    {
      "method": string,
      "minutes": integer
    }
  ],
  "notificationSettings": {
    "notifications": [
      {
        "type": string,
        "method": string
      }
    ]
  },
  "primary": boolean,
  "deleted": boolean
}
=cut

1;

