package Net::Office365::Calendar::Location;

use Moose;
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw(Enum Str);
use Net::Office365::Calendar::Types qw(Address Coordinates);
has [ qw( address coordinates displayName locationEmailAddress locationUri locationType uniqueId uniqueIdType  ) ], is => 'ro';
has '+locationType', isa => Enum[qw(default conferenceRoom homeAddress businessAddress geoCoordinates streetAddress hotel restaurant localBusiness postalAddress)];
has '+address', isa => Address, coerce => 1;
has '+coordinates', isa => Coordinates, coerce => 1;

1;
