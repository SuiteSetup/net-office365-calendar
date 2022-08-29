package Net::Office365::Calendar::DateTimeTimeZone;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str );
use Net::Office365::Calendar::Types qw(DateTime);

has [ qw(dateTime timeZone) ], isa => Str, is => 'ro';

1;
