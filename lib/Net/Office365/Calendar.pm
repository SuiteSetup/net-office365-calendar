package Net::Office365::Calendar;

=head NAME

Net::Office365::Calendar - Access Office365 Calendars and Events

=cut

use Moose;
use Kavorka;
use Try::Tiny;
use Types::Standard qw( ArrayRef );
use Net::Office365::Calendar::Types qw( CBool CalendarListEntry CalendarId Event to_Event );
use Net::Office365::Calendar::Calendar;
use Net::Office365::Calendar::Event;
use WWW::JSON;
use JSON::XS;

has authentication => is => 'ro', lazy => 1, predicate => 'has_auth', builder => '_build_authentication';
has oauth2_access_token => is => 'ro', predicate => 'has_token';

has calendars  => is => 'rw', default => sub { [] }, isa => ArrayRef[CalendarListEntry], coerce => 1;
has _service   => is => 'ro', lazy => 1, builder => '_build_service';
has _current_calendar => is => 'rw', isa => CalendarId, coerce => 1;

method _build_service {
    WWW::JSON->new( base_url         => 'https://graph.microsoft.com/v1.0',
                    post_body_format => 'JSON',
                    ( $self->has_auth || $self->has_token ? (authentication   => $self->authentication) : () ),
                    json             => JSON::XS->new->utf8->allow_nonref->allow_blessed->convert_blessed,
    );
}

method _build_authentication {
    die "Need a valid OAuth2 access token"
        unless $self->has_token;
    my $token = $self->oauth2_access_token;
    return sub { $_[1]->header(Authorization => "Bearer $token") };
}

method get_calendars (CBool $owned?) {
    my $res = $self->_service->get('//me/calendars',  );
    die $res->error unless $res->success;
    $self->calendars($res->res->{value});
}

method set_calendar ($cal) {
    $self->_current_calendar($cal);
}

method get_events (%filters) {
    my $res = $self->_service->get('/me/calendars/[% calendarId %]/events', { -calendarId => $self->_current_calendar, %filters });
    die $res->error unless $res->success;
    my @items = @{ $res->res->{value} };
    map { to_Event($_) } @items;
}

method get_entry ($entry_id) {
    my $res = $self->_service->get('/me/calendars/[% calendarId %]/events/[% eventId %]', { -calendarId => $self->_current_calendar, -eventId => $entry_id });
    die $res->error unless $res->success;
    to_Event( $res->res );
}

method add_entry ($entry) {
    $entry->{-calendarId} = $self->_current_calendar;
    $entry->{-sendNotifications} //= 'False';
    my $res = $self->_service->post('/me/calendars/[% calendarId %]/events?sendNotifications=[% sendNotifications %]', $entry);
    die $res->error unless $res->success;
    $entry = to_Event($res->res);
}

method delete_entry ($entry) {
    my $res = $self->_service->delete('/me/calendars/[% calendarId %]/events/[% eventId %]', { -calendarId => $self->_current_calendar, -eventId => $entry->id });
    die $res->error unless $res->success or $res->code eq '404' or $res->code eq '410';
    1;
}

method update_entry ($entry) {
    $entry->{-calendarId} = $self->_current_calendar;
    $entry->{-eventId}    = $entry->id;
    my $res = $self->_service->patch('/calendars/[% calendarId %]/events/[% eventId %]', $entry);
    die $res->error unless $res->success;
    $entry = to_Event($res->res);
}

method move_entry ($entry_id, $new_calendar_id) {
    my $res = $self->_service->post('/me/calendars/[% calendarId %]/events/[% eventId %]/move?destination=[% destination %]', { -calendarId => $self->_current_calendar, -eventId => $entry_id, -destination => $new_calendar_id });
    die $res->error unless $res->success;
    my $entry = to_Event($res->res);
}
1;

