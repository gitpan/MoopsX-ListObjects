package MoopsX::ListObjects::Types;
{
  $MoopsX::ListObjects::Types::VERSION = '0.001001';
}
use strict; use warnings FATAL => 'all';

use Type::Library -base;
use Type::Utils   -all;
use Types::Standard -types;

use List::Objects::WithUtils qw/array immarray hash/;

declare ArrayObj =>
  as Object,
  where { $_->does('List::Objects::WithUtils::Role::Array') };

coerce ArrayObj =>
  from ArrayRef,
  via { array(@$_) };


declare ImmutableArray =>
  as Object,
  where { $_->isa('List::Objects::WithUtils::Array::Immutable') };

coerce ImmutableArray =>
  from ArrayRef,
  via { immarray(@$_) };


declare ImmutableArrayObj => as 'ImmutableArray';


declare HashObj =>
  as Object,
  where { $_->does('List::Objects::WithUtils::Role::Hash') };

coerce HashObj =>
  from HashRef,
  via { hash(%$_) };

1;
