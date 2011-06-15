package MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::Composite;
use Moose::Role;
use Moose::Util::MetaRole;

with 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role';

around apply_params => sub {
    my $orig = shift;
    my $role = shift;
    $role = $role->$orig(@_);
    $role = Moose::Util::MetaRole::apply_metaroles(
        for            => $role,
        role_metaroles => {
            application_to_class => [ 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::ApplicationToClass'],
            application_to_role => [ 'MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::ApplicationToClass'],
        },
    );
    for my $inc_role (@{$role->get_roles}) {
        if ( $inc_role->can('__flex_defaults') ) {
            $role->add_flex_default(@{$inc_role->__flex_defaults});
        }
    }
    return $role;
};


no Moose::Role;
1; # Magic true value required at end of module
