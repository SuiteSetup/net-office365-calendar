package Net::Office365::Calendar::ToJson;

use Moose::Role;
use Kavorka;

method TO_JSON {
    return { %$self };
};

1;

