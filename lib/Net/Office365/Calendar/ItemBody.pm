package Net::Office365::Calendar::ItemBody;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw(Enum);
has [ qw( content contentType ) ], is => 'ro';
has '+contentType', isa => Enum[qw(text html)];

1;
