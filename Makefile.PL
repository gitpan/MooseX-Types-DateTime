#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'MooseX::Types::DateTime',
    VERSION_FROM => 'lib/MooseX/Types/DateTime.pm',
    INSTALLDIRS  => 'site',
    PL_FILES     => { },
    PREREQ_PM => {
        'Moose'              => '2.0100', # inline_as
        'DateTime'           => '0.4302',
        'DateTime::Locale'   => '0.4001',
        'DateTime::TimeZone' => '0.95',
        'Test::use::ok'      => '0.02',
        'Test::Exception'    => '0.27',
        'namespace::clean'   => '0.08',
        'MooseX::Types'      => '0.19',
    },
    META_MERGE => {
        resources => {
            repository  => 'git://git.moose.perl.org/MooseX-Types-DateTime.git',
        },
    },

);

