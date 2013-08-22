package MoopsX::ListObjects;
{
  $MoopsX::ListObjects::VERSION = '0.001001';
}
use strict; use warnings FATAL => 'all';

use parent 'Moops';
use List::Objects::WithUtils ();

sub import {
  push @{ $_[1] ||= [] }, (
    'List::Objects::WithUtils' => [
      qw/array immarray hash/,
    ],
    'MoopsX::ListObjects::Types' => [ -all ],
  );
  goto \&Moops::import
}

1;

=pod

=for Pod::Coverage import

=head1 NAME

MoopsX::ListObjects - Use Moops with List::Objects::WithUtils

=head1 SYNOPSIS

  package My::App;
  use MoopsX::ListObjects;

  class Foo {
    has mylist => ( 
      default => sub { array }, 
      isa     => ArrayObj
    );

    has mydata => ( 
      default => sub { +{} },
      isa     => HashObj,
      coerce  => 1
    );

    method add_items (@items) {
      $self->mylist->push(@items)
    }

    method find_matches (Str $string) {
      $self->mylist->grep(sub { $_ eq $string })
    }
  }

  my $foo = Foo->new;

  $foo->add_items(qw/ foo bar baz /);

  my $matches = $foo->find_matches( 'foo' );

=head1 DESCRIPTION

Extends Toby Inkster's L<Moops> sugary class building syntax with
L<List::Objects::WithUtils> objects.

Importing L<MoopsX::ListObjects> is the same as importing L<Moops>, but you
also get C<array>, C<immarray>, and C<hash> objects from
L<List::Objects::WithUtils>.

You also get an extra set of types with coercions:

C<ArrayObj>, C<ImmutableArray>, and C<ImmutableArrayObj> will coerce from
plain ARRAY-type references to the appropriate L<List::Objects::WithUtils>
object; C<HashObj> will do the same for HASH-type references.

=head1 SEE ALSO

L<Moops>

L<List::Objects::WithUtils::Role::Array>

L<List::Objects::WithUtils::Role::Hash>

L<List::Objects::WithUtils::Array::Immutable>

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
