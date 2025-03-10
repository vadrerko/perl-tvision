use strict;
use TVision('tnew');

my $cs1 = tnew(TColorSelector=>[1,1,110,16],0);
my $cs2 = tnew(TColorSelector=>[1,18,110,36],1);

my $tapp = tnew('TVApp');
my $desktop = $tapp->deskTop;

$desktop->insert($cs1);
$desktop->insert($cs2);

$tapp->run;

