package Net::Office365::Calendar::Address;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str );
has [qw(city countryOrRegion postalCode state street)], isa => Str, is => 'ro';

1;
