use Test::More;

use MoopsX::ListObjects;

class My::Foo :rw {

  has array => (
    default => sub { array },
    isa     => ArrayObj,
    coerce  => 1,
  );

  has hash => (
    default => sub { hash },
    isa     => HashObj,
    coerce  => 1,
  );

  has immarray => (
    default => sub { immarray },
    isa     => ImmutableArray,
    coerce  => 1,
  );

  has string => (
    default => sub { 'str' },
    isa     => Str,
  );
  
}

my $foo = My::Foo->new;
isa_ok $foo->array, 'List::Objects::WithUtils::Array';
isa_ok $foo->hash,  'List::Objects::WithUtils::Hash';
isa_ok $foo->immarray, 'List::Objects::WithUtils::Array::Immutable';

# Types.
# FIXME these tests mostly folded into List::Objects::Types
ok $foo->string eq 'str', 'imported Types::Standard ok';

eval {; $foo->array('foo') };
ok $@, 'ArrayObj constraint dies ok';
ok $foo->array( [] ), 'ArrayObj constraint coerce ok';

eval {; $foo->immarray('foo') };
ok $@, 'ImmutableArray constraint dies ok';
ok $foo->immarray( [] ), 'ImmutableArray constraint coerce ok';

eval {; $foo->hash('foo') };
ok $@, 'HashObj constraint dies ok';
ok $foo->hash( +{} ), 'HashObj constraint coerce ok';

done_testing;
