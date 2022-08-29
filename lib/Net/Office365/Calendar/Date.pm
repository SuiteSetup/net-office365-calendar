package Net::Office365::Calendar::Date;

use Moose;
use Kavorka;
use DateTime::Format::ISO8601;
with 'Net::Office365::Calendar::ToJson';
use Net::Office365::Calendar::Types qw( CBool DateTime );
has $_, is => 'rw', clearer => "clear_$_" for qw( dateTime timeZone );

method set (DateTime $dt, CBool $is_all_day) {
    if ($is_all_day) {
        $self->clear_dateTime;
        $self->clear_timeZone;
    } else {
        $self->dateTime($dt->iso8601);
        $self->timeZone($dt->time_zone->name) if $dt->time_zone && !$dt->time_zone->is_floating;
    }
}

method get () {
    my $dt = DateTime::Format::ISO8601->parse_datetime($self->dateTime);
    eval { $dt->set_time_zone($self->timeZone) if $self->timeZone }; # ignore unknown time zones
    return ( $dt, 0 );
}

1;

