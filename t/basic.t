use strict;
use warnings;

{

    package MyApp;
    use Moose;
    use MooseX::Attribute::CascadedDefaults;

    has 'foo' => ( is => 'ro', isa => 'Str' );

    has 'bar' => (
        is            => 'ro',
        isa           => 'Str',
        cascaded_default => [
            sub { my ( $self, $attr ) = @_; return $attr->name . $attr->name }
        ]
    );

    has 'baz' => (
        is       => 'ro',
        isa      => 'Str',
        fallback => sub {
            my ( $self, $attr ) = @_;
            return $attr->name . '-' . $attr->name;
        }
    );

    class_default sub {
        my ( $self, $attr ) = @_;
        return undef if ( $attr->name eq 'baz' );
        return $attr->name;
    }
}

use Test::More tests => 3;    # last test to print

my $test = MyApp->new();

is( $test->foo, 'foo',     "Set foo attr with class method" );
is( $test->bar, 'barbar',  "Set bar attr with attribute method" );
is( $test->baz, 'baz-baz', "Set baz attr with fallback method" );

