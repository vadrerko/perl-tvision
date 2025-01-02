use strict;
use TVision;

my $tapp = TVision::TApplication::new;
my $desktop = $tapp->deskTop;
my $w = TVision::TWindow::new(1,1,20,20,'моё окно, товарищи',5);
#my $ew = TVision::TEditWindow::new(1,11,120,30,'моё окно, товарищи 2',23);
my $d = TVision::TDialog::new(52,13,90,19,'dialog');
my $b = TVision::TButton::new(100,2,118,4,'кнопка',123,0);
my $checkboxes = TVision::TCheckBoxes::new(3,3,81,9,['a'..'s']);
my $radiobtns = TVision::TRadioButtons::new(3,23,81,29,['z'..'dt']);
my $e = TVision::TInputLine::new(3,31,81,32,100);
my $sb1 = TVision::TScrollBar::new(50,2,110,4);
my $sb2 = TVision::TScrollBar::new(50,2,110,4);
my $ind = TVision::TIndicator::new(50,6,110,7);
my $tedit = TVision::TEditor::new(50,6,110,36,  $sb1,$sb2,$ind,2);
$desktop->insert($w);
$desktop->insert($e1);
$desktop->insert($checkboxes);
$desktop->insert($radiobtns);
#$desktop->insert($ew);
$desktop->insert($d);
$desktop->insert1($b);
#$desktop->insert($sb);
#$desktop->insert($ind);
#$desktop->insert($tedit);
$tapp->on_idle(sub {$::e++});
#$tapp->handleEvent(sub {print "handleEvent\n"});
$tapp->onCommand(my $sub = sub {
    my ($cmd, $arg) = @_;
    print "command[@_]\n";
    if ($cmd == 123) {
	#button pressed
	#my $t = $e->getData();
	#print "t=$t;\n";
	$e->setData("[".$e->getData."]");
	$b->setTitle("перекнопка");
    }
});
$tapp->run;
print "r=$::r e=$::e";
print 'xx', $e->getData(), ";\n";

