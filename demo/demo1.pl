use strict;
use TVision;

my $tapp = TVision::TApplication::new;
my $desktop = $tapp->deskTop;
my $w = TVision::TWindow::new(1,1,120,15,'моё окно, товарищи',5);
#my $ew = TVision::TEditWindow::new(1,11,120,30,'моё окно, товарищи 2',23);
my $d = TVision::TDialog::new(52,13,90,19,'dialog');
my $b2 = TVision::TButton::new(1,1,30,3,'кнопка2',125,0);
my $b = TVision::TButton::new(100,2,118,4,'кнопка',123,0);
my $checkboxes = TVision::TCheckBoxes::new(3,3,81,9,['a'..'s']);
my $radiobtns = TVision::TRadioButtons::new(3,23,81,29,['z'..'dt']);
my $e = TVision::TInputLine::new(3,31,81,32,100);
my $st = TVision::TStaticText::new(5,10,100,11,"стат.текст");
#my $sb1 = TVision::TScrollBar::new(50,2,110,4);
#my $sb2 = TVision::TScrollBar::new(50,2,110,4);
#my $ind = TVision::TIndicator::new(50,6,110,7);
#my $tedit = TVision::TEditor::new(50,6,110,36,  $sb1,$sb2,$ind,2);
$desktop->insert($w);
$desktop->insert($e);
$desktop->insert($radiobtns);
#$desktop->insert($ew);
$desktop->insert($d);
$w->insert($b2);
$w->insert($checkboxes);
$w->insert($st);
$desktop->insert($b);
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
	$e->setData("[".$e->getData."]");
	$b->setTitle("перекнопка");
	$e->blockCursor;
	#$b->locate(15,15,30,17);
    }
    elsif ($cmd == 125) {
	$e->normalCursor;
    }
});
$tapp->run;
print "r=$::r e=$::e";
print 'xx', $e->getData(), ";\n";

