use strict; use warnings;

{
    package MyApp::RoleA;
    use Moose::Role;
    use MooseX::Attribute::FlexibleDefaults;

    flex_default sub { 
        my ($self,$attr) = @_;
        return $attr->name;
    };

    has 'foo' => ( is => 'ro', isa => 'Str');

}
{
    package MyApp::Role;
    use Moose::Role;
    with 'MyApp::RoleA';

}

{
    package MyApp;
    use Moose;
    
    with 'MyApp::Role';

}

use Test::More tests => 1;                      # last test to print

my $test = MyApp->new();

is($test->foo,'foo', "Set foo attr with class method");

