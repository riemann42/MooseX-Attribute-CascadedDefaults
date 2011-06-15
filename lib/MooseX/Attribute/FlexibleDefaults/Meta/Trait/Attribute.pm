package MooseX::Attribute::FlexibleDefaults::Meta::Trait::Attribute;
use Moose::Role;
use MooseX::Role::AttributeOverride;

has_plus default => ( 
    default => sub {
        my $attr = shift;
        return sub { $attr->__build_it(@_) },
    }
);

has_plus lazy => (
    default => 1
);

has fallback => (
    is => 'ro',
    isa => 'CodeRef',
    predicate => 'has_fallback',
);

has flex_defaults => (
    traits => ['Array'],
    is => 'ro',
    isa => 'ArrayRef[CodeRef]',
    default => sub {[]},
    predicate  => '__has_flex_defaults',
);

sub __build_it {
    my $attr = shift;
    my $instance = shift;
    my @flex_defaults = @{$attr->flex_defaults};
    if (   ($instance->meta->can('__has_flex_defaults'))
        && ($instance->meta->__has_flex_defaults)) {
        push @flex_defaults, @{$instance->meta->__flex_defaults}
    }
    if ( $attr->has_fallback()) {
        push @flex_defaults, $attr->fallback;
    }
    my $val;
    BUILD:
    foreach my $build (@flex_defaults) {
        $val = ref $build eq 'CODE' ? $instance->$build($attr) 
                                    : $build;
        last BUILD if (defined $val);
    }
    return $val;
};

no Moose::Role;
1;

