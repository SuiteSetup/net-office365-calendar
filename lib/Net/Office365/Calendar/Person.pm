package Net::Office365::Calendar::Person;

use Moose;
with 'Net::Office365::Calendar::ToJson';
has [ qw( id email displayName self ) ], is => 'ro';

1;

