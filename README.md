# NAME

MooseX::Types::DateTime - [DateTime](https://metacpan.org/pod/DateTime) related constraints and coercions for
Moose

# VERSION

version 0.09

# SYNOPSIS

Export Example:

    use MooseX::Types::DateTime qw(TimeZone);

    has time_zone => (
        isa => TimeZone,
        is => "rw",
        coerce => 1,
    );

    Class->new( time_zone => "Africa/Timbuktu" );

Namespaced Example:

    use MooseX::Types::DateTime;

    has time_zone => (
        isa => 'DateTime::TimeZone',
        is => "rw",
        coerce => 1,
    );

    Class->new( time_zone => "Africa/Timbuktu" );

# DESCRIPTION

This module packages several [Moose::Util::TypeConstraints](https://metacpan.org/pod/Moose::Util::TypeConstraints) with coercions,
designed to work with the [DateTime](https://metacpan.org/pod/DateTime) suite of objects.

# CONSTRAINTS

- [DateTime](https://metacpan.org/pod/DateTime)

    A class type for [DateTime](https://metacpan.org/pod/DateTime).

    - from `Num`

        Uses ["from\_epoch" in DateTime](https://metacpan.org/pod/DateTime#from_epoch). Floating values will be used for sub-second
        precision, see [DateTime](https://metacpan.org/pod/DateTime) for details.

    - from `HashRef`

        Calls ["new" in DateTime](https://metacpan.org/pod/DateTime#new) with the hash entries as arguments.

- [Duration](https://metacpan.org/pod/Duration)

    A class type for [DateTime::Duration](https://metacpan.org/pod/DateTime::Duration)

    - from `Num`

        Uses ["new" in DateTime::Duration](https://metacpan.org/pod/DateTime::Duration#new) and passes the number as the `seconds` argument.

        Note that due to leap seconds, DST changes etc this may not do what you expect.
        For instance passing in `86400` is not always equivalent to one day, although
        there are that many seconds in a day. See ["How Date Math is Done" in DateTime](https://metacpan.org/pod/DateTime#How-Date-Math-is-Done)
        for more details.

    - from `HashRef`

        Calls ["new" in DateTime::Duration](https://metacpan.org/pod/DateTime::Duration#new) with the hash entries as arguments.

- [DateTime::Locale](https://metacpan.org/pod/DateTime::Locale)

    A class type for [DateTime::Locale::root](https://metacpan.org/pod/DateTime::Locale::root) with the name [DateTime::Locale](https://metacpan.org/pod/DateTime::Locale).

    - from `Str`

        The string is treated as a language tag (e.g. `en` or `he_IL`) and given to
        ["load" in DateTime::Locale](https://metacpan.org/pod/DateTime::Locale#load).

    - from [Locale::Maktext](https://metacpan.org/pod/Locale::Maktext)

        The `Locale::Maketext/language_tag` attribute will be used with ["load" in DateTime::Locale](https://metacpan.org/pod/DateTime::Locale#load).

    - [DateTime::TimeZone](https://metacpan.org/pod/DateTime::TimeZone)

        A class type for [DateTime::TimeZone](https://metacpan.org/pod/DateTime::TimeZone).

        - from `Str`

            Treated as a time zone name or offset. See ["USAGE" in DateTime::TimeZone](https://metacpan.org/pod/DateTime::TimeZone#USAGE) for more
            details on the allowed values.

            Delegates to ["new" in DateTime::TimeZone](https://metacpan.org/pod/DateTime::TimeZone#new) with the string as the `name` argument.

# SEE ALSO

[MooseX::Types::DateTime::MoreCoercions](https://metacpan.org/pod/MooseX::Types::DateTime::MoreCoercions)

[DateTime](https://metacpan.org/pod/DateTime), [DateTimeX::Easy](https://metacpan.org/pod/DateTimeX::Easy)

# AUTHOR

Yuval Kogman <nothingmuch@woobling.org>

John Napiorkowski <jjn1056 at yahoo.com>

# COPYRIGHT

    Copyright (c) 2008 Yuval Kogman. All rights reserved
    This program is free software; you can redistribute
    it and/or modify it under the same terms as Perl itself.
