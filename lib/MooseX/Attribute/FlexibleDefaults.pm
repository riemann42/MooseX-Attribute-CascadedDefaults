package MooseX::Attribute::FlexibleDefaults;
use 5.008;

use Moose::Exporter 1.9900;

use MooseX::Attribute::FlexibleDefaults::Traits::Attribute;
use MooseX::Attribute::FlexibleDefaults::Traits::Class;

Moose::Exporter->setup_import_methods(
    with_meta => [ 'attr_default'],
    class_metaroles => {
        class => ['MooseX::Attribute::FlexibleDefaults::Traits::Class'],
        attribute => ['MooseX::Attribute::FlexibleDefaults::Traits::Attribute'],
    },
    role_metaroles => {
        role => ['MooseX::Attribute::FlexibleDefaults::Traits::Class'],
        attribute => ['MooseX::Attribute::FlexibleDefaults::Traits::Attribute'],
    },
);

sub attr_default {
    shift->add_builder(@_);
}

1;



