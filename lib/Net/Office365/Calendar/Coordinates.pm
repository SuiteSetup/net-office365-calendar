package Net::Office365::Calendar::Coordinates;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Num );
has [qw(accuracy altitude latitude longitude altitudeAccuracy)], isa => Num, is => 'ro';

1;
