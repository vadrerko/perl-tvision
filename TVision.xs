#define Uses_TView
#define Uses_TButton
#define Uses_TRect
#define Uses_TStatusLine
#define Uses_TStatusDef
#define Uses_TStatusItem
#define Uses_TCheckBoxes
#define Uses_TRadioButtons
#define Uses_TScroller
#define Uses_TScrollBar
#define Uses_TIndicator
#define Uses_TInputLine
#define Uses_TEditor
#define Uses_TKeys
#define Uses_MsgBox
#define Uses_fpstream
#define Uses_TEvent
#define Uses_TDeskTop
#define Uses_TApplication
#define Uses_TWindow
#define Uses_TEditWindow
#define Uses_TDeskTop
#define Uses_TDialog
#define Uses_TScreen
#define Uses_TSItem
#define Uses_TMenuItem
#define Uses_TMenuBar
#define Uses_TSubMenu

#include <tvision/tv.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

static int initialized = 0;
CV *cv_on_idle = 0;
CV *cv_handleEvent = 0;
CV *cv_onCommand = 0;

static inline TWindow* sv2tv_h(SV *sv) {
    // SvTYPE(SvRV(SV*)) === SVt_PVHV    Hash
    HV *hv = (HV*) SvRV(sv);
    SV** f = hv_fetch(hv, "obj", 3, 0);
    if (!f)
	croak("obj key does not contain tvision object");
    TWindow* w = *((TWindow**) SvPV_nolen(*f));
    return w;
}
static inline TWindow* sv2tv_a(SV *sv) {
    // SvTYPE(SvRV(SV*)) === SVt_PVAV    Array
    AV *hv = (AV*) SvRV(sv);
    SV** f = av_fetch(hv, 0, 0);
    if (!f)
	croak("self[0] does not contain tvision object");
    TWindow* w = *((TWindow**) SvPV_nolen(*f));
    return w;
}
#define sv2tv_s(sv,type) *((type**) SvPV_nolen(SvRV(sv)))
#define new_tv_a(w, pkg) \
    AV *self = newAV(); \
    av_store(self, 0, newSVpvn((const char *)&w, sizeof(w))); \
    SV *rself = newRV_inc((SV*) self); \
    sv_bless(rself, gv_stashpv(pkg, GV_ADD))


class TVApp : public TApplication {
public:
    TVApp();
    static TStatusLine *initStatusLine( TRect r );
    static TMenuBar *initMenuBar( TRect r );
    virtual void handleEvent(TEvent& Event);
    virtual void getEvent(TEvent& event);
    virtual void idle();              // Updates heap and clock views
private:
    //void aboutDlgBox();               // "About" box
    //void printEvent(const TEvent &);
    //void chBackground();              // Background pattern
    //void openFile( const char *fileSpec );  // File Viewer
    //void changeDir();                 // Change directory
    //void mouse();                     // Mouse control dialog box
    //void colors();                    // Color control dialog box
    //void outOfMemory();               // For validView() function
    //void loadDesktop(fpstream& s);    // Load and restore the
    //void retrieveDesktop();           //  previously saved desktop
    //void storeDesktop(fpstream& s);   // Store the current desktop
    //void saveDesktop();               //  in a resource file
};
TVApp *tapp = NULL;
TVApp::TVApp() :
    TProgInit( &TVApp::initStatusLine,
               &TVApp::initMenuBar,
               &TVApp::initDeskTop )
{
}

void TVApp::idle() {
    TProgram::idle();
        //eval_pv("$::r++\n", TRUE);
        //eval_pv("TVision::fefe()", TRUE);
	//call_pv("TVision::fefe",0);
    if (cv_on_idle) {
	dSP;
	PUSHMARK(SP);
	PUTBACK;
	//call_pv("TVision::fefe", G_DISCARD|G_NOARGS);
	call_sv((SV*)cv_on_idle, G_DISCARD);
    }
}

void TVApp::handleEvent(TEvent& event) {
    TApplication::handleEvent(event);
    if (cv_handleEvent) {
	dSP;
	PUSHMARK(SP);
	PUTBACK;
	call_sv((SV*)cv_handleEvent, G_DISCARD);
    }
}

void TVApp::getEvent(TEvent &event) {
    TApplication::getEvent(event);
    switch (event.what) {
    case evCommand:
	if (cv_onCommand) {
	    dSP;
	    PUSHMARK(SP);
            EXTEND(SP, 2);
            PUSHs(sv_2mortal(newSViv(event.message.command)));
            PUSHs(sv_2mortal(newSViv(event.message.infoLong)));
	    PUTBACK;
	    call_sv((SV*)cv_onCommand, G_DISCARD);
	}
	if (event.message.command == 1) { }
	else if (event.message.command == 2) { }
	break;
    case evMouseDown:
	if (event.mouse.buttons == mbRightButton)
	    event.what = evNothing;
	break;
    case evMouseUp:
	break;
    case evMouseMove:
	break;
    case evMouseAuto:
	break;
    case evMouseWheel:
	break;
    case evKeyDown:
	break;
    case evBroadcast:
	break;
    }
}

TStatusLine *TVApp::initStatusLine( TRect r ) {
    printf("TVApp::initStatusLine\n");
    r.a.y = r.b.y - 1;

    return (new TStatusLine( r,
      *new TStatusDef( 0, 50 ) +
        *new TStatusItem( "~F1~ Help", kbF1, cmHelp ) +
        *new TStatusItem( "~Alt-X~ Exit", kbAltX, cmQuit ) +
        *new TStatusItem( 0, kbShiftDel, cmCut ) +
        *new TStatusItem( 0, kbCtrlIns, cmCopy ) +
        *new TStatusItem( 0, kbShiftIns, cmPaste ) +
        *new TStatusItem( 0, kbAltF3, cmClose ) +
        *new TStatusItem( 0, kbF10, cmMenu ) +
        *new TStatusItem( 0, kbF5, cmZoom ) +
        *new TStatusItem( 0, kbCtrlF5, cmResize ) +
      *new TStatusDef( 50, 0xffff ) +
        *new TStatusItem( "Howdy", kbF1, cmHelp )
        )
    );
}

const int
  hcCancelBtn            = 35,
  hcFCChDirDBox          = 37,
  hcFChangeDir           = 15,
  hcFDosShell            = 16,
  hcFExit                = 17,
  hcFOFileOpenDBox       = 31,
  hcFOFiles              = 33,
  hcFOName               = 32,
  hcFOOpenBtn            = 34,
  hcFOpen                = 14,
  hcFile                 = 13,
  hcNocontext            = 0,
  hcOCColorsDBox         = 39,
  hcOColors              = 28,
  hcOMMouseDBox          = 38,
  hcOMouse               = 27,
  hcORestoreDesktop      = 30,
  hcOSaveDesktop         = 29,
  hcOpenBtn              = 36,
  hcOptions              = 26,
  hcPuzzle               = 3,
  hcSAbout               = 8,
  hcSAsciiTable          = 11,
  hcSystem               = 7,
  hcViewer               = 2,
  hcWCascade             = 22,
  hcWClose               = 25,
  hcWNext                = 23,
  hcWPrevious            = 24,
  hcWSizeMove            = 19,
  hcWTile                = 21,
  hcWZoom                = 20,
  hcWindows              = 18;

const int cmAboutCmd    = 100;
const int cmOpenCmd     = 105;
const int cmChDirCmd    = 106;
const int cmMouseCmd    = 108;
const int cmSaveCmd     = 110;
const int cmRestoreCmd  = 111;
const int cmEventViewCmd= 112;


TMenuBar *TVApp::initMenuBar(TRect r) {
    TSubMenu& sub1 =
      *new TSubMenu( "~\xf0~", 0, hcSystem ) +
        *new TMenuItem( "~A~bout...", cmAboutCmd, kbNoKey, hcSAbout ) +
         newLine() +
        *new TMenuItem( "~E~vent Viewer", cmEventViewCmd, kbAlt0, hcNoContext, "Alt-0" );

    TSubMenu& sub2 =
      *new TSubMenu( "~F~ile", 0, hcFile ) +
        *new TMenuItem( "~O~pen...", cmOpenCmd, kbF3, hcFOpen, "F3" ) +
        *new TMenuItem( "~C~hange Dir...", cmChDirCmd, kbNoKey, hcFChangeDir ) +
         newLine() +
        *new TMenuItem( "~D~OS Shell", cmDosShell, kbNoKey, hcFDosShell ) +
        *new TMenuItem( "E~x~it", cmQuit, kbAltX, hcFExit, "Alt-X" );

    TSubMenu& sub3 =
      *new TSubMenu( "~W~indows", 0, hcWindows ) +
        *new TMenuItem( "~R~esize/move", cmResize, kbCtrlF5, hcWSizeMove, "Ctrl-F5" ) +
        *new TMenuItem( "~Z~oom", cmZoom, kbF5, hcWZoom, "F5" ) +
        *new TMenuItem( "~N~ext", cmNext, kbF6, hcWNext, "F6" ) +
        *new TMenuItem( "~C~lose", cmClose, kbAltF3, hcWClose, "Alt-F3" ) +
        *new TMenuItem( "~T~ile", cmTile, kbNoKey, hcWTile ) +
        *new TMenuItem( "C~a~scade", cmCascade, kbNoKey, hcWCascade );

    TSubMenu& sub4 =
      *new TSubMenu( "~O~ptions", 0, hcOptions ) +
        *new TMenuItem( "~M~ouse...", cmMouseCmd, kbNoKey, hcOMouse ) +
        (TMenuItem&) (
            *new TSubMenu( "~D~esktop", 0 ) +
            *new TMenuItem( "~S~ave desktop", cmSaveCmd, kbNoKey, hcOSaveDesktop ) +
            *new TMenuItem( "~R~etrieve desktop", cmRestoreCmd, kbNoKey, hcORestoreDesktop )
        );

    r.b.y =  r.a.y + 1;
    return (new TMenuBar( r, sub1 + sub2 + sub3 + sub4 ) );
}


MODULE=TVision::TApplication PACKAGE=TVision::TApplication

SV* new()
    CODE:
	tapp = new TVApp();
	//printf("tapp=%016X\n",tapp);
        RETVAL = get_sv("TVision::TApplication::the_app", GV_ADD);
	sv_setpvn(newSVrv(RETVAL, "TVision::TApplication"), (const char *)&tapp, sizeof(tapp));
	//do_sv_dump(0, PerlIO_stderr(), RETVAL, 0, 10, 0,0);
    OUTPUT:
	RETVAL

SV* deskTop(SV *self)
    CODE:
        SV *sv_tapp = SvRV(self);
        TVApp* tapp = *((TVApp**) SvPV_nolen(sv_tapp));
	TDeskTop *td = tapp->deskTop;
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TDeskTop"), (const char*)&td, sizeof(td));
	//printf("tapp=%016X, deskt=%016X\n", tapp, td);
    OUTPUT:
	RETVAL

void run(SV *t)
    CODE:
        SV *sv_tapp = SvRV(t);
        TVApp* tapp = *((TVApp**) SvPV_nolen(sv_tapp));
	tapp->run();

void on_idle(SV *self, CV *c = 0)
    CODE:
        cv_on_idle = c;

void handleEvent(SV *self, CV *c = 0)
    CODE:
        cv_handleEvent = c;

void onCommand(SV *self, CV *c = 0)
    CODE:
        cv_onCommand = c;
	printf("cv_onCommand=%016X\n", cv_onCommand);

MODULE=TVision::TDialog PACKAGE=TVision::TDialog

SV* new(int _ax, int ay, int bx, int by, char *title)
    CODE:
	TDialog *w = new TDialog(TRect(_ax,ay,bx,by),title);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TDialog"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TButton PACKAGE=TVision::TButton
SV* _new_h(int _ax, int ay, int bx, int by, char *title, int cmd, int flags)
    CODE:
	TButton *w = new TButton(TRect(_ax,ay,bx,by),title,cmd,flags);
        HV *self = newHV();
        hv_store(self, "num", 3, newSViv(cmd), 0);
        hv_store(self, "obj", 3, newSVpvn((const char *)&w, sizeof(w)), 0);
        RETVAL = newRV_inc((SV*) self);
        sv_bless(RETVAL, gv_stashpv("TVision::TButton", GV_ADD));
    OUTPUT:
	RETVAL

SV* _new_a(int _ax, int ay, int bx, int by, char *title, int cmd, int flags)
    CODE:
	TButton *w = new TButton(TRect(_ax,ay,bx,by),title,cmd,flags);
        new_tv_a(w,"TVision::TButton");
        av_store(self, 1, newSViv(cmd));
        RETVAL = rself;
    OUTPUT:
	RETVAL

void setTitle(SV *self, char *title)
    CODE:
	TButton* w = (TButton*)sv2tv_a(self);
	delete w->title;
	w->title = new char[strlen(title)+1];
	strcpy((char*)w->title,title);
	w->draw();


MODULE=TVision::TInputLine PACKAGE=TVision::TInputLine
SV* new(int _ax, int ay, int bx, int by, int limit)
    CODE:
	TInputLine *w = new TInputLine(TRect(_ax,ay,bx,by),limit);
	new_tv_a(w,"TVision::TInputLine");
        RETVAL = rself;
    OUTPUT:
	RETVAL

void setData(SV *self, char *data)
    CODE:
        TInputLine* til = (TInputLine*) sv2tv_a(self);
	til->setData(data);

char *getData(SV *self)
    CODE:
        TInputLine* til = (TInputLine*) sv2tv_a(self);
	char data[2048]; // OMG2
	til->getData(data);
	RETVAL=data;
    OUTPUT:
	RETVAL

MODULE=TVision::TCheckBoxes PACKAGE=TVision::TCheckBoxes
SV* new(int _ax, int ay, int bx, int by, AV *_items)
    CODE:
        int cnt = av_count(_items);
	//printf("items=%d\n",cnt);
        TSItem *tsit = 0;
	for (int i=cnt-1; i>=0; i--) {
	    SV **sv = av_fetch(_items, i, 0);
	    //printf("i=%d s=%s\n", i, SvPV_nolen(*sv));
	    TSItem *n = new TSItem(SvPV_nolen(*sv), tsit);
	    tsit = n;
	}
	TCheckBoxes *w = new TCheckBoxes(TRect(_ax,ay,bx,by), tsit);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TCheckBoxes"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TRadioButtons PACKAGE=TVision::TRadioButtons
SV* new(int _ax, int ay, int bx, int by, AV *_items)
    CODE:
        int cnt = av_count(_items);
	//printf("items=%d\n",cnt);
        TSItem *tsit = 0;
	for (int i=cnt-1; i>=0; i--) {
	    SV **sv = av_fetch(_items, i, 0);
	    //printf("i=%d s=%s\n", i, SvPV_nolen(*sv));
	    TSItem *n = new TSItem(SvPV_nolen(*sv), tsit);
	    tsit = n;
	}
	TRadioButtons *w = new TRadioButtons(TRect(_ax,ay,bx,by), tsit);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TRadioButtons"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TScrollBar PACKAGE=TVision::TScrollBar
SV* new(int _ax, int ay, int bx, int by)
    CODE:
	TScrollBar *w = new TScrollBar(TRect(_ax,ay,bx,by));
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TScrollBar"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TIndicator PACKAGE=TVision::TIndicator
SV* new(int _ax, int ay, int bx, int by)
    CODE:
	TIndicator *w = new TIndicator(TRect(_ax,ay,bx,by));
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TIndicator"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TEditor PACKAGE=TVision::TEditor
SV* new(int _ax, int ay, int bx, int by, SV *svsb1, SV *svsb2, SV *svind, int n)
    CODE:
        SV *_svsb1 = SvRV(svsb1);
        TScrollBar* sb1 = *((TScrollBar**) SvPV_nolen(_svsb1));
        SV *_svsb2 = SvRV(svsb2);
        TScrollBar* sb2 = *((TScrollBar**) SvPV_nolen(_svsb2));
        SV *_ind = SvRV(svind);
        TIndicator* ind = *((TIndicator**) SvPV_nolen(_ind));
	TEditor *w = new TEditor(TRect(_ax,ay,bx,by),sb1,sb2,ind, n);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TEditor"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TWindow PACKAGE=TVision::TWindow
SV* new(int _ax, int ay, int bx, int by, char *title, int num)
    CODE:
        TRect r(_ax,ay,bx,by);
	TWindow *w = new TWindow(r,title,num);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TWindow"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

#if 0
MODULE=TVision::TMenu PACKAGE=TVision::TMenu
SV* new(int _ax, int ay, int bx, int by, char *title, int num)
    CODE:
        TRect r(_ax,ay,bx,by);
	TMenu *w = new TMenu(r,title,num);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TMenu"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL
#endif

MODULE=TVision::TSubMenu PACKAGE=TVision::TSubMenu
SV* new(char *nm, int key, int helpCtx = hcNoContext)
    CODE:
	// TSubMenu(TStringView nm, TKey key, ushort helpCtx = hcNoContext);
	TSubMenu *w = new TSubMenu(TStringView(nm),key,helpCtx);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TSubMenu"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

MODULE=TVision::TMenuBar PACKAGE=TVision::TMenuBar
SV* new(int _ax, int ay, int bx, int by, SV *TMenu_or_TSubMenu)
    CODE:
        TRect r(_ax,ay,bx,by);
	TMenuBar *w;
	if (sv_isa(TMenu_or_TSubMenu, "TVision::TMenu")) {
	    TMenu *m = *((TMenu**) SvPV_nolen(TMenu_or_TSubMenu));
	    w = new TMenuBar(r,m);
	} else if (sv_isa(TMenu_or_TSubMenu, "TVision::TSubMenu")) {
	    TSubMenu sm = **((TSubMenu**) SvPV_nolen(TMenu_or_TSubMenu));
	    w = new TMenuBar(r,sm);
	} else {
	    croak("wrong inheritance in TVision::TMenuBar::new");
	}
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TMenuBar"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL

#if 0
MODULE=TVision::TEditWindow PACKAGE=TVision::TEditWindow
SV* new(int _ax, int ay, int bx, int by, char *title, int num)
    CODE:
        TRect r(_ax,ay,bx,by);
	TEditWindow *w = new TEditWindow(r,title,num);
        RETVAL = newSV(0);
	sv_setpvn(newSVrv(RETVAL, "TVision::TEditWindow"), (const char *)&w, sizeof(w));
    OUTPUT:
	RETVAL
#endif

MODULE=TVision::TDeskTop PACKAGE=TVision::TDeskTop
void
insert(SV *self, SV *what)
    CODE:
	TDeskTop* td = sv2tv_s(self,TDeskTop);
        SV *sv = SvRV(what);
        TWindow* w = *((TWindow**) SvPV_nolen(sv));
	//printf("sv=%016X, self=%016X what=%016X\n", sv, self,what);
	//printf("w=%016X, deskt=%016X\n", w, td);
	td->insert(w);

void
insert1(SV *self, SV *what)
    CODE:
	TDeskTop* td = (TDeskTop*)sv2tv_s(self,TDeskTop);
	TWindow* w = sv2tv_a(what);
	td->insert(w);

MODULE=TVision PACKAGE=TVision

void
Tcl_DESTROY(interp)
	SV *	interp
    CODE:
	/*
	TODO
	    TObject::destroy( demoProgram );
	*/
	if (initialized) {
	    /*
	     * Remove from the global hash of live interps.
	     */
	}

void
Tcl__Finalize(interp=NULL)
    CODE:
	/*
	 * This should be called from the END block - when we no
	 * longer plan to use Tcl *AT ALL*.
	 */
	if (!initialized) { return; }
	initialized = 0;

BOOT:
    {
    }
