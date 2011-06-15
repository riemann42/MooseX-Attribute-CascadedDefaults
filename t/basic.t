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
            sub { my ( $self, $attr ) = @_; return $attr . $attr }
        ]
    );

    has 'baz' => (
        is       => 'ro',
        isa      => 'Str',
        fallback => sub {
            my ( $self, $attr ) = @_;
            return $attr . '-' . $attr;
        }
    );

    has 'bat' => (
        is       => 'ro',
        isa      => 'Int',
        default  => sub { return 42 },
    );

    class_default sub {
        my ( $self, $attr ) = @_;
        return undef if ( $attr eq 'baz' );
        return $attr;
    }
}

use Test::More tests => 4;    # last test to print

my $test = MyApp->new();

is( $test->foo, 'foo',     "Set foo attr with class method" );
is( $test->bar, 'barbar',  "Set bar attr with attribute method" );
is( $test->baz, 'baz-baz', "Set baz attr with fallback method" );
is( $test->bat, '42', "Set bat with normal default" );

