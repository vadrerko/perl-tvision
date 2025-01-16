use strict;
use ExtUtils::MakeMaker;

# path to turbovision headers, libs


#?? -lstdc++ -lmingw32 -lgcc_s -lgcc -lmingwex -lmsvcrt -lkernel32 -lpthread -ladvapi32 -lshell32 -luser32
my ($ldflags, $cflags) = ('-LC:\vad\tv\tvision.git\_build-2 -ltvision  ','-IC:\vad\tv\tvision.git\include');

WriteMakefile(
    NAME          => 'TVision',
    VERSION_FROM  => 'TVision.pm', # finds $VERSION
    ABSTRACT_FROM => 'TVision.pm', # retrieve abstract from module
    AUTHOR        => 'Vadim Konovalov <vkon@cpan.org>',
    LIBS          => ["$ldflags"],
    # DEFINE        => '-DECL_UNICODE',
    INC          => "$cflags", # e.g., '-I. -I/usr/include/other'
    OBJECT  => 'TVision.o TVision-methods.o',
    XS  => { 'TVision.xs' => 'TVision.cpp', 'TVision-methods.xs' => 'TVision-methods.cpp' },
);

sub MY::xs_c {
    '
.xs.cpp:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
}

