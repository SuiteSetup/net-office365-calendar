package Net::Office365::Calendar::EmailAddress;

use Moose;
use Kavorka qw(multi method);
with 'Net::Office365::Calendar::ToJson';
use Types::Standard qw( Str );
has [qw(addres name)], isa => Str, is => 'ro';

multi method email () {
    $self->address;
}

multi method email ($new) {
    $self->address($new);
}
