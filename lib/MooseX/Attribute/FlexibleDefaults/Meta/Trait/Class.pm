package MooseX::Attribute::FlexibleDefaults::Meta::Trait::Class;
use Moose::Role;
use Carp;

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

1;
