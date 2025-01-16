package TVision;
our $VERSION=0.01;
require DynaLoader;
our @ISA = qw(DynaLoader);
__PACKAGE__->bootstrap;

=comment
The TVision package is a perl glue to turbovision library.

All the TVision::xxxx widgets are array refs, where first item at index 0
holds address of the underlying C++ object, 2nd TBD TODO TBD

Some widgets (TButton) has 'num' key, which is usually small integer for the
onCommand event. If 0 - then next availlable is taken.

examples:
=cut

package TVision::WidgetWithOnCommand;
# this isn't on classical turbovision, this package is the central place
# for widgets with onCommand capability

my %all_oncommands;
sub onCommand {
    my $self = shift;
    my $cb = shift; # now this should be CODE ref; could be sub name in future
    my $cmd_num = $self->num;
    if (exists $all_oncommands{$cmd_num}) {
	warn "duplicating onCommand item $cmd_num";
    }
    $all_oncommands{$cmd_num} = $cb;
}

package TVision::TVApp;
our @ISA = qw(TVision::TApplication);
package TVision::TApplication;
our $the_tapp;

sub init {
    $the_tapp->onCommand($TVision::TApplication::onCommand = sub {
	my ($cmd, $arg) = @_;
	if (exists $all_oncommands{$cmd}) {
	    $all_oncommands{$cmd}->(@_);
	} else {
	    print "command[@_] - not ours?\n";
	}
    });
}

package TVision::MsgBox;
package TVision::TApplication;
package TVision::TBackground;
package TVision::TButton;
#class TButton : public TView {
#[x]    TButton( const TRect& bounds, TStringView aTitle, ushort aCommand, ushort aFlags) noexcept;
#[ ]    virtual void draw();
#[ ]    void drawState( Boolean down );
#[ ]    virtual TPalette& getPalette() const;
#[ ]    virtual void handleEvent( TEvent& event );
#[ ]    void makeDefault( Boolean enable );
#[ ]    virtual void press();
#[ ]    virtual void setState( ushort aState, Boolean enable );
#[ ]    const char *title;
#[ ]protected:
#[ ]    ushort command;
#[ ]    uchar flags;
#[ ]    Boolean amDefault;
#};
our @ISA = qw(TVision::TView);

package TVision::TChDirDialog;
package TVision::TCheckBoxes;
#class TCheckBoxes : public TCluster {
#public:
#    TCheckBoxes( const TRect& bounds, TSItem *aStrings) noexcept;
#    virtual void draw();
#    virtual Boolean mark( int item );
#    virtual void press( int item );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TClipboard;
package TVision::TCluster;
package TVision::TCollection;
#class TCollection : public virtual TNSCollection, public TStreamable {
#public:
#    TCollection( ccIndex aLimit, ccIndex aDelta ) noexcept { delta = aDelta; setLimit( aLimit ); }
#    static const char * const _NEAR name;
#};
package TVision::TNSCollection;
#class TNSCollection : public TObject {
#public:
#    TNSCollection( ccIndex aLimit, ccIndex aDelta ) noexcept;
#    ~TNSCollection();
#    virtual void shutDown();
#    void *at( ccIndex index );
#    virtual ccIndex indexOf( void *item );
#    void atFree( ccIndex index );
#    void atRemove( ccIndex index );
#    void remove( void *item );
#    void removeAll();
#    void free( void *item );
#    void freeAll();
#    void atInsert( ccIndex index, void *item );
#    void atPut( ccIndex index, void *item );
#    virtual ccIndex insert( void *item );
#    virtual void error( ccIndex code, ccIndex info );
#    void *firstThat( ccTestFunc Test, void *arg );
#    void *lastThat( ccTestFunc Test, void *arg );
#    void forEach( ccAppFunc action, void *arg );
#    void pack();
#    virtual void setLimit( ccIndex aLimit );
#    ccIndex getCount() { return count; }
#protected:
#    TNSCollection() noexcept;
#    void **items;
#    ccIndex count;
#    ccIndex limit;
#    ccIndex delta;
#    Boolean shouldDelete;
#private:
#    virtual void freeItem( void *item );
#};
package TVision::TNSSortedCollection;

package TVision::TColorAttr;
package TVision::TColorDialog;
package TVision::TColorDisplay;
package TVision::TColorGroup;
package TVision::TColorGroupList;
package TVision::TColorItem;
package TVision::TColorItemList;
package TVision::TColorSelector;
package TVision::TCommandSet;
package TVision::TDeskTop;
our @ISA = qw(TVision::TGroup);
#class TDeskTop : public TGroup, public virtual TDeskInit {
#public:
#    TDeskTop( const TRect& ) noexcept;
#    void cascade( const TRect& );
#    virtual void handleEvent( TEvent& );
#    static TBackground *initBackground( TRect );
#    void tile( const TRect& );
#    virtual void tileError();
#    virtual void shutDown();
#    TBackground *background;
#};
package TVision::TDialog;
package TVision::TDirCollection;
package TVision::TDirEntry;
package TVision::TDirListBox;
package TVision::TDrawBuffer;
package TVision::TDrawSurface;
package TVision::TEditWindow;
#class TEditWindow : public TWindow { 
#public:
#    TEditWindow( const TRect&, TStringView, int ) noexcept;
#    virtual void close();
#    virtual const char *getTitle( short );
#    virtual void handleEvent( TEvent& );
#    virtual void sizeLimits( TPoint& min, TPoint& max );
#    TFileEditor *editor;
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TEditor;
our @ISA = qw(TVision::TView);
#class TEditor : public TView {
#public:
#    friend void genRefs();
#    TEditor( const TRect&, TScrollBar *, TScrollBar *, TIndicator *, uint ) noexcept;
#    virtual ~TEditor();
#    virtual void shutDown();
#    char bufChar( uint );
#    uint bufPtr( uint );
#    virtual void changeBounds( const TRect& );
#    virtual void convertEvent( TEvent& );
#    Boolean cursorVisible();
#    void deleteSelect();
#    virtual void doneBuffer();
#    virtual void draw();
#    virtual TPalette& getPalette() const;
#    virtual void handleEvent( TEvent& );
#    virtual void initBuffer();
#    virtual TMenuItem& initContextMenu( TPoint );
#    uint insertMultilineText( const char *, uint );
#    Boolean insertBuffer( const char *, uint, uint, Boolean, Boolean );
#    Boolean insertEOL( Boolean );
#    virtual Boolean insertFrom( TEditor * );
#    Boolean insertText( const void *, uint, Boolean );
#    void scrollTo( int, int );
#    Boolean search( const char *, ushort );
#    virtual Boolean setBufSize( uint );
#    void setCmdState( ushort, Boolean );
#    void setSelect( uint, uint, Boolean);
#    virtual void setState( ushort, Boolean );
#    void trackCursor( Boolean );
#    void undo();
#    virtual void updateCommands();
#    virtual Boolean valid( ushort );
#    int charPos( uint, uint );
#    uint charPtr( uint, int );
#    Boolean clipCopy();
#    void clipCut();
#    void clipPaste();
#    void deleteRange( uint, uint, Boolean );
#    void doUpdate();
#    void doSearchReplace();
#    void drawLines( int, int, uint );
#    void formatLine(TScreenCell *, uint, int, TAttrPair );
#    void find();
#    uint getMousePtr( TPoint );
#    Boolean hasSelection();
#    void hideSelect();
#    Boolean isClipboard();
#    uint lineEnd( uint );
#    uint lineMove( uint, int );
#    uint lineStart( uint );
#    uint indentedLineStart( uint );
#    void lock();
#    void newLine();
#    uint nextChar( uint );
#    uint nextLine( uint );
#    uint nextWord( uint );
#    uint prevChar( uint );
#    uint prevLine( uint );
#    uint prevWord( uint );
#    void replace();
#    void setBufLen( uint );
#    void setCurPtr( uint, uchar );
#    void startSelect();
#    void toggleEncoding();
#    void toggleInsMode();
#    void unlock();
#    void update( uchar );
#    void checkScrollBar( const TEvent&, TScrollBar *, int& );
#    void detectEol();
#    TScrollBar *hScrollBar;
#    TScrollBar *vScrollBar;
#    TIndicator *indicator;
#    char *buffer;
#    uint bufSize;
#    uint bufLen;
#    uint gapLen;
#    uint selStart;
#    uint selEnd;
#    uint curPtr;
#    TPoint curPos;
#    TPoint delta;
#    TPoint limit;
#    int drawLine;
#    uint drawPtr;
#    uint delCount;
#    uint insCount;
#    Boolean isValid;
#    Boolean canUndo;
#    Boolean modified;
#    Boolean selecting;
#    Boolean overwrite;
#    Boolean autoIndent;
#    enum EolType { eolCrLf, eolLf, eolCr } eolType;
#    enum Encoding { encDefault, encSingleByte } encoding;
#    void nextChar( TStringView, uint &P, uint &width );
#    Boolean formatCell( TSpan<TScreenCell>, uint&, TStringView, uint& , TColorAttr );
#    TStringView bufChars( uint );
#    TStringView prevBufChars( uint );
#    static TEditorDialog _NEAR editorDialog;
#    static ushort _NEAR editorFlags;
#    static char _NEAR findStr[maxFindStrLen];
#    static char _NEAR replaceStr[maxReplaceStrLen];
#    static TEditor * _NEAR clipboard;
#    uchar lockCount;
#    uchar updateFlags;
#    int keyState;
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::TMemo;
#class TMemo : public TEditor { 
#public:
#    TMemo( const TRect&, TScrollBar *, TScrollBar *, TIndicator *, ushort ) noexcept;
#    virtual void getData( void *rec );
#    virtual void setData( void *rec );
#    virtual ushort dataSize();
#    virtual TPalette& getPalette() const;
#    virtual void handleEvent( TEvent& );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::TFileEditor;
#class TFileEditor : public TEditor { 
#public: 
#    char fileName[MAXPATH];
#    TFileEditor( const TRect&, TScrollBar *, TScrollBar *, TIndicator *, TStringView) noexcept;
#    virtual void doneBuffer();
#    virtual void handleEvent( TEvent& );
#    virtual void initBuffer();
#    Boolean loadFile() noexcept;
#    Boolean save() noexcept;
#    Boolean saveAs() noexcept;
#    Boolean saveFile() noexcept;
#    virtual Boolean setBufSize( uint );
#    virtual void shutDown();
#    virtual void updateCommands();
#    virtual Boolean valid( ushort );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::EventCodes;
package TVision::TEvent;
#struct TEvent {
#    ushort what;
#    union {
#        MouseEventType mouse;
#        KeyDownEvent keyDown;
#        MessageEvent message;
#    };
#    void getMouseEvent() noexcept;
#    void getKeyEvent() noexcept;
#};
#struct CharScanType {
#    uchar charCode;
#    uchar scanCode;
#};
#struct KeyDownEvent {
#    union {
#        ushort keyCode;
#        CharScanType charScan;
#    };
#    ushort controlKeyState;
#    char text[maxCharSize];     // NOT null-terminated.
#    uchar textLength;
#    TStringView getText() const;
#    operator TKey() const;
#};
#inline TStringView KeyDownEvent::getText() const { return TStringView(text, textLength); }
#inline KeyDownEvent::operator TKey() const { return TKey(keyCode, controlKeyState); }
#struct MessageEvent {
#    ushort command;
#    union {
#        void *infoPtr;
#        int32_t infoLong;
#        ushort infoWord;
#        short infoInt;
#        uchar infoByte;
#        char infoChar;
#    };
#};

#/* Event codes */
#const int evMouseDown = 0x0001;
#const int evMouseUp   = 0x0002;
#const int evMouseMove = 0x0004;
#const int evMouseAuto = 0x0008;
#const int evMouseWheel= 0x0020;
#const int evKeyDown   = 0x0010;
#const int evCommand   = 0x0100;
#const int evBroadcast = 0x0200;
#/* Event masks */
#const int evNothing   = 0x0000;
#const int evMouse     = 0x002f;
#const int evKeyboard  = 0x0010;
#const int evMessage   = 0xFF00;
#/* Mouse button state masks */
#const int mbLeftButton  = 0x01;
#const int mbRightButton = 0x02;
#const int mbMiddleButton= 0x04;
#/* Mouse wheel state masks */
#const int mwUp      = 0x01;
#const int mwDown    = 0x02;
#const int mwLeft    = 0x04;
#const int mwRight   = 0x08;
#/* Mouse event flags */
#const int meMouseMoved = 0x01;
#const int meDoubleClick = 0x02;
#const int meTripleClick = 0x04;


package TVision::TEventQueue;
package TVision::TFileCollection;
package TVision::TFileDialog;
package TVision::TFileInfoPane;
package TVision::TFileInputLine;
package TVision::TInputLine;
our @ISA = qw(TVision::TView);
#class TInputLine : public TView {
#public:
#    TInputLine( const TRect& bounds, int limit, TValidator *aValid = 0, ushort limitMode = ilMaxBytes ) noexcept;
#    ~TInputLine();
#    virtual ushort dataSize();
#    virtual void draw();
#    virtual void getData( void *rec );
#    virtual TPalette& getPalette() const;
#    virtual void handleEvent( TEvent& event );
#    void selectAll( Boolean enable, Boolean scroll=True );
#    virtual void setData( void *rec );
#    virtual void setState( ushort aState, Boolean enable );
#    virtual Boolean valid( ushort cmd );
#    void setValidator( TValidator* aValid );
#    char* data;
#    int maxLen;
#    int maxWidth;
#    int maxChars;
#    int curPos;
#    int firstPos;
#    int selStart;
#    int selEnd;
#private:
#    Boolean canScroll( int delta );
#    int mouseDelta( TEvent& event );
#    int mousePos( TEvent& event );
#    int displayedPos( int pos );
#    void deleteSelect();
#    void deleteCurrent();
#    void adjustSelectBlock();
#    void saveState();
#    void restoreState();
#    Boolean checkValid(Boolean);
#    Boolean canUpdateCommands();
#    void setCmdState( ushort, Boolean );
#    void updateCommands();
#    static const char _NEAR rightArrow;
#    static const char _NEAR leftArrow;
#    virtual const char *streamableName() const { return name; }
#    TValidator* validator;
#    int anchor;
#    char* oldData;
#    int oldCurPos;
#    int oldFirstPos;
#    int oldSelStart;
#    int oldSelEnd;
#protected:
#    TInputLine( StreamableInit ) noexcept;
#    virtual void write( opstream& );
#    virtual void *read( ipstream& );
#public:
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};


package TVision::TFileList;
package TVision::TFilterValidator;
package TVision::TFindDialogRec;
package TVision::TFrame;
package TVision::TGroup;
our @ISA = qw(TVision::TView);
#class TGroup : public TView {
#public:
#[ ]    TGroup( const TRect& bounds ) noexcept;
#[ ]    ~TGroup();
#[ ]    virtual void shutDown();
#[ ]    ushort execView( TView *p ) noexcept;
#[ ]    virtual ushort execute();
#[ ]    virtual void awaken();
#[ ]    void insertView( TView *p, TView *Target ) noexcept;
#[ ]    void remove( TView *p );
#[ ]    void removeView( TView *p ) noexcept;
#[ ]    void resetCurrent();
#[ ]    void setCurrent( TView *p, selectMode mode );
#[ ]    void selectNext( Boolean forwards );
#[ ]    TView *firstThat( Boolean (*func)( TView *, void * ), void *args );
#[ ]    Boolean focusNext(Boolean forwards);
#[ ]    void forEach( void (*func)( TView *, void * ), void *args );
#[ ]    void insert( TView *p ) noexcept;
#[ ]    void insertBefore( TView *p, TView *Target );
#[ ]    TView *current;
#[ ]    TView *at( short index ) noexcept;
#[ ]    TView *firstMatch( ushort aState, ushort aOptions ) noexcept;
#[ ]    short indexOf( TView *p ) noexcept;
#[ ]    TView *first() noexcept;
#[ ]    virtual void setState( ushort aState, Boolean enable );
#[ ]    virtual void handleEvent( TEvent& event );
#[ ]    void drawSubViews( TView *p, TView *bottom ) noexcept;
#[ ]    virtual void changeBounds( const TRect& bounds );
#[ ]    virtual ushort dataSize();
#[ ]    virtual void getData( void *rec );
#[ ]    virtual void setData( void *rec );
#[ ]    virtual void draw();
#[ ]    void redraw() noexcept;
#[ ]    void lock() noexcept;
#[ ]    void unlock() noexcept;
#[ ]    virtual void resetCursor();
#[ ]    virtual void endModal( ushort command );
#[ ]    virtual void eventError( TEvent& event );
#[ ]    virtual ushort getHelpCtx();
#[ ]    virtual Boolean valid( ushort command );
#[ ]    void freeBuffer() noexcept;
#[ ]    void getBuffer() noexcept;
#[ ]    TView *last;
#[ ]    TRect clip;
#[ ]    phaseType phase;
#[ ]    TScreenCell *buffer;
#[ ]    uchar lockFlag;
#[ ]    ushort endState;
#[ ]private:
#[ ]    void focusView( TView *p, Boolean enable );
#[ ]    void selectView( TView *p, Boolean enable );
#[ ]    TView* findNext(Boolean forwards) noexcept;
#[ ]    virtual const char *streamableName() const { return name; }
#[ ]protected:
#[ ]    TGroup( StreamableInit ) noexcept;
#[ ]    virtual void write( opstream& );
#[ ]    virtual void *read( ipstream& );
#[ ]public:
#[ ]    static const char * const _NEAR name;
#[ ]    static TStreamable *build();
#[ ]};

package TVision::THardwareInfo;
package TVision::THistory;
package TVision::THistoryViewer;
package TVision::THistoryWindow;
package TVision::TIndicator;
#class TIndicator : public TView { 
#public:
#    TIndicator( const TRect& ) noexcept;
#    virtual void draw();
#    virtual TPalette& getPalette() const;
#    virtual void setState( ushort, Boolean );
#    void setValue( const TPoint&, Boolean );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::TKeys;
package TVision::TLabel;
our @ISA = qw(TVision::TStaticText);
#class TLabel : public TStaticText {
#[ ]public:
#[x]   TLabel( const TRect& bounds, TStringView aText, TView *aLink ) noexcept;
#[ ]    virtual void draw();
#[ ]    virtual TPalette& getPalette() const;
#[ ]    virtual void handleEvent( TEvent& event );
#[ ]    virtual void shutDown();
#[ ]    static const char * const _NEAR name;
#[ ]    static TStreamable *build();
#};

package TVision::TListBox;
#class TListBox : public TListViewer {
#public:
#    TListBox( const TRect& bounds, ushort aNumCols, TScrollBar *aScrollBar ) noexcept;
#    ~TListBox();
#    virtual ushort dataSize();
#    virtual void getData( void *rec );
#    virtual void getText( char *dest, short item, short maxLen );
#    virtual void newList( TCollection *aList );
#    virtual void setData( void *rec );
#    TCollection *list();
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TListViewer;
package TVision::TLookupValidator;

package TVision::TMenu;
#class TMenu { 
#public:
#    TMenu() noexcept : items(0), deflt(0) {};
#    TMenu( TMenuItem& itemList ) noexcept { items = &itemList; deflt = &itemList; }
#    TMenu( TMenuItem& itemList, TMenuItem& TheDefault ) noexcept { items = &itemList; deflt = &TheDefault; }
#    ~TMenu();
#    TMenuItem *items;
#    TMenuItem *deflt;
#};
package TVision::TMenuBar;
#class TMenuBar : public TMenuView {
#public:
#    TMenuBar( const TRect& bounds, TMenu *aMenu ) noexcept;
#    TMenuBar( const TRect& bounds, TSubMenu &aMenu ) noexcept;
#    ~TMenuBar();
#    virtual void draw();
#    virtual TRect getItemRect( TMenuItem *item );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TMenuBox;
#class TMenuBox : public TMenuView { 
#public:
#    TMenuBox( const TRect& bounds, TMenu *aMenu, TMenuView *aParentMenu) noexcept;
#    virtual void draw();
#    virtual TRect getItemRect( TMenuItem *item );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TMenuItem;
#class TMenuItem { 
#public:
#    TMenuItem( TStringView aName, ushort aCommand, TKey aKey, ushort aHelpCtx = hcNoContext, TStringView p = 0, TMenuItem *aNext = 0) noexcept;
#    TMenuItem( TStringView aName, TKey aKey, TMenu *aSubMenu, ushort aHelpCtx = hcNoContext, TMenuItem *aNext = 0) noexcept;
#    ~TMenuItem();
#    void append( TMenuItem *aNext ) noexcept;
#    TMenuItem *next;
#    const char *name;
#    ushort command;
#    Boolean disabled;
#    TKey keyCode;
#    ushort helpCtx;
#    union {
#        const char *param;
#        TMenu *subMenu;
#    };
#};
package TVision::TMenuPopup;
#class TMenuPopup : public TMenuBox { 
#public:
#    TMenuPopup(const TRect& bounds, TMenu *aMenu, TMenuView *aParent = 0) noexcept;
#    virtual ushort execute();
#    virtual void handleEvent(TEvent&);
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TMenuView;
#class TMenuView : public TView { 
#public:
#    TMenuView( const TRect& bounds, TMenu *aMenu, TMenuView *aParent = 0 ) noexcept;
#    TMenuView( const TRect& bounds ) noexcept;
#    virtual ushort execute();
#    TMenuItem *findItem( char ch );
#    virtual TRect getItemRect( TMenuItem *item );
#    virtual ushort getHelpCtx();
#    virtual TPalette& getPalette() const;
#    virtual void handleEvent( TEvent& event );
#    TMenuItem *hotKey( TKey key );
#    TMenuView *newSubView( const TRect& bounds, TMenu *aMenu, TMenuView *aParentMenu);
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::TSubMenu;
#class TSubMenu : public TMenuItem { 
#public:
#    TSubMenu( TStringView nm, TKey key, ushort helpCtx = hcNoContext ) noexcept;
#};



package TVision::TMonoSelector;
package TVision::TMultiCheckBoxes;
package TVision::TObject;
package TVision::TOutline;
package TVision::TOutlineViewer;
package TVision::TPReadObjects;
package TVision::TPWrittenObjects;
package TVision::TPXPictureValidator;
package TVision::TPalette;
package TVision::TParamText;
package TVision::TPoint;
#class TPoint { int x,y; };
package TVision::TProgram;
package TVision::TRadioButtons;
#class TRadioButtons : public TCluster {
#public:
#    TRadioButtons( const TRect& bounds, TSItem *aStrings ) noexcept;
#    virtual void draw();
#    virtual Boolean mark( int item );
#    virtual void movedTo( int item );
#    virtual void press( int item );
#    virtual void setData( void *rec );
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};

package TVision::TRangeValidator;
package TVision::TRect;
# class TRect { TPoint a, b; };
package TVision::TReplaceDialogRec;
package TVision::TResourceCollection;
package TVision::TResourceFile;
package TVision::TResourceItem;
package TVision::TSItem;
#class TSItem {
#public:
#    TSItem( TStringView aValue, TSItem *aNext ) noexcept { value = newStr(aValue); next = aNext; }
#    ~TSItem() { delete[] (char *) value; }
#    const char *value;
#    TSItem *next;
#};

package TVision::TScreen;
package TVision::TScreenCell;
package TVision::TScrollBar;
#// TScrollBar part codes
#    sbLeftArrow     = 0,
#    sbRightArrow    = 1,
#    sbPageLeft      = 2,
#    sbPageRight     = 3,
#    sbUpArrow       = 4,
#    sbDownArrow     = 5,
#    sbPageUp        = 6,
#    sbPageDown      = 7,
#    sbIndicator     = 8,
#// TScrollBar options for TWindow.StandardScrollBar
#    sbHorizontal    = 0x000,
#    sbVertical      = 0x001,
#    sbHandleKeyboard = 0x002,
#// TScrollBar messages
#    cmScrollBarChanged  = 53,
#    cmScrollBarClicked  = 54,
#class TScrollBar : public TView { 
#public:
#    TScrollBar( const TRect& bounds ) noexcept;
#    virtual void draw();
#    virtual TPalette& getPalette() const;
#    virtual void handleEvent( TEvent& event );
#    virtual void scrollDraw();
#    virtual int scrollStep( int part );
#    void setParams( int aValue, int aMin, int aMax, int aPgStep, int aArStep ) noexcept;
#    void setRange( int aMin, int aMax ) noexcept;
#    void setStep( int aPgStep, int aArStep ) noexcept;
#    void setValue( int aValue ) noexcept;
#    void drawPos( int pos ) noexcept;
#    int getPos() noexcept;
#    int getSize() noexcept;
#    int value;
#    TScrollChars chars;
#    int minVal;
#    int maxVal;
#    int pgStep;
#    int arStep;
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::TScroller;
package TVision::TSearchRec;
package TVision::TSortedCollection;
package TVision::TSortedListBox;
package TVision::TStaticText;
our @ISA = qw(TVision::TView);
#class TStaticText : public TView {
#[ ]public:
#[x]    TStaticText( const TRect& bounds, TStringView aText ) noexcept;
#[ ]    ~TStaticText();
#[ ]    virtual void draw();
#[ ]    virtual TPalette& getPalette() const;
#[ ]    virtual void getText( char * );
#[ ]protected:
#[ ]    const char *text;
#[ ]private:
#[ ]    virtual const char *streamableName() const { return name; }
#[ ]protected:
#[ ]    TStaticText( StreamableInit ) noexcept;
#[ ]    virtual void write( opstream& );
#[ ]    virtual void *read( ipstream& );
#[ ]public:
#[ ]    static const char * const _NEAR name;
#[ ]    static TStreamable *build();
#};


package TVision::TStatusDef;
package TVision::TStatusItem;
#class TStatusItem { 
#public:
#    TStatusItem( TStringView aText, TKey aKey, ushort cmd, TStatusItem *aNext = 0) noexcept;
#    ~TStatusItem();
#    TStatusItem *next;
#    char *text;
#    TKey keyCode;
#    ushort command;
#};

package TVision::TStatusLine;
package TVision::TStrIndexRec;
package TVision::TStrListMaker;
package TVision::TStreamable;
package TVision::TStreamableClass;
package TVision::TStreamableTypes;
package TVision::TStringCollection;
package TVision::TStringList;



package TVision::TStringLookupValidator;


#####IDK TODO
#class TStringView { 
#    // This class exists only to compensate for the lack of std::string_view
#    // in Borland C++. Unless you are programming for that compiler, you should
#    // always use std::string_view.
#    // Unlike std::string_view, TStringView can be constructed from a null pointer,
#    // for backward compatibility.
#    // TStringView is intercompatible with std::string_view, std::string and
#    // TSpan<const char>.
#    const char _FAR *str;
#    size_t len;
#public:
#    constexpr TStringView();
#              TStringView(const char _FAR *str);
#    constexpr TStringView(const char _FAR *str, size_t len);
#    constexpr TStringView(TSpan<char> span);
#    constexpr TStringView(TSpan<const char> span);
#    TStringView(const std::string &text);
#    operator std::string() const;
#    constexpr operator TSpan<const char>() const;
#    constexpr const char _FAR * data() const;
#    constexpr size_t size() const;
#    constexpr Boolean empty() const;
#    constexpr const char _FAR & operator[](size_t pos) const;
#    constexpr const char _FAR & front() const;
#    constexpr const char _FAR & back() const;
#    constexpr TStringView substr(size_t pos) const;
#    constexpr TStringView substr(size_t pos, size_t n) const;
#    constexpr const char _FAR * begin() const;
#    constexpr const char _FAR * cbegin() const;
#    constexpr const char _FAR * end() const;
#    constexpr const char _FAR * cend() const;
#};


package TVision::TSurfaceView;
package TVision::TSystemError;
package TVision::TTerminal;
package TVision::TText;
package TVision::TTextDevice;
package TVision::TTimerQueue;
package TVision::TVMemMgr;
package TVision::TValidator;
package TVision::TView;
#class TView : public TObject, public TStreamable {
#[ ]public:
#[ ]    friend void genRefs();
#[ ]    enum phaseType { phFocused, phPreProcess, phPostProcess };
#[ ]    enum selectMode{ normalSelect, enterSelect, leaveSelect };
#[ ]    TView( const TRect& bounds ) noexcept;
#[ ]    ~TView();
#[ ]    virtual void sizeLimits( TPoint& min, TPoint& max );
#[ ]    TRect getBounds() const noexcept;
#[ ]    TRect getExtent() const noexcept;
#[ ]    TRect getClipRect() const noexcept;
#[ ]    Boolean mouseInView( TPoint mouse ) noexcept;
#[ ]    Boolean containsMouse( TEvent& event ) noexcept;
#[x]    void locate( TRect& bounds );
#[ ]    virtual void dragView( TEvent& event, uchar mode,   //  temporary fix
#[ ]      TRect& limits, TPoint minSize, TPoint maxSize ); //  for Miller's stuff
#[ ]    virtual void calcBounds( TRect& bounds, TPoint delta );
#[ ]    virtual void changeBounds( const TRect& bounds );
#[ ]    void growTo( short x, short y );
#[ ]    void moveTo( short x, short y );
#[ ]    void setBounds( const TRect& bounds ) noexcept;
#[ ]    virtual ushort getHelpCtx();
#[ ]    virtual Boolean valid( ushort command );
#[ ]    void hide();
#[ ]    void show();
#[ ]    virtual void draw();
#[ ]    void drawView() noexcept;
#[ ]    Boolean exposed() noexcept;
#[x]    Boolean focus();
#[ ]    void hideCursor();
#[ ]    void drawHide( TView *lastView );
#[ ]    void drawShow( TView *lastView );
#[ ]    void drawUnderRect( TRect& r, TView *lastView );
#[ ]    void drawUnderView( Boolean doShadow, TView *lastView );
#[ ]    virtual ushort dataSize();
#[ ]    virtual void getData( void *rec );
#[ ]    virtual void setData( void *rec );
#[ ]    virtual void awaken();
#[x]    void blockCursor();
#[x]    void normalCursor();
#[x]    virtual void resetCursor();
#[x]    void setCursor( int x, int y ) noexcept;
#[x]    void showCursor();
#[x]    void drawCursor() noexcept;
#[ ]    void clearEvent( TEvent& event ) noexcept;
#[ ]    Boolean eventAvail();
#[ ]    virtual void getEvent( TEvent& event );
#[ ]    virtual void handleEvent( TEvent& event );
#[ ]    virtual void putEvent( TEvent& event );
#[ ]    static Boolean commandEnabled( ushort command ) noexcept;
#[ ]    static void disableCommands( TCommandSet& commands ) noexcept;
#[ ]    static void enableCommands( TCommandSet& commands ) noexcept;
#[ ]    static void disableCommand( ushort command ) noexcept;
#[ ]    static void enableCommand( ushort command ) noexcept;
#[ ]    static void getCommands( TCommandSet& commands ) noexcept;
#[ ]    static void setCommands( TCommandSet& commands ) noexcept;
#[ ]    static void setCmdState( TCommandSet& commands, Boolean enable ) noexcept;
#[ ]    virtual void endModal( ushort command );
#[ ]    virtual ushort execute();
#[ ]    TAttrPair getColor( ushort color ) noexcept;
#[ ]    virtual TPalette& getPalette() const;
#[ ]    virtual TColorAttr mapColor( uchar ) noexcept;
#[ ]    Boolean getState( ushort aState ) const noexcept;
#[ ]    void select();
#[ ]    virtual void setState( ushort aState, Boolean enable );
#[ ]    void getEvent( TEvent& event, int timeoutMs );
#[ ]    void keyEvent( TEvent& event );
#[ ]    Boolean mouseEvent( TEvent& event, ushort mask );
#[ ]    Boolean textEvent( TEvent &event, TSpan<char> dest, size_t &length );
#[ ]    virtual TTimerId setTimer( uint timeoutMs, int periodMs = -1 );
#[ ]    virtual void killTimer( TTimerId id );
#[ ]    TPoint makeGlobal( TPoint source ) noexcept;
#[ ]    TPoint makeLocal( TPoint source ) noexcept;
#[ ]    TView *nextView() noexcept;
#[ ]    TView *prevView() noexcept;
#[ ]    TView *prev() noexcept;
#[ ]    TView *next;
#[ ]    void makeFirst();
#[ ]    void putInFrontOf( TView *Target );
#[ ]    TView *TopView() noexcept;
#[ ]    void writeBuf(  short x, short y, short w, short h, const void _FAR* b ) noexcept;
#[ ]    void writeBuf(  short x, short y, short w, short h, const TDrawBuffer& b ) noexcept;
#[ ]    void writeChar( short x, short y, char c, uchar color, short count ) noexcept;
#[ ]    void writeLine( short x, short y, short w, short h, const TDrawBuffer& b ) noexcept;
#[ ]    void writeLine( short x, short y, short w, short h, const void _FAR *b ) noexcept;
#[ ]    void writeStr( short x, short y, const char *str, uchar color ) noexcept;
#[ ]    TPoint size;
#[ ]    ushort options;
#[ ]    ushort eventMask;
#[ ]    ushort state;
#[ ]    TPoint origin;
#[ ]    TPoint cursor;
#[ ]    uchar growMode;
#[ ]    uchar dragMode;
#[ ]    ushort helpCtx;
#[ ]    static Boolean _NEAR commandSetChanged;
#[ ]    TGroup *owner;
#[ ]    static Boolean _NEAR showMarkers;
#[ ]    static uchar _NEAR errorAttr;
#[ ]    virtual void shutDown();
#private:
#    void moveGrow( TPoint p, TPoint s, TRect& limits, TPoint minSize, TPoint maxSize, uchar mode);
#    void change( uchar, TPoint delta, TPoint& p, TPoint& s, ushort ctrlState ) noexcept;
#    static void writeView( write_args );
#    void writeView( short x, short y, short count, const void _FAR* b ) noexcept;
#    TPoint resizeBalance;
#    virtual const char *streamableName() const { return name; }
#protected:
#    TView( StreamableInit ) noexcept;
#public:
#    static const char * const _NEAR name;
#    static TStreamable *build();
#protected:
#    virtual void write( opstream& );
#    virtual void *read( ipstream& );
#};

package TVision::TWindow;
our @ISA = qw(TVision::TGroup);
#class TWindow: public TGroup, public virtual TWindowInit { 
#public:
#    TWindow( const TRect& bounds, TStringView aTitle, short aNumber) noexcept;
#    ~TWindow();
#    virtual void close();
#    virtual TPalette& getPalette() const;
#    virtual const char *getTitle( short maxSize );
#    virtual void handleEvent( TEvent& event );
#    static TFrame *initFrame( TRect );
#    virtual void setState( ushort aState, Boolean enable );
#    virtual void sizeLimits( TPoint& min, TPoint& max );
#    TScrollBar *standardScrollBar( ushort aOptions ) noexcept;
#    virtual void zoom();
#    virtual void shutDown();
#    uchar flags;
#    TRect zoomRect;
#    short number;
#    short palette;
#    TFrame *frame;
#    const char *title;
#    static const char * const _NEAR name;
#    static TStreamable *build();
#};
package TVision::ViewCommands;
package TVision::fpbase;
package TVision::fpstream;
package TVision::ifpstream;
package TVision::iopstream;
package TVision::ipstream;
package TVision::ofpstream;
package TVision::opstream;
package TVision::pstream;

1;

