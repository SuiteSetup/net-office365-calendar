package Net::Office365::Calendar::NotificationSettings;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str );

has [qw( type method )] => is => 'rw', isa => Str;

1;

