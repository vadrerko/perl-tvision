use strict;
use TVision;

my $tapp = tnew 'TVApp';
my $desktop = $tapp->deskTop;
my $w = tnew TWindow=>([1,1,120,15],'моё окно, товарищи',5);
my $w2 = TVision::TWindow::new([16,1,120,30],'моё окно, товарищи',5);
my $d = TVision::TDialog::new([52,13,90,19],'dialog');
my $b2 = TVision::TButton::new([1,1,30,3],'кнопка2',125,0);
my $b = TVision::TButton::new([100,2,118,4],'кнопка',123,0);
my $checkboxes = TVision::TCheckBoxes::new([3,3,81,9],['a'..'s']);
my $radiobtns = TVision::TRadioButtons::new([3,23,81,29],['z'..'dt']);
my $e = TVision::TInputLine::new([3,31,81,32],100);
my $st = TVision::TStaticText::new([5,10,100,11],"стат.текст");
my $sb1 = TVision::TScrollBar::new([51,11,100,11]);
my $sb2 = TVision::TScrollBar::new([1,1,20,1]);
my $ind = TVision::TIndicator::new([1,21,10,21]);
#my $tedit = TVision::TEditor::new(50,6,110,36,  $TVision::NULL, $TVision::NULL, $TVision::NULL, 1000);
my $tedit = TVision::TEditor::new([1,1,110,16],  $sb1, $sb2, $ind, 1000);
$desktop->insert($w);
$desktop->insert($w2);
$desktop->insert($e);
$desktop->insert($radiobtns);
$desktop->insert($d);
$w->insert($b2);
$w->insert($checkboxes);
$w->insert($st);
$desktop->insert($b);
$w2->insert($tedit);
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
	$b->locate([15,15,30,17]);
    }
    elsif ($cmd == 125) {
	$e->normalCursor;
    }
});
$tapp->run;
print "r=$::r e=$::e, input-line->getData =", $e->getData(), ";\n";

