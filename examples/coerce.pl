use MoopsX::ListObjects;

class Foo :rw {
  has bar => ( isa => ArrayObj, coerce => 1 )
}

my $foo = Foo->new;
$foo->bar([1 .. 10]);
$foo->bar->map(
  sub { say $_ }
)
