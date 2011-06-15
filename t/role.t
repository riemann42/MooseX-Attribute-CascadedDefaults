use strict; use warnings;

{
    package MyApp::Role;
    use Moose::Role;
    use MooseX::Attribute::CascadedDefaults;

    class_default sub { 
        my ($self,$attr) = @_;
        return $attr->name;
    };

    has 'foo' => ( is => 'ro', isa => 'Str');

}

{
    package MyApp;
    use Moose;
    
    with 'MyApp::Role';

}

use Test::More tests => 1;                      # last test to print

my $test = MyApp->new();

is($test->foo,'foo', "Set foo attr with class method");

