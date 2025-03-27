# perl-tvision

This CPAN module implements perl bindings for the github.com/magiblot/tvision.
Now it is in beta mode, some interface will change.

# Install

Install github.com/magiblot/tvision, then as usual:

    perl Makefile.PL
    perl Makefile.PL --ldflags=-.. --cflags=-... # to specify proper paths
    make
    make test
    make install

# Verified platforms

Works on windows.

Shoukd work everywhere else, where tvision works, because no platform specific
code exists here in this glue module.

## Notice for windows users.

For strawberry perl users, you can build tvision using the mingw which comes with
perl. This goes well with recent perl 5.38. However mingw/gcc with older perl unable
to build tvision. Probably it is possible to build turbovision library with some
recent gcc/mingw/msys and then use it to build the module with older perl, but
this terra is incognita. Please let me know on your findongs with issue report.

# TODO

* TButton/TMenu -oncommand => sub {...}
* TEvent
* TEditor window - how to initialise it properly - with indicator and scrollbars
* tie variable to control's setData/getData, so to allow -textvariable => \my $var
* TStatusDef TStatusItem TStatusLine
* better typemaps for the unit and other similar types
* move to magic concept described at https://blogs.perl.org/users/nerdvana/2025/01/premium-xs-integration-pt-1.html and https://blogs.perl.org/users/nerdvana/2025/02/premium-xs-integration-pt-2.html
* improve setData/getData
* full editor based on other git repo https://github.com/magiblot/turbo.git - a separate module
* debugger, based on it - also as a separate module

