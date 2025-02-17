use TVision;

sub createFindDialog {
    my $d = tnew(TDialog=>[ 0, 0, 38, 12 ], "Find");
    $d->set_options ($d->get_options | ofCentered); # d->options |= ofCentered;

    my $control = tnew(TInputLine=>[3, 3, 32, 4], 80 );
    $d->insert( $control );
    $d->insert(
	    tnew( TLabel=>[2, 2, 15, 3], "~T~ext to find", $control )
	);
    $d->insert(
	    tnew( THistory=>[ 32, 3, 35, 4 ], $control, 10 )
	);

    0 and $d->insert(
	    tnew( TCheckBoxes=> [ 3, 5, 35, 7 ],
		tnew (TSItem=> "~C~ase sensitive",
		    tnew (TSItem=> "~W~hole words only", 0 )
		)
	    )
	);

    $d->insert(
        tnew( TButton=> [ 14, 9, 24, 11 ], "O~K~", cmOK, bfDefault ) );
    $d->insert(
        tnew( TButton=> [ 26, 9, 36, 11 ], "Cancel", cmCancel, bfNormal ) );

    $d->selectNext( 0 );
    return $d;
}


my $tapp = TVision::TVApp::new;
my $desktop = $tapp->deskTop;

my $d = createFindDialog;
$desktop->insert($d);

$tapp->run;


__END__

TDialog *createReplaceDialog()
{
    TDialog *d = new TDialog( TRect( 0, 0, 40, 16 ), "Replace" );

    d->options |= ofCentered;

    TInputLine *control = new TInputLine( TRect( 3, 3, 34, 4 ), 80 );
    d->insert( control );
    d->insert(
        new TLabel( TRect( 2, 2, 15, 3 ), "~T~ext to find", control ) );
    d->insert( new THistory( TRect( 34, 3, 37, 4 ), control, 10 ) );

    control = new TInputLine( TRect( 3, 6, 34, 7 ), 80 );
    d->insert( control );
    d->insert( new TLabel( TRect( 2, 5, 12, 6 ), "~N~ew text", control ) );
    d->insert( new THistory( TRect( 34, 6, 37, 7 ), control, 11 ) );

    d->insert( new TCheckBoxes( TRect( 3, 8, 37, 12 ),
        new TSItem("~C~ase sensitive",
        new TSItem("~W~hole words only",
        new TSItem("~P~rompt on replace",
        new TSItem("~R~eplace all", 0 ))))));

    d->insert(
        new TButton( TRect( 17, 13, 27, 15 ), "O~K~", cmOK, bfDefault ) );
    d->insert( new TButton( TRect( 28, 13, 38, 15 ),
                            "Cancel", cmCancel, bfNormal ) );

    d->selectNext( False );

    return d;
}

