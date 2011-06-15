use strict;
use warnings;
package MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role;
use Moose::Role;
#with 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Class';
use Moose::Util::MetaRole;

has __flex_defaults => (
    traits => ['Array'],
    is => 'rw',
    isa => 'ArrayRef[CodeRef]',
    default => sub {[]},
    handles => {
        add_flex_default => 'push'
    },
    predicate  => '__has_flex_defaults',
);

sub apply_flex_defaults_to_class {
    my ($role, $class) = @_;
    $class = Moose::Util::MetaRole::apply_metaroles(
        for            => $class,
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
    if ($class->__has_flex_defaults) {
        $class->add_flex_default(@{$role->__flex_defaults});
    }
    else {
        $class->__flex_defaults($role->__flex_defaults);
    }
}

sub composition_class_roles {
    return ('MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::Composite');
}

1;
