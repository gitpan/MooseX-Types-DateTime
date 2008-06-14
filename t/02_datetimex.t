use strict;
use warnings;

BEGIN {

	use Test::More tests => 30;
	use Test::Exception;
	use DateTime;
	
	use_ok 'MooseX::Types::DateTimeX';
}

=head1 NAME

t/02_datetimex.t - Check that we can properly coerce a string.

=head1 DESCRIPTION

Run some tests to make sure the the Duration and DateTime types continue to
work exactly as from the L<MooseX::Types::DateTime> class, as well as perform
the correct string to object coercions.

=head1 TESTS

This module defines the following tests.

=head2 Test Class

Create a L<Moose> class that is using the L<MooseX::Types::DateTimeX> types.

=cut

{
	package MooseX::Types::DateTimeX::CoercionTest;
	
	use Moose;
	use MooseX::Types::DateTimeX qw(DateTime Duration);
	
	has 'date' => (is=>'rw', isa=>DateTime, coerce=>1);
	has 'duration' => (is=>'rw', isa=>Duration, coerce=>1);	
}

ok my $class = MooseX::Types::DateTimeX::CoercionTest->new
=> 'Created a good class';


=head2 ParseDateTime Capabilities

parse some dates and make sure the system can actually find something.

=cut

ok $class->date('2/13/1969 noon')
=> "coerced a DateTime from '2/13/1969 noon'";

is $class->date, '1969-02-13T12:00:00'
=> 'got correct date';

ok $class->date('2/13/1969')
=> "coerced a DateTime from '2/13/1969'";

	is $class->date, '1969-02-13T00:00:00'
	=> 'got correct date';

ok $class->date('2/13/1969 America/New_York')
=> "coerced a DateTime from '2/13/1969 America/New_York'";

	isa_ok $class->date->time_zone => 'DateTime::TimeZone::America::New_York'
	=> 'Got Correct America/New_York TimeZone';

	is $class->date, '1969-02-13T00:00:00'
	=> 'got correct date';

ok $class->date('jan 1 2006')
=>"coerced a DateTime from 'jan 1 2006'";

	is $class->date, '2006-01-01T00:00:00'
	=> 'got correct date';
	

=head2 relative dates

Stuff like "yesterday".  We can make sure they returned something but we have
no way to make sure the values are really correct.  Manual testing suggests
they work well enough, given the inherent ambiguity we are dealing with.

=cut

ok $class->date('now')
=> "coerced a DateTime from 'now'";

ok $class->date('yesterday')
=> "coerced a DateTime from 'yesterday'";


ok $class->date('tomorrow')
=> "coerced a DateTime from 'tomorrow'";


ok $class->date('last week')
=> "coerced a DateTime from 'last week'";


=head2 check inherited constraints

Just a few tests to make sure the object, hash, etc coercions and type checks 
still work.

=cut

ok my $datetime = DateTime->now()
=> 'Create a datetime object for testing';

ok my $anyobject = bless({}, 'Bogus::Does::Not::Exist')
=> 'Created a random object for proving the object constraint';

ok $class->date($datetime)
=> 'Passed Object type constraint test.';

	isa_ok $class->date => 'DateTime'
	=> 'Got a good DateTime Object';

dies_ok { $class->date($anyobject) } 'Does not allow the bad object';

ok $class->date(1000)
=> 'Passed Num coercion test.';

	isa_ok $class->date => 'DateTime'
	=> 'Got a good DateTime Object';
	
	is $class->date => '1970-01-01T00:16:40'
	=> 'Got correct DateTime';

ok $class->date({year=>2000,month=>1,day=>10})
=> 'Passed HashRef coercion test.';

	isa_ok $class->date => 'DateTime'
	=> 'Got a good DateTime Object';
	
	is $class->date => '2000-01-10T00:00:00'
	=> 'Got correct DateTime';
	
=head2 check duration

make sure the Duration type constraint works as expected

=cut

ok $class->duration(100)
=> 'got duration from integer';

	is $class->duration->seconds, 100
	=> 'got correct duration from integer';
	

ok $class->duration('1 minute')
=> 'got duration from string';

	is $class->duration->seconds, 60
	=> 'got correct duration string';
	
	
=head1 AUTHOR

John Napiorkowski E<lt>jjn1056 at yahoo.comE<gt>

=head1 COPYRIGHT

	Copyright (c) 2008 John Napiorkowski. All rights reserved
	This program is free software; you can redistribute
	it and/or modify it under the same terms as Perl itself.

=cut

1;

