package MooseX::Attribute::FlexibleDefaults;
use 5.008;

use Moose::Exporter 1.9900;

use MooseX::Attribute::FlexibleDefaults::Meta::Trait::Attribute;
use MooseX::Attribute::FlexibleDefaults::Meta::Trait::Class;
use MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role;

Moose::Exporter->setup_import_methods(
    with_meta => [ 'flex_default'],
    class_metaroles => {
        class => ['MooseX::Attribute::FlexibleDefaults::Meta::Trait::Class'],
        attribute => ['MooseX::Attribute::FlexibleDefaults::Meta::Trait::Attribute'],
    },
    role_metaroles => {
        role => ['MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role'],
        attribute => ['MooseX::Attribute::FlexibleDefaults::Meta::Trait::Attribute'],
        application_to_class => [ 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::ApplicationToClass'],
        application_to_role => [ 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::ApplicationToClass'],
    },
);


sub flex_default {
    my $meta = shift;
    $meta->add_flex_default(@_);
}

1;



