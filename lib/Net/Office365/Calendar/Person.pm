package Net::Office365::Calendar::Person;

use Moose;
with 'Net::Office365::Calendar::ToJson';
has [ qw( emailAddress ) ], handles => qw[(name email address)], is => 'ro';

1;
