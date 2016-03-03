require "XYGui/version"

module XYGui
	RT_CURSOR = 1
	RT_BITMAP = 2
	RT_ICON = 3
	RT_MENU = 4
	RT_DIALOG = 5
	RT_STRING = 6
	RT_FONTDIR = 7
	RT_FONT = 8
	RT_ACCELERATOR = 9
	RT_RCDATA = 10
	RT_MESSAGETABLE = 11
	DIFFERENCE = 11
	RT_VERSION = 16
	RT_DLGINCLUDE = 17
	RT_PLUGPLAY = 19
	RT_VXD = 20
	RT_ANICURSOR = 21
	RT_ANIICON = 22
	RT_HTML = 23
	RT_MANIFEST = 24
	SB_HORZ = 0
	SB_VERT = 1
	SB_CTL = 2
	SB_BOTH = 3
	SB_LINEUP = 0
	SB_LINELEFT = 0
	SB_LINEDOWN = 1
	SB_LINERIGHT = 1
	SB_PAGEUP = 2
	SB_PAGELEFT = 2
	SB_PAGEDOWN = 3
	SB_PAGERIGHT = 3
	SB_THUMBPOSITION = 4
	SB_THUMBTRACK = 5
	SB_TOP = 6
	SB_LEFT = 6
	SB_BOTTOM = 7
	SB_RIGHT = 7
	SB_ENDSCROLL = 8
	SW_HIDE = 0
	SW_SHOWNORMAL = 1
	SW_NORMAL = 1
	SW_SHOWMINIMIZED = 2
	SW_SHOWMAXIMIZED = 3
	SW_MAXIMIZE = 3
	SW_SHOWNOACTIVATE = 4
	SW_SHOW = 5
	SW_MINIMIZE = 6
	SW_SHOWMINNOACTIVE = 7
	SW_SHOWNA = 8
	SW_RESTORE = 9
	SW_SHOWDEFAULT = 10
	SW_FORCEMINIMIZE = 11
	SW_MAX = 11
	HIDE_WINDOW = 0
	SHOW_OPENWINDOW = 1
	SHOW_ICONWINDOW = 2
	SHOW_FULLSCREEN = 3
	SHOW_OPENNOACTIVATE = 4
	SW_PARENTCLOSING = 1
	SW_OTHERZOOM = 2
	SW_PARENTOPENING = 3
	SW_OTHERUNZOOM = 4
	AW_HOR_POSITIVE = 0x00000001
	AW_HOR_NEGATIVE = 0x00000002
	AW_VER_POSITIVE = 0x00000004
	AW_VER_NEGATIVE = 0x00000008
	AW_CENTER = 0x00000010
	AW_HIDE = 0x00010000
	AW_ACTIVATE = 0x00020000
	AW_SLIDE = 0x00040000
	AW_BLEND = 0x00080000
	KF_EXTENDED = 0x0100
	KF_DLGMODE = 0x0800
	KF_MENUMODE = 0x1000
	KF_ALTDOWN = 0x2000
	KF_REPEAT = 0x4000
	KF_UP = 0x8000
	VK_LBUTTON = 0x01
	VK_RBUTTON = 0x02
	VK_CANCEL = 0x03
	VK_MBUTTON = 0x04
	VK_XBUTTON1 = 0x05
	VK_XBUTTON2 = 0x06
	VK_BACK = 0x08
	VK_TAB = 0x09
	VK_CLEAR = 0x0C
	VK_RETURN = 0x0D
	VK_SHIFT = 0x10
	VK_CONTROL = 0x11
	VK_MENU = 0x12
	VK_PAUSE = 0x13
	VK_CAPITAL = 0x14
	VK_KANA = 0x15
	VK_HANGEUL = 0x15
	VK_HANGUL = 0x15
	VK_JUNJA = 0x17
	VK_FINAL = 0x18
	VK_HANJA = 0x19
	VK_KANJI = 0x19
	VK_ESCAPE = 0x1B
	VK_CONVERT = 0x1C
	VK_NONCONVERT = 0x1D
	VK_ACCEPT = 0x1E
	VK_MODECHANGE = 0x1F
	VK_SPACE = 0x20
	VK_PRIOR = 0x21
	VK_NEXT = 0x22
	VK_END = 0x23
	VK_HOME = 0x24
	VK_LEFT = 0x25
	VK_UP = 0x26
	VK_RIGHT = 0x27
	VK_DOWN = 0x28
	VK_SELECT = 0x29
	VK_PRINT = 0x2A
	VK_EXECUTE = 0x2B
	VK_SNAPSHOT = 0x2C
	VK_INSERT = 0x2D
	VK_DELETE = 0x2E
	VK_HELP = 0x2F
	VK_LWIN = 0x5B
	VK_RWIN = 0x5C
	VK_APPS = 0x5D
	VK_SLEEP = 0x5F
	VK_NUMPAD0 = 0x60
	VK_NUMPAD1 = 0x61
	VK_NUMPAD2 = 0x62
	VK_NUMPAD3 = 0x63
	VK_NUMPAD4 = 0x64
	VK_NUMPAD5 = 0x65
	VK_NUMPAD6 = 0x66
	VK_NUMPAD7 = 0x67
	VK_NUMPAD8 = 0x68
	VK_NUMPAD9 = 0x69
	VK_MULTIPLY = 0x6A
	VK_ADD = 0x6B
	VK_SEPARATOR = 0x6C
	VK_SUBTRACT = 0x6D
	VK_DECIMAL = 0x6E
	VK_DIVIDE = 0x6F
	VK_F1 = 0x70
	VK_F2 = 0x71
	VK_F3 = 0x72
	VK_F4 = 0x73
	VK_F5 = 0x74
	VK_F6 = 0x75
	VK_F7 = 0x76
	VK_F8 = 0x77
	VK_F9 = 0x78
	VK_F10 = 0x79
	VK_F11 = 0x7A
	VK_F12 = 0x7B
	VK_F13 = 0x7C
	VK_F14 = 0x7D
	VK_F15 = 0x7E
	VK_F16 = 0x7F
	VK_F17 = 0x80
	VK_F18 = 0x81
	VK_F19 = 0x82
	VK_F20 = 0x83
	VK_F21 = 0x84
	VK_F22 = 0x85
	VK_F23 = 0x86
	VK_F24 = 0x87
	VK_NUMLOCK = 0x90
	VK_SCROLL = 0x91
	VK_OEM_NEC_EQUAL = 0x92
	VK_OEM_FJ_JISHO = 0x92
	VK_OEM_FJ_MASSHOU = 0x93
	VK_OEM_FJ_TOUROKU = 0x94
	VK_OEM_FJ_LOYA = 0x95
	VK_OEM_FJ_ROYA = 0x96
	VK_LSHIFT = 0xA0
	VK_RSHIFT = 0xA1
	VK_LCONTROL = 0xA2
	VK_RCONTROL = 0xA3
	VK_LMENU = 0xA4
	VK_RMENU = 0xA5
	VK_BROWSER_BACK = 0xA6
	VK_BROWSER_FORWARD = 0xA7
	VK_BROWSER_REFRESH = 0xA8
	VK_BROWSER_STOP = 0xA9
	VK_BROWSER_SEARCH = 0xAA
	VK_BROWSER_FAVORITES = 0xAB
	VK_BROWSER_HOME = 0xAC
	VK_VOLUME_MUTE = 0xAD
	VK_VOLUME_DOWN = 0xAE
	VK_VOLUME_UP = 0xAF
	VK_MEDIA_NEXT_TRACK = 0xB0
	VK_MEDIA_PREV_TRACK = 0xB1
	VK_MEDIA_STOP = 0xB2
	VK_MEDIA_PLAY_PAUSE = 0xB3
	VK_LAUNCH_MAIL = 0xB4
	VK_LAUNCH_MEDIA_SELECT = 0xB5
	VK_LAUNCH_APP1 = 0xB6
	VK_LAUNCH_APP2 = 0xB7
	VK_OEM_1 = 0xBA
	VK_OEM_PLUS = 0xBB
	VK_OEM_COMMA = 0xBC
	VK_OEM_MINUS = 0xBD
	VK_OEM_PERIOD = 0xBE
	VK_OEM_2 = 0xBF
	VK_OEM_3 = 0xC0
	VK_OEM_4 = 0xDB
	VK_OEM_5 = 0xDC
	VK_OEM_6 = 0xDD
	VK_OEM_7 = 0xDE
	VK_OEM_8 = 0xDF
	VK_OEM_AX = 0xE1
	VK_OEM_102 = 0xE2
	VK_ICO_HELP = 0xE3
	VK_ICO_00 = 0xE4
	VK_PROCESSKEY = 0xE5
	VK_ICO_CLEAR = 0xE6
	VK_PACKET = 0xE7
	VK_OEM_RESET = 0xE9
	VK_OEM_JUMP = 0xEA
	VK_OEM_PA1 = 0xEB
	VK_OEM_PA2 = 0xEC
	VK_OEM_PA3 = 0xED
	VK_OEM_WSCTRL = 0xEE
	VK_OEM_CUSEL = 0xEF
	VK_OEM_ATTN = 0xF0
	VK_OEM_FINISH = 0xF1
	VK_OEM_COPY = 0xF2
	VK_OEM_AUTO = 0xF3
	VK_OEM_ENLW = 0xF4
	VK_OEM_BACKTAB = 0xF5
	VK_ATTN = 0xF6
	VK_CRSEL = 0xF7
	VK_EXSEL = 0xF8
	VK_EREOF = 0xF9
	VK_PLAY = 0xFA
	VK_ZOOM = 0xFB
	VK_NONAME = 0xFC
	VK_PA1 = 0xFD
	VK_OEM_CLEAR = 0xFE
	WH_MIN = -1
	WH_MSGFILTER = -1
	WH_JOURNALRECORD = 0
	WH_JOURNALPLAYBACK = 1
	WH_KEYBOARD = 2
	WH_GETMESSAGE = 3
	WH_CALLWNDPROC = 4
	WH_CBT = 5
	WH_SYSMSGFILTER = 6
	WH_MOUSE = 7
	WH_HARDWARE = 8
	WH_DEBUG = 9
	WH_SHELL = 10
	WH_FOREGROUNDIDLE = 11
	WH_CALLWNDPROCRET = 12
	WH_KEYBOARD_LL = 13
	WH_MOUSE_LL = 14
	WH_MAX = 14
	WH_MINHOOK = WH_MIN
	WH_MAXHOOK = WH_MAX
	HCBT_SETFOCUS = 9
	ACCESS_STICKYKEYS = 0x0001
	ACCESS_FILTERKEYS = 0x0002
	ACCESS_MOUSEKEYS = 0x0003
	INPUTLANGCHANGE_SYSCHARSET = 0x0001
	INPUTLANGCHANGE_FORWARD = 0x0002
	INPUTLANGCHANGE_BACKWARD = 0x0004
	KL_NAMELENGTH = 9
	GMMP_USE_DISPLAY_POINTS = 1
	GMMP_USE_HIGH_RESOLUTION_POINTS = 2
	CWF_CREATE_ONLY = 0x0001
	WSF_VISIBLE = 0x0001
	GWL_WNDPROC = -4
	GWL_HINSTANCE = -6
	GWL_HWNDPARENT = -8
	GWL_STYLE = -16
	GWL_EXSTYLE = -20
	GWL_USERDATA = -21
	GWL_ID = -12
	GWLP_WNDPROC = -4
	GWLP_HINSTANCE = -6
	GWLP_HWNDPARENT = -8
	GWLP_USERDATA = -21
	GWLP_ID = -12
	GCL_MENUNAME = -8
	GCL_HBRBACKGROUND = -10
	GCL_HCURSOR = -12
	GCL_HICON = -14
	GCL_HMODULE = -16
	GCL_CBWNDEXTRA = -18
	GCL_CBCLSEXTRA = -20
	GCL_WNDPROC = -24
	GCL_STYLE = -26
	GCW_ATOM = -32
	GCL_HICONSM = -34
	GCLP_MENUNAME = -8
	GCLP_HBRBACKGROUND = -10
	GCLP_HCURSOR = -12
	GCLP_HICON = -14
	GCLP_HMODULE = -16
	GCLP_WNDPROC = -24
	GCLP_HICONSM = -34
	WM_NULL = 0x0000
	WM_CREATE = 0x0001
	WM_DESTROY = 0x0002
	WM_MOVE = 0x0003
	WM_SIZE = 0x0005
	WM_ACTIVATE = 0x0006
	WA_INACTIVE = 0
	WA_ACTIVE = 1
	WA_CLICKACTIVE = 2
	WM_SETFOCUS = 0x0007
	WM_KILLFOCUS = 0x0008
	WM_ENABLE = 0x000A
	WM_SETREDRAW = 0x000B
	WM_SETTEXT = 0x000C
	WM_GETTEXT = 0x000D
	WM_GETTEXTLENGTH = 0x000E
	WM_PAINT = 0x000F
	WM_CLOSE = 0x0010
	WM_QUERYENDSESSION = 0x0011
	WM_QUERYOPEN = 0x0013
	WM_ENDSESSION = 0x0016
	WM_QUIT = 0x0012
	WM_ERASEBKGND = 0x0014
	WM_SYSCOLORCHANGE = 0x0015
	WM_SHOWWINDOW = 0x0018
	WM_WININICHANGE = 0x001A
	WM_SETTINGCHANGE = WM_WININICHANGE
	WM_DEVMODECHANGE = 0x001B
	WM_ACTIVATEAPP = 0x001C
	WM_FONTCHANGE = 0x001D
	WM_TIMECHANGE = 0x001E
	WM_CANCELMODE = 0x001F
	WM_SETCURSOR = 0x0020
	WM_MOUSEACTIVATE = 0x0021
	WM_CHILDACTIVATE = 0x0022
	WM_QUEUESYNC = 0x0023
	WM_GETMINMAXINFO = 0x0024
	WM_PAINTICON = 0x0026
	WM_ICONERASEBKGND = 0x0027
	WM_NEXTDLGCTL = 0x0028
	WM_SPOOLERSTATUS = 0x002A
	WM_DRAWITEM = 0x002B
	WM_MEASUREITEM = 0x002C
	WM_DELETEITEM = 0x002D
	WM_VKEYTOITEM = 0x002E
	WM_CHARTOITEM = 0x002F
	WM_SETFONT = 0x0030
	WM_GETFONT = 0x0031
	WM_SETHOTKEY = 0x0032
	WM_GETHOTKEY = 0x0033
	WM_QUERYDRAGICON = 0x0037
	WM_COMPAREITEM = 0x0039
	WM_GETOBJECT = 0x003D
	WM_COMPACTING = 0x0041
	WM_COMMNOTIFY = 0x0044
	WM_WINDOWPOSCHANGING = 0x0046
	WM_WINDOWPOSCHANGED = 0x0047
	WM_POWER = 0x0048
	WM_COPYDATA = 0x004A
	WM_CANCELJOURNAL = 0x004B
	WM_NOTIFY = 0x004E
	WM_INPUTLANGCHANGEREQUEST = 0x0050
	WM_INPUTLANGCHANGE = 0x0051
	WM_TCARD = 0x0052
	WM_HELP = 0x0053
	WM_USERCHANGED = 0x0054
	WM_NOTIFYFORMAT = 0x0055
	WM_CONTEXTMENU = 0x007B
	WM_STYLECHANGING = 0x007C
	WM_STYLECHANGED = 0x007D
	WM_DISPLAYCHANGE = 0x007E
	WM_GETICON = 0x007F
	WM_SETICON = 0x0080
	WM_NCCREATE = 0x0081
	WM_NCDESTROY = 0x0082
	WM_NCCALCSIZE = 0x0083
	WM_NCHITTEST = 0x0084
	WM_NCPAINT = 0x0085
	WM_NCACTIVATE = 0x0086
	WM_GETDLGCODE = 0x0087
	WM_SYNCPAINT = 0x0088
	WM_NCMOUSEMOVE = 0x00A0
	WM_NCLBUTTONDOWN = 0x00A1
	WM_NCLBUTTONUP = 0x00A2
	WM_NCLBUTTONDBLCLK = 0x00A3
	WM_NCRBUTTONDOWN = 0x00A4
	WM_NCRBUTTONUP = 0x00A5
	WM_NCRBUTTONDBLCLK = 0x00A6
	WM_NCMBUTTONDOWN = 0x00A7
	WM_NCMBUTTONUP = 0x00A8
	WM_NCMBUTTONDBLCLK = 0x00A9
	WM_NCXBUTTONDOWN = 0x00AB
	WM_NCXBUTTONUP = 0x00AC
	WM_NCXBUTTONDBLCLK = 0x00AD
	WM_INPUT = 0x00FF
	WM_KEYFIRST = 0x0100
	WM_KEYDOWN = 0x0100
	WM_KEYUP = 0x0101
	WM_CHAR = 0x0102
	WM_DEADCHAR = 0x0103
	WM_SYSKEYDOWN = 0x0104
	WM_SYSKEYUP = 0x0105
	WM_SYSCHAR = 0x0106
	WM_SYSDEADCHAR = 0x0107
	WM_UNICHAR = 0x0109
	WM_KEYLAST = 0x0109
	WM_IME_STARTCOMPOSITION = 0x010D
	WM_IME_ENDCOMPOSITION = 0x010E
	WM_IME_COMPOSITION = 0x010F
	WM_IME_KEYLAST = 0x010F
	WM_INITDIALOG = 0x0110
	WM_COMMAND = 0x0111
	WM_SYSCOMMAND = 0x0112
	WM_TIMER = 0x0113
	WM_HSCROLL = 0x0114
	WM_VSCROLL = 0x0115
	WM_INITMENU = 0x0116
	WM_INITMENUPOPUP = 0x0117
	WM_MENUSELECT = 0x011F
	WM_GESTURE = 0x0119
	WM_GESTURENOTIFY = 0x011A
	WM_MENUCHAR = 0x0120
	WM_ENTERIDLE = 0x0121
	WM_MENURBUTTONUP = 0x0122
	WM_MENUDRAG = 0x0123
	WM_MENUGETOBJECT = 0x0124
	WM_UNINITMENUPOPUP = 0x0125
	WM_MENUCOMMAND = 0x0126
	WM_CHANGEUISTATE = 0x0127
	WM_UPDATEUISTATE = 0x0128
	WM_QUERYUISTATE = 0x0129
	WM_CTLCOLORMSGBOX = 0x0132
	WM_CTLCOLOREDIT = 0x0133
	WM_CTLCOLORLISTBOX = 0x0134
	WM_CTLCOLORBTN = 0x0135
	WM_CTLCOLORDLG = 0x0136
	WM_CTLCOLORSCROLLBAR = 0x0137
	WM_CTLCOLORSTATIC = 0x0138
	MN_GETHMENU = 0x01E1
	WM_MOUSEFIRST = 0x0200
	WM_MOUSEMOVE = 0x0200
	WM_LBUTTONDOWN = 0x0201
	WM_LBUTTONUP = 0x0202
	WM_LBUTTONDBLCLK = 0x0203
	WM_RBUTTONDOWN = 0x0204
	WM_RBUTTONUP = 0x0205
	WM_RBUTTONDBLCLK = 0x0206
	WM_MBUTTONDOWN = 0x0207
	WM_MBUTTONUP = 0x0208
	WM_MBUTTONDBLCLK = 0x0209
	WM_MOUSEWHEEL = 0x020A
	WM_XBUTTONDOWN = 0x020B
	WM_XBUTTONUP = 0x020C
	WM_XBUTTONDBLCLK = 0x020D
	WM_MOUSELAST = 0x020D
	WM_MOUSEHWHEEL = 0x020E
	WHEEL_DELTA = 120
	WHEEL_PAGESCROLL = 4294967295
	XBUTTON1 = 0x0001
	XBUTTON2 = 0x0002
	WM_PARENTNOTIFY = 0x0210
	WM_ENTERMENULOOP = 0x0211
	WM_EXITMENULOOP = 0x0212
	WM_NEXTMENU = 0x0213
	WM_SIZING = 0x0214
	WM_CAPTURECHANGED = 0x0215
	WM_MOVING = 0x0216
	WM_POWERBROADCAST = 0x0218
	WM_DEVICECHANGE = 0x0219
	WM_MDICREATE = 0x0220
	WM_MDIDESTROY = 0x0221
	WM_MDIACTIVATE = 0x0222
	WM_MDIRESTORE = 0x0223
	WM_MDINEXT = 0x0224
	WM_MDIMAXIMIZE = 0x0225
	WM_MDITILE = 0x0226
	WM_MDICASCADE = 0x0227
	WM_MDIICONARRANGE = 0x0228
	WM_MDIGETACTIVE = 0x0229
	WM_MDISETMENU = 0x0230
	WM_ENTERSIZEMOVE = 0x0231
	WM_EXITSIZEMOVE = 0x0232
	WM_DROPFILES = 0x0233
	WM_MDIREFRESHMENU = 0x0234
	WM_IME_SETCONTEXT = 0x0281
	WM_IME_NOTIFY = 0x0282
	WM_IME_CONTROL = 0x0283
	WM_IME_COMPOSITIONFULL = 0x0284
	WM_IME_SELECT = 0x0285
	WM_IME_CHAR = 0x0286
	WM_IME_REQUEST = 0x0288
	WM_IME_KEYDOWN = 0x0290
	WM_IME_KEYUP = 0x0291
	WM_MOUSEHOVER = 0x02A1
	WM_MOUSELEAVE = 0x02A3
	WM_NCMOUSEHOVER = 0x02A0
	WM_NCMOUSELEAVE = 0x02A2
	WM_WTSSESSION_CHANGE = 0x02B1
	WM_TABLET_FIRST = 0x02c0
	WM_TABLET_LAST = 0x02df
	WM_CUT = 0x0300
	WM_COPY = 0x0301
	WM_PASTE = 0x0302
	WM_CLEAR = 0x0303
	WM_UNDO = 0x0304
	WM_RENDERFORMAT = 0x0305
	WM_RENDERALLFORMATS = 0x0306
	WM_DESTROYCLIPBOARD = 0x0307
	WM_DRAWCLIPBOARD = 0x0308
	WM_PAINTCLIPBOARD = 0x0309
	WM_VSCROLLCLIPBOARD = 0x030A
	WM_SIZECLIPBOARD = 0x030B
	WM_ASKCBFORMATNAME = 0x030C
	WM_CHANGECBCHAIN = 0x030D
	WM_HSCROLLCLIPBOARD = 0x030E
	WM_QUERYNEWPALETTE = 0x030F
	WM_PALETTEISCHANGING = 0x0310
	WM_PALETTECHANGED = 0x0311
	WM_HOTKEY = 0x0312
	WM_PRINT = 0x0317
	WM_PRINTCLIENT = 0x0318
	WM_APPCOMMAND = 0x0319
	WM_THEMECHANGED = 0x031A
	WM_HANDHELDFIRST = 0x0358
	WM_HANDHELDLAST = 0x035F
	WM_AFXFIRST = 0x0360
	WM_AFXLAST = 0x037F
	WM_PENWINFIRST = 0x0380
	WM_PENWINLAST = 0x038F
	WM_APP = 0x8000
	WM_USER = 0x0400
	SMTO_NORMAL = 0x0000
	SMTO_BLOCK = 0x0001
	SMTO_ABORTIFHUNG = 0x0002
	SMTO_NOTIMEOUTIFNOTHUNG = 0x0008
	MA_ACTIVATE = 1
	MA_ACTIVATEANDEAT = 2
	MA_NOACTIVATE = 3
	MA_NOACTIVATEANDEAT = 4
	ICON_SMALL = 0
	ICON_BIG = 1
	ICON_SMALL2 = 2
	MK_LBUTTON = 0x0001
	MK_RBUTTON = 0x0002
	MK_SHIFT = 0x0004
	MK_CONTROL = 0x0008
	MK_MBUTTON = 0x0010
	MK_XBUTTON1 = 0x0020
	MK_XBUTTON2 = 0x0040
	TME_HOVER = 0x00000001
	TME_LEAVE = 0x00000002
	TME_NONCLIENT = 0x00000010
	TME_QUERY = 0x40000000
	TME_CANCEL = 0x80000000
	HOVER_DEFAULT = 0xFFFFFFFF
	WS_OVERLAPPED = 0x00000000
	WS_POPUP = 0x80000000
	WS_CHILD = 0x40000000
	WS_MINIMIZE = 0x20000000
	WS_VISIBLE = 0x10000000
	WS_DISABLED = 0x08000000
	WS_CLIPSIBLINGS = 0x04000000
	WS_CLIPCHILDREN = 0x02000000
	WS_MAXIMIZE = 0x01000000
	WS_CAPTION = 0x00C00000
	WS_BORDER = 0x00800000
	WS_DLGFRAME = 0x00400000
	WS_VSCROLL = 0x00200000
	WS_HSCROLL = 0x00100000
	WS_SYSMENU = 0x00080000
	WS_THICKFRAME = 0x00040000
	WS_GROUP = 0x00020000
	WS_TABSTOP = 0x00010000
	WS_MINIMIZEBOX = 0x00020000
	WS_MAXIMIZEBOX = 0x00010000
	WS_TILED = WS_OVERLAPPED
	WS_ICONIC = WS_MINIMIZE
	WS_SIZEBOX = WS_THICKFRAME
	WS_TILEDWINDOW = WS_OVERLAPPED
	WS_CHILDWINDOW = WS_CHILD
	WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX)
	WS_EX_DLGMODALFRAME = 0x00000001
	WS_EX_NOPARENTNOTIFY = 0x00000004
	WS_EX_TOPMOST = 0x00000008
	WS_EX_ACCEPTFILES = 0x00000010
	WS_EX_TRANSPARENT = 0x00000020
	WS_EX_MDICHILD = 0x00000040
	WS_EX_TOOLWINDOW = 0x00000080
	WS_EX_WINDOWEDGE = 0x00000100
	WS_EX_CLIENTEDGE = 0x00000200
	WS_EX_CONTEXTHELP = 0x00000400
	WS_EX_RIGHT = 0x00001000
	WS_EX_LEFT = 0x00000000
	WS_EX_RTLREADING = 0x00002000
	WS_EX_LTRREADING = 0x00000000
	WS_EX_LEFTSCROLLBAR = 0x00004000
	WS_EX_RIGHTSCROLLBAR = 0x00000000
	WS_EX_CONTROLPARENT = 0x00010000
	WS_EX_STATICEDGE = 0x00020000
	WS_EX_APPWINDOW = 0x00040000
	WS_EX_LAYERED = 0x00080000
	WS_EX_NOINHERITLAYOUT = 0x00100000
	WS_EX_LAYOUTRTL = 0x00400000
	WS_EX_COMPOSITED = 0x02000000
	WS_EX_NOACTIVATE = 0x08000000
	CS_VREDRAW = 0x0001
	CS_HREDRAW = 0x0002
	CS_DBLCLKS = 0x0008
	CS_OWNDC = 0x0020
	CS_CLASSDC = 0x0040
	CS_PARENTDC = 0x0080
	CS_NOCLOSE = 0x0200
	CS_SAVEBITS = 0x0800
	CS_BYTEALIGNCLIENT = 0x1000
	CS_BYTEALIGNWINDOW = 0x2000
	CS_GLOBALCLASS = 0x4000
	CS_IME = 0x00010000
	CS_DROPSHADOW = 0x00020000
	PRF_CHECKVISIBLE = 0x00000001
	PRF_NONCLIENT = 0x00000002
	PRF_CLIENT = 0x00000004
	PRF_ERASEBKGND = 0x00000008
	PRF_CHILDREN = 0x00000010
	PRF_OWNED = 0x00000020
	BDR_RAISEDOUTER = 0x0001
	BDR_SUNKENOUTER = 0x0002
	BDR_RAISEDINNER = 0x0004
	BDR_SUNKENINNER = 0x0008
	BF_LEFT = 0x0001
	BF_TOP = 0x0002
	BF_RIGHT = 0x0004
	BF_BOTTOM = 0x0008
	BF_DIAGONAL = 0x0010
	BF_MIDDLE = 0x0800
	BF_SOFT = 0x1000
	BF_ADJUST = 0x2000
	BF_FLAT = 0x4000
	BF_MONO = 0x8000
	DC_ACTIVE = 0x0001
	DC_SMALLCAP = 0x0002
	DC_ICON = 0x0004
	DC_TEXT = 0x0008
	DC_INBUTTON = 0x0010
	DC_GRADIENT = 0x0020
	DC_BUTTONS = 0x1000
	IDANI_OPEN = 1
	IDANI_CAPTION = 3
	CF_TEXT = 1
	CF_BITMAP = 2
	CF_METAFILEPICT = 3
	CF_SYLK = 4
	CF_DIF = 5
	CF_TIFF = 6
	CF_OEMTEXT = 7
	CF_DIB = 8
	CF_PALETTE = 9
	CF_PENDATA = 10
	CF_RIFF = 11
	CF_WAVE = 12
	CF_UNICODETEXT = 13
	CF_ENHMETAFILE = 14
	CF_HDROP = 15
	CF_LOCALE = 16
	CF_DIBV5 = 17
	CF_MAX = 18
	CF_OWNERDISPLAY = 0x0080
	CF_DSPTEXT = 0x0081
	CF_DSPBITMAP = 0x0082
	CF_DSPMETAFILEPICT = 0x0083
	CF_DSPENHMETAFILE = 0x008E
	CF_PRIVATEFIRST = 0x0200
	CF_PRIVATELAST = 0x02FF
	CF_GDIOBJFIRST = 0x0300
	CF_GDIOBJLAST = 0x03FF
	FVIRTKEY = 1
	FNOINVERT = 0x02
	FSHIFT = 0x04
	FCONTROL = 0x08
	FALT = 0x10
	WPF_SETMINPOSITION = 0x0001
	WPF_RESTORETOMAXIMIZED = 0x0002
	WPF_ASYNCWINDOWPLACEMENT = 0x0004
	ODT_MENU = 1
	ODT_LISTBOX = 2
	ODT_COMBOBOX = 3
	ODT_BUTTON = 4
	ODT_STATIC = 5
	ODA_DRAWENTIRE = 0x0001
	ODA_SELECT = 0x0002
	ODA_FOCUS = 0x0004
	ODS_SELECTED = 0x0001
	ODS_GRAYED = 0x0002
	ODS_DISABLED = 0x0004
	ODS_CHECKED = 0x0008
	ODS_FOCUS = 0x0010
	ODS_DEFAULT = 0x0020
	ODS_COMBOBOXEDIT = 0x1000
	ODS_HOTLIGHT = 0x0040
	ODS_INACTIVE = 0x0080
	ODS_NOACCEL = 0x0100
	ODS_NOFOCUSRECT = 0x0200
	PM_NOREMOVE = 0x0000
	PM_REMOVE = 0x0001
	PM_NOYIELD = 0x0002
	MOD_ALT = 0x0001
	MOD_CONTROL = 0x0002
	MOD_SHIFT = 0x0004
	MOD_WIN = 0x0008
	MOD_NOREPEAT = 0x4000
	IDHOT_SNAPWINDOW = -1
	IDHOT_SNAPDESKTOP = -2
	ENDSESSION_LOGOFF = 0x80000000
	EWX_LOGOFF = 0
	EWX_SHUTDOWN = 0x00000001
	EWX_REBOOT = 0x00000002
	EWX_FORCE = 0x00000004
	EWX_POWEROFF = 0x00000008
	EWX_FORCEIFHUNG = 0x00000010
	BSM_ALLCOMPONENTS = 0x00000000
	BSM_VXDS = 0x00000001
	BSM_NETDRIVER = 0x00000002
	BSM_INSTALLABLEDRIVERS = 0x00000004
	BSM_APPLICATIONS = 0x00000008
	BSM_ALLDESKTOPS = 0x00000010
	BSF_QUERY = 0x00000001
	BSF_IGNORECURRENTTASK = 0x00000002
	BSF_FLUSHDISK = 0x00000004
	BSF_NOHANG = 0x00000008
	BSF_POSTMESSAGE = 0x00000010
	BSF_FORCEIFHUNG = 0x00000020
	BSF_NOTIMEOUTIFNOTHUNG = 0x00000040
	BSF_ALLOWSFW = 0x00000080
	BSF_SENDNOTIFYMESSAGE = 0x00000100
	BSF_RETURNHDESK = 0x00000200
	BSF_LUID = 0x00000400
	BROADCAST_QUERY_DENY = 0x424D5144
	DEVICE_NOTIFY_WINDOW_HANDLE = 0x00000000
	DEVICE_NOTIFY_SERVICE_HANDLE = 0x00000001
	DEVICE_NOTIFY_ALL_INTERFACE_CLASSES = 0x00000004
	HWND_BROADCAST = 0xffff
	HWND_MESSAGE = -3
	ISMEX_NOSEND = 0x00000000
	ISMEX_SEND = 0x00000001
	ISMEX_NOTIFY = 0x00000002
	ISMEX_CALLBACK = 0x00000004
	ISMEX_REPLIED = 0x00000008
	CW_USEDEFAULT = 0x80000000
	HWND_DESKTOP = 0
	PW_CLIENTONLY = 0x00000001
	LWA_COLORKEY = 0x00000001
	LWA_ALPHA = 0x00000002
	ULW_COLORKEY = 0x00000001
	ULW_ALPHA = 0x00000002
	ULW_OPAQUE = 0x00000004
	ULW_EX_NORESIZE = 0x00000008
	FLASHW_STOP = 0
	FLASHW_CAPTION = 0x00000001
	FLASHW_TRAY = 0x00000002
	FLASHW_TIMER = 0x00000004
	FLASHW_TIMERNOFG = 0x0000000C
	SWP_NOSIZE = 0x0001
	SWP_NOMOVE = 0x0002
	SWP_NOZORDER = 0x0004
	SWP_NOREDRAW = 0x0008
	SWP_NOACTIVATE = 0x0010
	SWP_FRAMECHANGED = 0x0020
	SWP_SHOWWINDOW = 0x0040
	SWP_HIDEWINDOW = 0x0080
	SWP_NOCOPYBITS = 0x0100
	SWP_NOOWNERZORDER = 0x0200
	SWP_NOSENDCHANGING = 0x0400
	SWP_DRAWFRAME = SWP_FRAMECHANGED
	SWP_NOREPOSITION = SWP_NOOWNERZORDER
	SWP_DEFERERASE = 0x2000
	SWP_ASYNCWINDOWPOS = 0x4000
	HWND_TOP = 0
	HWND_BOTTOM = 1
	HWND_TOPMOST = -1
	HWND_NOTOPMOST = -2
	DLGWINDOWEXTRA = 30
	KEYEVENTF_EXTENDEDKEY = 0x0001
	KEYEVENTF_KEYUP = 0x0002
	KEYEVENTF_UNICODE = 0x0004
	KEYEVENTF_SCANCODE = 0x0008
	MOUSEEVENTF_MOVE = 0x0001
	MOUSEEVENTF_LEFTDOWN = 0x0002
	MOUSEEVENTF_LEFTUP = 0x0004
	MOUSEEVENTF_RIGHTDOWN = 0x0008
	MOUSEEVENTF_RIGHTUP = 0x0010
	MOUSEEVENTF_MIDDLEDOWN = 0x0020
	MOUSEEVENTF_MIDDLEUP = 0x0040
	MOUSEEVENTF_XDOWN = 0x0080
	MOUSEEVENTF_XUP = 0x0100
	MOUSEEVENTF_WHEEL = 0x0800
	MOUSEEVENTF_VIRTUALDESK = 0x4000
	MOUSEEVENTF_ABSOLUTE = 0x8000
	INPUT_MOUSE = 0
	INPUT_KEYBOARD = 1
	INPUT_HARDWARE = 2
	USER_TIMER_MAXIMUM = 0x7FFFFFFF
	USER_TIMER_MINIMUM = 0x0000000A
	SM_CXSCREEN = 0
	SM_CYSCREEN = 1
	SM_CXVSCROLL = 2
	SM_CYHSCROLL = 3
	SM_CYCAPTION = 4
	SM_CXBORDER = 5
	SM_CYBORDER = 6
	SM_CXDLGFRAME = 7
	SM_CYDLGFRAME = 8
	SM_CYVTHUMB = 9
	SM_CXHTHUMB = 10
	SM_CXICON = 11
	SM_CYICON = 12
	SM_CXCURSOR = 13
	SM_CYCURSOR = 14
	SM_CYMENU = 15
	SM_CXFULLSCREEN = 16
	SM_CYFULLSCREEN = 17
	SM_CYKANJIWINDOW = 18
	SM_MOUSEPRESENT = 19
	SM_CYVSCROLL = 20
	SM_CXHSCROLL = 21
	SM_DEBUG = 22
	SM_SWAPBUTTON = 23
	SM_RESERVED1 = 24
	SM_RESERVED2 = 25
	SM_RESERVED3 = 26
	SM_RESERVED4 = 27
	SM_CXMIN = 28
	SM_CYMIN = 29
	SM_CXSIZE = 30
	SM_CYSIZE = 31
	SM_CXFRAME = 32
	SM_CYFRAME = 33
	SM_CXMINTRACK = 34
	SM_CYMINTRACK = 35
	SM_CXDOUBLECLK = 36
	SM_CYDOUBLECLK = 37
	SM_CXICONSPACING = 38
	SM_CYICONSPACING = 39
	SM_MENUDROPALIGNMENT = 40
	SM_PENWINDOWS = 41
	SM_DBCSENABLED = 42
	SM_CMOUSEBUTTONS = 43
	SM_CXFIXEDFRAME = SM_CXDLGFRAME
	SM_CYFIXEDFRAME = SM_CYDLGFRAME
	SM_CXSIZEFRAME = SM_CXFRAME
	SM_CYSIZEFRAME = SM_CYFRAME
	SM_SECURE = 44
	SM_CXEDGE = 45
	SM_CYEDGE = 46
	SM_CXMINSPACING = 47
	SM_CYMINSPACING = 48
	SM_CXSMICON = 49
	SM_CYSMICON = 50
	SM_CYSMCAPTION = 51
	SM_CXSMSIZE = 52
	SM_CYSMSIZE = 53
	SM_CXMENUSIZE = 54
	SM_CYMENUSIZE = 55
	SM_ARRANGE = 56
	SM_CXMINIMIZED = 57
	SM_CYMINIMIZED = 58
	SM_CXMAXTRACK = 59
	SM_CYMAXTRACK = 60
	SM_CXMAXIMIZED = 61
	SM_CYMAXIMIZED = 62
	SM_NETWORK = 63
	SM_CLEANBOOT = 67
	SM_CXDRAG = 68
	SM_CYDRAG = 69
	SM_SHOWSOUNDS = 70
	SM_CXMENUCHECK = 71
	SM_CYMENUCHECK = 72
	SM_SLOWMACHINE = 73
	SM_MIDEASTENABLED = 74
	SM_MOUSEWHEELPRESENT = 75
	SM_XVIRTUALSCREEN = 76
	SM_YVIRTUALSCREEN = 77
	SM_CXVIRTUALSCREEN = 78
	SM_CYVIRTUALSCREEN = 79
	SM_CMONITORS = 80
	SM_SAMEDISPLAYFORMAT = 81
	SM_IMMENABLED = 82
	SM_CXFOCUSBORDER = 83
	SM_CYFOCUSBORDER = 84
	SM_TABLETPC = 86
	SM_MEDIACENTER = 87
	SM_STARTER = 88
	SM_SERVERR2 = 89
	SM_CMETRICS = 90
	SM_REMOTESESSION = 0x1000
	SM_SHUTTINGDOWN = 0x2000
	SM_REMOTECONTROL = 0x2001
	SM_CARETBLINKINGENABLED = 0x2002
	SM_MOUSEHORIZONTALWHEELPRESENT = 91
	SM_CXPADDEDBORDER = 92
	SM_DIGITIZER = 94
	SM_MAXIMUMTOUCHES = 95
	SW_SCROLLCHILDREN = 0x0001
	SW_INVALIDATE = 0x0002
	SW_ERASE = 0x0004
	SW_SMOOTHSCROLL = 0x0010
	ESB_ENABLE_BOTH = 0x0000
	ESB_DISABLE_BOTH = 0x0003
	ESB_DISABLE_LEFT = 0x0001
	ESB_DISABLE_RIGHT = 0x0002
	ESB_DISABLE_UP = 0x0001
	ESB_DISABLE_DOWN = 0x0002
	ESB_DISABLE_LTUP = ESB_DISABLE_LEFT
	ESB_DISABLE_RTDN = ESB_DISABLE_RIGHT
	HELPINFO_WINDOW = 0x0001
	HELPINFO_MENUITEM = 0x0002
	MB_OK = 0x00000000
	MB_OKCANCEL = 0x00000001
	MB_ABORTRETRYIGNORE = 0x00000002
	MB_YESNOCANCEL = 0x00000003
	MB_YESNO = 0x00000004
	MB_RETRYCANCEL = 0x00000005
	MB_CANCELTRYCONTINUE = 0x00000006
	MB_ICONHAND = 0x00000010
	MB_ICONQUESTION = 0x00000020
	MB_ICONEXCLAMATION = 0x00000030
	MB_ICONASTERISK = 0x00000040
	MB_USERICON = 0x00000080
	MB_ICONWARNING = MB_ICONEXCLAMATION
	MB_ICONERROR = MB_ICONHAND
	MB_ICONINFORMATION = MB_ICONASTERISK
	MB_ICONSTOP = MB_ICONHAND
	MB_DEFBUTTON1 = 0x00000000
	MB_DEFBUTTON2 = 0x00000100
	MB_DEFBUTTON3 = 0x00000200
	MB_DEFBUTTON4 = 0x00000300
	MB_APPLMODAL = 0x00000000
	MB_SYSTEMMODAL = 0x00001000
	MB_TASKMODAL = 0x00002000
	MB_HELP = 0x00004000
	MB_NOFOCUS = 0x00008000
	MB_SETFOREGROUND = 0x00010000
	MB_DEFAULT_DESKTOP_ONLY = 0x00020000
	MB_TOPMOST = 0x00040000
	MB_RIGHT = 0x00080000
	MB_RTLREADING = 0x00100000
	MB_SERVICE_NOTIFICATION = 0x00200000
	MB_SERVICE_NOTIFICATION_NT3X = 0x00040000
	MB_TYPEMASK = 0x0000000F
	MB_ICONMASK = 0x000000F0
	MB_DEFMASK = 0x00000F00
	MB_MODEMASK = 0x00003000
	MB_MISCMASK = 0x0000C000
	CWP_ALL = 0x0000
	CWP_SKIPINVISIBLE = 0x0001
	CWP_SKIPDISABLED = 0x0002
	CWP_SKIPTRANSPARENT = 0x0004
	COLOR_SCROLLBAR = 0
	COLOR_BACKGROUND = 1
	COLOR_ACTIVECAPTION = 2
	COLOR_INACTIVECAPTION = 3
	COLOR_MENU = 4
	COLOR_WINDOW = 5
	COLOR_WINDOWFRAME = 6
	COLOR_MENUTEXT = 7
	COLOR_WINDOWTEXT = 8
	COLOR_CAPTIONTEXT = 9
	COLOR_ACTIVEBORDER = 10
	COLOR_INACTIVEBORDER = 11
	COLOR_APPWORKSPACE = 12
	COLOR_HIGHLIGHT = 13
	COLOR_HIGHLIGHTTEXT = 14
	COLOR_BTNFACE = 15
	COLOR_BTNSHADOW = 16
	COLOR_GRAYTEXT = 17
	COLOR_BTNTEXT = 18
	COLOR_INACTIVECAPTIONTEXT = 19
	COLOR_BTNHIGHLIGHT = 20
	COLOR_3DDKSHADOW = 21
	COLOR_3DLIGHT = 22
	COLOR_INFOTEXT = 23
	COLOR_INFOBK = 24
	COLOR_HOTLIGHT = 26
	COLOR_GRADIENTACTIVECAPTION = 27
	COLOR_GRADIENTINACTIVECAPTION = 28
	COLOR_MENUHILIGHT = 29
	COLOR_MENUBAR = 30
	COLOR_DESKTOP = COLOR_BACKGROUND
	COLOR_3DFACE = COLOR_BTNFACE
	COLOR_3DSHADOW = COLOR_BTNSHADOW
	COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT
	COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT
	COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT
	IDC_ARROW = 32512
	IDC_IBEAM = 32513
	IDC_WAIT = 32514
	IDC_CROSS = 32515
	IDC_UPARROW = 32516
	IDC_SIZE = 32640
	IDC_ICON = 32641
	IDC_SIZENWSE = 32642
	IDC_SIZENESW = 32643
	IDC_SIZEWE = 32644
	IDC_SIZENS = 32645
	IDC_SIZEALL = 32646
	IDC_NO = 32648
	IDC_HAND = 32649
	IDC_APPSTARTING = 32650
	IDC_HELP = 32651
	IMAGE_BITMAP = 0
	IMAGE_ICON = 1
	IMAGE_CURSOR = 2
	IMAGE_ENHMETAFILE = 3
	RES_ICON = 1
	RES_CURSOR = 2
	OCR_NORMAL = 32512
	OCR_IBEAM = 32513
	OCR_WAIT = 32514
	OCR_CROSS = 32515
	OCR_UP = 32516
	OCR_SIZE = 32640
	OCR_ICON = 32641
	OCR_SIZENWSE = 32642
	OCR_SIZENESW = 32643
	OCR_SIZEWE = 32644
	OCR_SIZENS = 32645
	OCR_SIZEALL = 32646
	OCR_ICOCUR = 32647
	OCR_NO = 32648
	OCR_HAND = 32649
	OCR_APPSTARTING = 32650
	IDI_APPLICATION = 32512
	IDI_HAND = 32513
	IDI_QUESTION = 32514
	IDI_EXCLAMATION = 32515
	IDI_ASTERISK = 32516
	IDI_WINLOGO = 32517
	IDI_WARNING = IDI_EXCLAMATION
	IDI_ERROR = IDI_HAND
	IDI_INFORMATION = IDI_ASTERISK
	IDOK = 1
	IDCANCEL = 2
	IDABORT = 3
	IDRETRY = 4
	IDIGNORE = 5
	IDYES = 6
	IDNO = 7
	IDCLOSE = 8
	IDHELP = 9
	IDTRYAGAIN = 10
	IDCONTINUE = 11
	IDTIMEOUT = 32000
	ES_LEFT = 0x0000
	ES_CENTER = 0x0001
	ES_RIGHT = 0x0002
	ES_MULTILINE = 0x0004
	ES_UPPERCASE = 0x0008
	ES_LOWERCASE = 0x0010
	ES_PASSWORD = 0x0020
	ES_AUTOVSCROLL = 0x0040
	ES_AUTOHSCROLL = 0x0080
	ES_NOHIDESEL = 0x0100
	ES_OEMCONVERT = 0x0400
	ES_READONLY = 0x0800
	ES_WANTRETURN = 0x1000
	ES_NUMBER = 0x2000
	EN_SETFOCUS = 0x0100
	EN_KILLFOCUS = 0x0200
	EN_CHANGE = 0x0300
	EN_UPDATE = 0x0400
	EN_ERRSPACE = 0x0500
	EN_MAXTEXT = 0x0501
	EN_HSCROLL = 0x0601
	EN_VSCROLL = 0x0602
	EN_ALIGN_LTR_EC = 0x0700
	EN_ALIGN_RTL_EC = 0x0701
	EC_LEFTMARGIN = 0x0001
	EC_RIGHTMARGIN = 0x0002
	EC_USEFONTINFO = 0xffff
	EMSIS_COMPOSITIONSTRING = 0x0001
	EIMES_GETCOMPSTRATONCE = 0x0001
	EIMES_CANCELCOMPSTRINFOCUS = 0x0002
	EIMES_COMPLETECOMPSTRKILLFOCUS = 0x0004
	EM_GETSEL = 0x00B0
	EM_SETSEL = 0x00B1
	EM_GETRECT = 0x00B2
	EM_SETRECT = 0x00B3
	EM_SETRECTNP = 0x00B4
	EM_SCROLL = 0x00B5
	EM_LINESCROLL = 0x00B6
	EM_SCROLLCARET = 0x00B7
	EM_GETMODIFY = 0x00B8
	EM_SETMODIFY = 0x00B9
	EM_GETLINECOUNT = 0x00BA
	EM_LINEINDEX = 0x00BB
	EM_SETHANDLE = 0x00BC
	EM_GETHANDLE = 0x00BD
	EM_GETTHUMB = 0x00BE
	EM_LINELENGTH = 0x00C1
	EM_REPLACESEL = 0x00C2
	EM_GETLINE = 0x00C4
	EM_LIMITTEXT = 0x00C5
	EM_CANUNDO = 0x00C6
	EM_UNDO = 0x00C7
	EM_FMTLINES = 0x00C8
	EM_LINEFROMCHAR = 0x00C9
	EM_SETTABSTOPS = 0x00CB
	EM_SETPASSWORDCHAR = 0x00CC
	EM_EMPTYUNDOBUFFER = 0x00CD
	EM_GETFIRSTVISIBLELINE = 0x00CE
	EM_SETREADONLY = 0x00CF
	EM_SETWORDBREAKPROC = 0x00D0
	EM_GETWORDBREAKPROC = 0x00D1
	EM_GETPASSWORDCHAR = 0x00D2
	EM_SETMARGINS = 0x00D3
	EM_GETMARGINS = 0x00D4
	EM_SETLIMITTEXT = EM_LIMITTEXT
	EM_GETLIMITTEXT = 0x00D5
	EM_POSFROMCHAR = 0x00D6
	EM_CHARFROMPOS = 0x00D7
	EM_SETIMESTATUS = 0x00D8
	EM_GETIMESTATUS = 0x00D9
	WB_LEFT = 0
	WB_RIGHT = 1
	WB_ISDELIMITER = 2
	BS_PUSHBUTTON = 0x00000000
	BS_DEFPUSHBUTTON = 0x00000001
	BS_CHECKBOX = 0x00000002
	BS_AUTOCHECKBOX = 0x00000003
	BS_RADIOBUTTON = 0x00000004
	BS_3STATE = 0x00000005
	BS_AUTO3STATE = 0x00000006
	BS_GROUPBOX = 0x00000007
	BS_USERBUTTON = 0x00000008
	BS_AUTORADIOBUTTON = 0x00000009
	BS_PUSHBOX = 0x0000000A
	BS_OWNERDRAW = 0x0000000B
	BS_TYPEMASK = 0x0000000F
	BS_LEFTTEXT = 0x00000020
	BS_TEXT = 0x00000000
	BS_ICON = 0x00000040
	BS_BITMAP = 0x00000080
	BS_LEFT = 0x00000100
	BS_RIGHT = 0x00000200
	BS_CENTER = 0x00000300
	BS_TOP = 0x00000400
	BS_BOTTOM = 0x00000800
	BS_VCENTER = 0x00000C00
	BS_PUSHLIKE = 0x00001000
	BS_MULTILINE = 0x00002000
	BS_NOTIFY = 0x00004000
	BS_FLAT = 0x00008000
	BS_RIGHTBUTTON = BS_LEFTTEXT
	BN_CLICKED = 0
	BN_PAINT = 1
	BN_HILITE = 2
	BN_UNHILITE = 3
	BN_DISABLE = 4
	BN_DOUBLECLICKED = 5
	BN_PUSHED = BN_HILITE
	BN_UNPUSHED = BN_UNHILITE
	BN_DBLCLK = BN_DOUBLECLICKED
	BN_SETFOCUS = 6
	BN_KILLFOCUS = 7
	BM_GETCHECK = 0x00F0
	BM_SETCHECK = 0x00F1
	BM_GETSTATE = 0x00F2
	BM_SETSTATE = 0x00F3
	BM_SETSTYLE = 0x00F4
	BM_CLICK = 0x00F5
	BM_GETIMAGE = 0x00F6
	BM_SETIMAGE = 0x00F7
	BST_UNCHECKED = 0x0000
	BST_CHECKED = 0x0001
	BST_INDETERMINATE = 0x0002
	BST_PUSHED = 0x0004
	BST_FOCUS = 0x0008
	SS_LEFT = 0x00000000
	SS_CENTER = 0x00000001
	SS_RIGHT = 0x00000002
	SS_ICON = 0x00000003
	SS_BLACKRECT = 0x00000004
	SS_GRAYRECT = 0x00000005
	SS_WHITERECT = 0x00000006
	SS_BLACKFRAME = 0x00000007
	SS_GRAYFRAME = 0x00000008
	SS_WHITEFRAME = 0x00000009
	SS_USERITEM = 0x0000000A
	SS_SIMPLE = 0x0000000B
	SS_LEFTNOWORDWRAP = 0x0000000C
	SS_OWNERDRAW = 0x0000000D
	SS_BITMAP = 0x0000000E
	SS_ENHMETAFILE = 0x0000000F
	SS_ETCHEDHORZ = 0x00000010
	SS_ETCHEDVERT = 0x00000011
	SS_ETCHEDFRAME = 0x00000012
	SS_TYPEMASK = 0x0000001F
	SS_REALSIZECONTROL = 0x00000040
	SS_NOPREFIX = 0x00000080
	SS_NOTIFY = 0x00000100
	SS_CENTERIMAGE = 0x00000200
	SS_RIGHTJUST = 0x00000400
	SS_REALSIZEIMAGE = 0x00000800
	SS_SUNKEN = 0x00001000
	SS_EDITCONTROL = 0x00002000
	SS_ENDELLIPSIS = 0x00004000
	SS_PATHELLIPSIS = 0x00008000
	SS_WORDELLIPSIS = 0x0000C000
	SS_ELLIPSISMASK = 0x0000C000
	STM_SETICON = 0x0170
	STM_GETICON = 0x0171
	STM_SETIMAGE = 0x0172
	STM_GETIMAGE = 0x0173
	STN_CLICKED = 0
	STN_DBLCLK = 1
	STN_ENABLE = 2
	STN_DISABLE = 3
	STM_MSGMAX = 0x0174
	WC_DIALOG = 0x8002
	DWL_MSGRESULT = 0
	DWL_DLGPROC = 4
	DWL_USER = 8
	DWLP_MSGRESULT = 0
	DS_ABSALIGN = 0x01
	DS_SYSMODAL = 0x02
	DS_LOCALEDIT = 0x20
	DS_SETFONT = 0x40
	DS_MODALFRAME = 0x80
	DS_NOIDLEMSG = 0x100
	DS_SETFOREGROUND = 0x200
	DS_3DLOOK = 0x0004
	DS_FIXEDSYS = 0x0008
	DS_NOFAILCREATE = 0x0010
	DS_CONTROL = 0x0400
	DS_CENTER = 0x0800
	DS_CENTERMOUSE = 0x1000
	DS_CONTEXTHELP = 0x2000
	DS_USEPIXELS = 0x8000
	DM_GETDEFID = WM_USER+0
	DM_SETDEFID = WM_USER+1
	DM_REPOSITION = WM_USER+2
	DC_HASDEFID = 0x534B
	DLGC_WANTARROWS = 0x0001
	DLGC_WANTTAB = 0x0002
	DLGC_WANTALLKEYS = 0x0004
	DLGC_WANTMESSAGE = 0x0004
	DLGC_HASSETSEL = 0x0008
	DLGC_DEFPUSHBUTTON = 0x0010
	DLGC_UNDEFPUSHBUTTON = 0x0020
	DLGC_RADIOBUTTON = 0x0040
	DLGC_WANTCHARS = 0x0080
	DLGC_STATIC = 0x0100
	DLGC_BUTTON = 0x2000
	LB_CTLCODE = 0
	LB_OKAY = 0
	LB_ERR = -1
	LB_ERRSPACE = -2
	LBN_ERRSPACE = -2
	LBN_SELCHANGE = 1
	LBN_DBLCLK = 2
	LBN_SELCANCEL = 3
	LBN_SETFOCUS = 4
	LBN_KILLFOCUS = 5
	LB_ADDSTRING = 0x0180
	LB_INSERTSTRING = 0x0181
	LB_DELETESTRING = 0x0182
	LB_SELITEMRANGEEX = 0x0183
	LB_RESETCONTENT = 0x0184
	LB_SETSEL = 0x0185
	LB_SETCURSEL = 0x0186
	LB_GETSEL = 0x0187
	LB_GETCURSEL = 0x0188
	LB_GETTEXT = 0x0189
	LB_GETTEXTLEN = 0x018A
	LB_GETCOUNT = 0x018B
	LB_SELECTSTRING = 0x018C
	LB_DIR = 0x018D
	LB_GETTOPINDEX = 0x018E
	LB_FINDSTRING = 0x018F
	LB_GETSELCOUNT = 0x0190
	LB_GETSELITEMS = 0x0191
	LB_SETTABSTOPS = 0x0192
	LB_GETHORIZONTALEXTENT = 0x0193
	LB_SETHORIZONTALEXTENT = 0x0194
	LB_SETCOLUMNWIDTH = 0x0195
	LB_ADDFILE = 0x0196
	LB_SETTOPINDEX = 0x0197
	LB_GETITEMRECT = 0x0198
	LB_GETITEMDATA = 0x0199
	LB_SETITEMDATA = 0x019A
	LB_SELITEMRANGE = 0x019B
	LB_SETANCHORINDEX = 0x019C
	LB_GETANCHORINDEX = 0x019D
	LB_SETCARETINDEX = 0x019E
	LB_GETCARETINDEX = 0x019F
	LB_SETITEMHEIGHT = 0x01A0
	LB_GETITEMHEIGHT = 0x01A1
	LB_FINDSTRINGEXACT = 0x01A2
	LB_SETLOCALE = 0x01A5
	LB_GETLOCALE = 0x01A6
	LB_SETCOUNT = 0x01A7
	LB_INITSTORAGE = 0x01A8
	LB_ITEMFROMPOINT = 0x01A9
	LB_MULTIPLEADDSTRING = 0x01B1
	LB_GETLISTBOXINFO = 0x01B2
	LB_MSGMAX = 0x01B3
	LBS_NOTIFY = 0x0001
	LBS_SORT = 0x0002
	LBS_NOREDRAW = 0x0004
	LBS_MULTIPLESEL = 0x0008
	LBS_OWNERDRAWFIXED = 0x0010
	LBS_OWNERDRAWVARIABLE = 0x0020
	LBS_HASSTRINGS = 0x0040
	LBS_USETABSTOPS = 0x0080
	LBS_NOINTEGRALHEIGHT = 0x0100
	LBS_MULTICOLUMN = 0x0200
	LBS_WANTKEYBOARDINPUT = 0x0400
	LBS_EXTENDEDSEL = 0x0800
	LBS_DISABLENOSCROLL = 0x1000
	LBS_NODATA = 0x2000
	LBS_NOSEL = 0x4000
	LBS_COMBOBOX = 0x8000
	CB_OKAY = 0
	CB_ERR = -1
	CB_ERRSPACE = -2
	CBN_ERRSPACE = -1
	CBN_SELCHANGE = 1
	CBN_DBLCLK = 2
	CBN_SETFOCUS = 3
	CBN_KILLFOCUS = 4
	CBN_EDITCHANGE = 5
	CBN_EDITUPDATE = 6
	CBN_DROPDOWN = 7
	CBN_CLOSEUP = 8
	CBN_SELENDOK = 9
	CBN_SELENDCANCEL = 10
	CBS_SIMPLE = 0x0001
	CBS_DROPDOWN = 0x0002
	CBS_DROPDOWNLIST = 0x0003
	CBS_OWNERDRAWFIXED = 0x0010
	CBS_OWNERDRAWVARIABLE = 0x0020
	CBS_AUTOHSCROLL = 0x0040
	CBS_OEMCONVERT = 0x0080
	CBS_SORT = 0x0100
	CBS_HASSTRINGS = 0x0200
	CBS_NOINTEGRALHEIGHT = 0x0400
	CBS_DISABLENOSCROLL = 0x0800
	CBS_UPPERCASE = 0x2000
	CBS_LOWERCASE = 0x4000
	CB_GETEDITSEL = 0x0140
	CB_LIMITTEXT = 0x0141
	CB_SETEDITSEL = 0x0142
	CB_ADDSTRING = 0x0143
	CB_DELETESTRING = 0x0144
	CB_DIR = 0x0145
	CB_GETCOUNT = 0x0146
	CB_GETCURSEL = 0x0147
	CB_GETLBTEXT = 0x0148
	CB_GETLBTEXTLEN = 0x0149
	CB_INSERTSTRING = 0x014A
	CB_RESETCONTENT = 0x014B
	CB_FINDSTRING = 0x014C
	CB_SELECTSTRING = 0x014D
	CB_SETCURSEL = 0x014E
	CB_SHOWDROPDOWN = 0x014F
	CB_GETITEMDATA = 0x0150
	CB_SETITEMDATA = 0x0151
	CB_GETDROPPEDCONTROLRECT = 0x0152
	CB_SETITEMHEIGHT = 0x0153
	CB_GETITEMHEIGHT = 0x0154
	CB_SETEXTENDEDUI = 0x0155
	CB_GETEXTENDEDUI = 0x0156
	CB_GETDROPPEDSTATE = 0x0157
	CB_FINDSTRINGEXACT = 0x0158
	CB_SETLOCALE = 0x0159
	CB_GETLOCALE = 0x015A
	CB_GETTOPINDEX = 0x015b
	CB_SETTOPINDEX = 0x015c
	CB_GETHORIZONTALEXTENT = 0x015d
	CB_SETHORIZONTALEXTENT = 0x015e
	CB_GETDROPPEDWIDTH = 0x015f
	CB_SETDROPPEDWIDTH = 0x0160
	CB_INITSTORAGE = 0x0161
	CB_MULTIPLEADDSTRING = 0x0163
	CB_GETCOMBOBOXINFO = 0x0164
	CB_MSGMAX = 0x0165
	SBS_HORZ = 0x0000
	SBS_VERT = 0x0001
	SBS_TOPALIGN = 0x0002
	SBS_LEFTALIGN = 0x0002
	SBS_BOTTOMALIGN = 0x0004
	SBS_RIGHTALIGN = 0x0004
	SBS_SIZEBOXTOPLEFTALIGN = 0x0002
	SBS_SIZEBOXBOTTOMRIGHTALIGN = 0x0004
	SBS_SIZEBOX = 0x0008
	SBS_SIZEGRIP = 0x0010
	SBM_SETPOS = 0x00E0
	SBM_GETPOS = 0x00E1
	SBM_SETRANGE = 0x00E2
	SBM_SETRANGEREDRAW = 0x00E6
	SBM_GETRANGE = 0x00E3
	SBM_ENABLE_ARROWS = 0x00E4
	SBM_SETSCROLLINFO = 0x00E9
	SBM_GETSCROLLINFO = 0x00EA
	SBM_GETSCROLLBARINFO = 0x00EB
	SIF_RANGE = 0x0001
	SIF_PAGE = 0x0002
	SIF_POS = 0x0004
	SIF_DISABLENOSCROLL = 0x0008
	SIF_TRACKPOS = 0x0010
	MDIS_ALLCHILDSTYLES = 0x0001
	WS_ACTIVECAPTION = 0x0001
	RI_KEY_MAKE = 0
	RI_KEY_BREAK = 1
	RI_KEY_E0 = 2
	RI_KEY_E1 = 4
	RI_KEY_TERMSRV_SET_LED = 8
	RI_KEY_TERMSRV_SHADOW = 0x10
	WM_TOUCHMOVE = 576
	WM_TOUCHDOWN = 577
	WM_TOUCHUP = 578
end
