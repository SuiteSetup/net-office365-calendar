package Net::Office365::Calendar::DefaultReminder;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str Int );

has method  => is => 'rw', isa => Str;
has minutes => is => 'rw', isa => Int;

1;

