package MooseX::Attribute::FlexibleDefaults::Meta::Trait::Role::ApplicationToClass;
use 5.008;
use utf8;
use Moose::Role;

around apply => sub {
    my ($orig,$self, $role, $class ) = @_;
    $self->$orig( $role, $class );
    if ( $role->can('__flex_defaults') ) {
        $role->apply_flex_defaults_to_class($class);
    }
};

no Moose::Role;
1; # Magic true value required at end of module
__END__

