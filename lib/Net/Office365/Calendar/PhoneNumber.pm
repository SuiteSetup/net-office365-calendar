package Net::Office365::Calendar::PhoneNumber;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str Enum );
has number => isa => Str, is => 'ro';
has type   => isa=> Enum[qw(home business mobile other assistant homeFax businessFax otherFax pager radio)];
1;
