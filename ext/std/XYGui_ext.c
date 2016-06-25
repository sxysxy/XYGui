#if 0  
	I like IF 0 hhhh
	
	Native Extension for XYGui (Win32 Version)
	
	sxysxy 2016.04.20
	
#endif

#include "ruby.h"
#include <windows.h>
#include <commctrl.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C"
{
#endif

// ---------------------- Global Area ------------------------------------------
#if 1
#define XYWidgetCall(sig, arg1, arg2) (rb_funcall(self, rb_intern("call"), \
						3, ID2SYM(rb_intern(sig)), arg1, arg2))
					
#define WM_XYGUI_RQ (WM_USER + 233)

#endif 
// ---------------------- End Global Area --------------------------------------


// ---------------------- For XYApp -----------------------------------------------
#if 1
// #if 1 here, and your code editor may be able to fold these code
static VALUE cXYApp;
static const char *XYAppClassName = "XYApp";
// WndProc, Defined in XYWindow Ext
static LRESULT CALLBACK XYWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
static VALUE XYApp_registerClass(VALUE self)
{
	WNDCLASS wc;
	RtlZeroMemory(&wc, sizeof(wc));
	wc.lpfnWndProc = XYWndProc;                                 // XYWndProc !
	wc.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
	wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.lpszClassName = RSTRING_PTR(rb_iv_get(self, "@name"));
	wc.hInstance = GetModuleHandle(NULL);
	wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
	RegisterClass(&wc);
	return self;
}
  //#----
#define GEN_ERROR_LOG(s) MessageBox(0, "Sorry, An unexpectd exception occurred: "s" Abort", "XYGui Exception", 0) 

long WINAPI XYApp_excpHandler(PEXCEPTION_POINTERS exceptionInfo)
{
	switch(exceptionInfo -> ExceptionRecord -> ExceptionCode)
	{
		case STATUS_ACCESS_VIOLATION:
			GEN_ERROR_LOG("Access Violation");
			break;
		case STATUS_NO_MEMORY:
			GEN_ERROR_LOG("Lack of memory");
			break;
		case STATUS_IN_PAGE_ERROR:
			GEN_ERROR_LOG("Page fault");
			break;
		case STATUS_FLOAT_DIVIDE_BY_ZERO:
			GEN_ERROR_LOG("Divided by 0");
			break;
		case STATUS_FLOAT_STACK_CHECK:
			GEN_ERROR_LOG("Float stack check failed");
			break;
		case STATUS_STACK_OVERFLOW:
			GEN_ERROR_LOG("Stack overflowed");
			break;
		case STATUS_ILLEGAL_INSTRUCTION:
			GEN_ERROR_LOG("Invalid Operation code");
			break;
		case STATUS_ARRAY_BOUNDS_EXCEEDED:
			GEN_ERROR_LOG("Array bounds exceeded");
			break;
		default:
			GEN_ERROR_LOG("Unknown");
			break;
	}
	ExitProcess(0);
	return 1;
}
	//#-----
static VALUE XYApp_defExcpHandler(VALUE self)
{
	MessageBox(0,  "Sorry, An unexpectd exception occurred, Abort", "XYGui Exception", 0);
	rb_funcall(self, rb_intern("forceExit"), 0);
	return self;
}
static VALUE XYApp_registerExcpHandler(VALUE self)
{
	SetUnhandledExceptionFilter(XYApp_excpHandler);
	return self;
}
#define __MSGFLT_ADD__ 	     1
#define __MSGFLT_REMOVE__    2  
static VALUE XYApp_changeMsgFilter(VALUE self)
{
	typedef BOOL WINAPI (*pChangeWindowMessageFilter) (UINT uMsg, DWORD flag);
	HINSTANCE hUser32 = GetModuleHandle("user32.dll");
	pChangeWindowMessageFilter pCWM = GetProcAddress(hUser32, "ChangeWindowMessageFilter");
	if(!pCWM)return Qfalse;
	pCWM(WM_DROPFILES, __MSGFLT_ADD__); 		// Allow drop files into window in Admin Model 
	return self;
}
static VALUE XYApp_mainloop(VALUE self)
{
	MSG msg;
	VALUE flag;
	VALUE widget;
	VALUE rq;
	VALUE q;
	//int mn;
	
	q = rb_iv_get(self, "@request");
	
	while(1)
	{
		if(PeekMessage(&msg, 0, 0, 0, PM_REMOVE) > 0)
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}else
		{
			//rb_funcall(self, rb_intern("proRequest"), 0); //no use now....
			//mn = 1; // process at most five requests once
			//while(mn--)
			//{
				widget = rb_funcall(q, rb_intern("pop"), 0);
				rq = rb_funcall(q, rb_intern("pop"), 0);
				//if(widget == Qnil || rq == Qnil)break;	// Ok to leave
				if(widget != Qnil && rq != Qnil)
					rb_funcall(rq, rb_intern("call"), 1, widget);
			//}
			rb_funcall(rb_mKernel, rb_intern("sleep"), 1, DBL2NUM(0.02));
		}
		flag = rb_iv_get(self, "@flagExit");
		if(flag == Qtrue)break;
	}
	
	/*
	while(GetMessage(&msg, 0, 0, 0))
	{
		if(msg.message == WM_XYGUI_RQ)
		{
			widget = rb_funcall(q, rb_intern("pop"), 0);
			rq = rb_funcall(q, rb_intern("pop"), 0);
			if(widget == Qnil || rq == Qnil)break;	// Ok to leave
			rb_funcall(rq, rb_intern("call"), 1, widget);
		}else
		{
			TranslateMessage(&msg);
			DispatchMessage(&msg);
		}
		flag = rb_iv_get(self, "@flagExit");
		if(flag == Qtrue)break;
	}
	*/
	return self;
}
static void InitXYApp()
{
	cXYApp = rb_define_class(XYAppClassName, rb_cObject);
	rb_define_method(cXYApp, "registerClass", XYApp_registerClass, 0);
	rb_define_method(cXYApp, "registerExcpHandler", XYApp_registerExcpHandler, 0);
	rb_define_method(cXYApp, "defExcpHandler", XYApp_defExcpHandler, 0);
	rb_define_method(cXYApp, "mainloop", XYApp_mainloop, 0);
	
	// --------------------------------------
	rb_define_method(cXYApp, "changeMsgFtl", XYApp_changeMsgFilter, 0);
}
#endif
//----------------------- End XYApp -----------------------------------------------


// ---------------------- For XYWidget --------------------------------------------
#if 1
// this class
static VALUE cXYWidget;
static const char *XYWidgetClassName = "XYWidget";
VALUE XYWidget_selfval(VALUE self)
{
	return INT2NUM(self); 
	/*
		In ruby, INT2NUM(self) is the real value of self
	*/
}
void InitXYWidget()
{
	cXYWidget = rb_define_class(XYWidgetClassName, rb_cObject);
	rb_define_method(cXYWidget, "selfval", XYWidget_selfval, 0);
}
#endif
// ---------------------- End XYWidget --------------------------------------------


// ---------------------- For XYScrollableWidget ----------------------------------
#if 1
//this class
static VALUE cXYScrollableWidget;
static const char *XYScrollableWidgetClassName = "XYScrollableWidget";
void InitXYScrollableWidget()
{
	cXYScrollableWidget = rb_define_class(XYScrollableWidgetClassName, cXYWidget);
}
#endif
// ---------------------- End XYScrollableWidget ----------------------------------


// ---------------------- For XYWindow --------------------------------------------
#if 1
// #if 1 here, and your code editor may be able to fold these code
// this class
static VALUE cXYWindow;
static const char *XYWindowClassName = "XYWindow";
// WndProc
static void XYWindow_emitMouseDown(VALUE self, int key, LPARAM l)
{
	VALUE v;
	v = rb_hash_new();
	rb_hash_aset(v, ID2SYM(rb_intern("key")), INT2FIX(key));
	rb_hash_aset(v, ID2SYM(rb_intern("x")), INT2FIX(LOWORD(l)));
	rb_hash_aset(v, ID2SYM(rb_intern("y")), INT2FIX(HIWORD(l)));
	XYWidgetCall("ON_MOUSEDOWN", self, v);
}

static LRESULT CALLBACK XYWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	VALUE __arg1__;
	VALUE __arg2__;
	
	unsigned __tmp1__;
	unsigned __tmp2__;
	char *__tmpcptr1__;

	HDC hdc;
	
	//Store the 'self' when creating the window
	VALUE self;
	if(uMsg == WM_CREATE)
	{
		self = (VALUE)(((LPCREATESTRUCT)lParam)->lpCreateParams);
		SetWindowLong(hWnd, GWL_USERDATA, (LONG)self);
	}
	self = (VALUE)GetWindowLong(hWnd, GWL_USERDATA);
	
	switch(uMsg)
	{
		case WM_DESTROY:
			XYWidgetCall("ON_DESTROY", self, Qnil);
			break;
		case WM_KEYDOWN:
			__arg1__ = rb_hash_new();
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("key")), INT2FIX(wParam));
			XYWidgetCall("ON_KEYDOWN", self, __arg1__);
			break;
		case WM_SIZE:
			__arg1__ = rb_hash_new();		//arg
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("width")), INT2FIX(LOWORD(lParam))); 
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("height")), INT2FIX(HIWORD(lParam)));
			XYWidgetCall("ON_BEFORESIZE", self, __arg1__);
			break;
		case WM_PAINT:
			XYWidgetCall("ON_BEGINPAINT", self, Qnil);
			break; 
		case WM_COMMAND:
			__tmp1__ = LOWORD(wParam);
			
			if(lParam == 0)  // Command caused by menu
			{
				rb_funcall(self, rb_intern("menuCall"), 1, INT2NUM(__tmp1__));
			}else 
			{ // Command caused by a child control
				switch(HIWORD(wParam))
				{
					case EN_UPDATE:
						rb_funcall(self, rb_intern("childCall"), 4, INT2FIX(__tmp1__), 
								ID2SYM(rb_intern("ON_CHANGED")), self, Qnil);
						break;
					case EN_CHANGE:
						rb_funcall(self, rb_intern("childCall"), 4, INT2FIX(__tmp1__), 
								ID2SYM(rb_intern("ON_CHANGING")), self, Qnil);
						break;
					default:
						rb_funcall(self, rb_intern("childCall"), 4, INT2FIX(__tmp1__), 
								ID2SYM(rb_intern("ON_COMMAND")), self, Qnil);
						break;
				}
			}
			break;
		case WM_MOUSEMOVE:
			__arg1__ = rb_hash_new();
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("x")), INT2FIX(LOWORD(lParam)));
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("y")), INT2FIX(HIWORD(lParam)));
			switch(wParam)
			{
				case MK_LBUTTON:
				case MK_RBUTTON:
					__arg2__ = INT2FIX(wParam);
					break;
				case MK_MBUTTON:
					__arg2__ = INT2FIX(VK_MBUTTON);
					break;
				case MK_XBUTTON1:
					__arg2__ = INT2FIX(VK_XBUTTON1);
					break;
				case MK_XBUTTON2:
					__arg2__ = INT2FIX(VK_XBUTTON2);
					break;
				default:
					__arg2__ = INT2FIX(0);
					break;
			}
			rb_hash_aset(__arg1__, ID2SYM(rb_intern("key")), __arg2__);
			XYWidgetCall("ON_MOUSEMOVE", self, __arg1__);
			break;
		case WM_LBUTTONDOWN:
			XYWindow_emitMouseDown(self, VK_LBUTTON, lParam);
			break;
		case WM_RBUTTONDOWN:
			XYWindow_emitMouseDown(self, VK_RBUTTON, lParam);
			break;
		case WM_MBUTTONDOWN:
			XYWindow_emitMouseDown(self, VK_MBUTTON, lParam);
			break;
		case WM_XBUTTONDOWN:
			switch(HIWORD(wParam))
			{
				case 1:   //XButton 1
					XYWindow_emitMouseDown(self, VK_XBUTTON1, lParam);
					break;
				case 2:   //XButton 2
					XYWindow_emitMouseDown(self, VK_XBUTTON2, lParam);
					break;
			}
			break;
		case WM_CTLCOLORSTATIC:
			hdc = (HDC)wParam;
			SetBkColor(hdc, RGB(255, 255, 255));
			return (LRESULT)GetStockObject(WHITE_BRUSH);
			break;
		case WM_DROPFILES:   // Drop files into the window
			// wParam is HDrop (Win32)
			__tmpcptr1__ = (char *)malloc(sizeof(char) * 256);
			__tmp2__ = DragQueryFile((HDROP)wParam, 0xffffffff, NULL, 0);
			__arg1__ = rb_ary_new();
			for(__tmp1__ = 0; __tmp1__ < __tmp2__; __tmp1__++)
			{
				DragQueryFile((HDROP)wParam, __tmp1__, __tmpcptr1__, 256);
				__arg2__ = rb_str_new2(__tmpcptr1__);
				rb_funcall(__arg1__, rb_intern("push"), 1, __arg2__);
			}
			free(__tmpcptr1__);
			DragFinish((HDROP)wParam);
			__arg2__ = rb_hash_new();
			rb_hash_aset(__arg2__, ID2SYM(rb_intern("files")), __arg1__);
			XYWidgetCall("ON_DROPFILES", self, __arg2__);
			break;
		default:
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
	}
	return 0;
}
static VALUE XYWindow_clientWidth(VALUE self)
{
	RECT r;
	GetClientRect((HWND)FIX2INT(rb_iv_get(self, "@handle")), &r);
	return INT2FIX(r.right);
}
static VALUE XYWindow_clientHeight(VALUE self)
{
	RECT r;
	GetClientRect((HWND)FIX2INT(rb_iv_get(self, "@handle")), &r);
	return INT2FIX(r.bottom);
}
static VALUE XYWindow_beginPaint(VALUE self, VALUE a, VALUE b)
{
	PAINTSTRUCT ps;
	HWND hw = (HWND)NUM2INT(rb_iv_get(self, "@handle"));
	VALUE pater = rb_iv_get(self, "@painter");
	rb_iv_set(self, "@dc", INT2NUM((long)BeginPaint(hw, &ps)));
	rb_funcall(pater, rb_intern("reset"), 0);
	XYWidgetCall("ON_PAINT", a, b);
	rb_funcall(pater, rb_intern("destroy"), 0);
	EndPaint(hw, &ps);
	rb_iv_set(self, "@dc", Qnil);
	return self;
}
// init XYWindow
void InitXYWindow()
{
	cXYWindow = rb_define_class(XYWindowClassName, cXYScrollableWidget);
	rb_define_method(cXYWindow, "clientHeight", XYWindow_clientHeight, 0);
	rb_define_method(cXYWindow, "clientWidth", XYWindow_clientWidth, 0);
	rb_define_method(cXYWindow, "beginPaint", XYWindow_beginPaint, 2);
}
#endif
// ---------------------- End XYWindow ----------------------------------------

// ---------------------- For XYPushButton --------------------------------------
#if 1
VALUE cXYPushButton;
static const char *XYPushButtonClassName = "XYPushButton";

LRESULT CALLBACK XYPushButtonProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	VALUE self;
	WNDPROC oriproc;
	
	self = (VALUE)GetWindowLong(hWnd, GWL_USERDATA);
	switch(uMsg)
	{
		case WM_RBUTTONDOWN:
			XYWindow_emitMouseDown(self, VK_RBUTTON, lParam);
			break;
		case WM_LBUTTONDOWN:
			oriproc = (WNDPROC)NUM2INT(rb_iv_get(self, "@oriproc"));
			XYWindow_emitMouseDown(self, VK_LBUTTON, lParam);
			return oriproc(hWnd, uMsg, wParam, lParam);
		case WM_MBUTTONDOWN:
			XYWindow_emitMouseDown(self, VK_MBUTTON, lParam);
			break;
		case WM_XBUTTONDOWN:
			switch(HIWORD(wParam))
			{
				case 1:   //XButton 1
					XYWindow_emitMouseDown(self, VK_XBUTTON1, lParam);
					break;
				case 2:   //XButton 2
					XYWindow_emitMouseDown(self, VK_XBUTTON2, lParam);
					break;
			}
			break;
		default:
			oriproc = (WNDPROC)NUM2INT(rb_iv_get(self, "@oriproc"));
			return oriproc(hWnd, uMsg, wParam, lParam);
	}
	return 0;
}

static VALUE XYPushButton_changeProc(VALUE self)
{
	HWND hw = (HWND)NUM2INT(rb_iv_get(self, "@handle"));
	SetWindowLong(hw, GWL_USERDATA, (LONG)NUM2INT(rb_funcall(self, rb_intern("selfval"), 0)));
	rb_iv_set(self, "@oriproc", INT2NUM(GetWindowLong(hw, GWL_WNDPROC)));
	SetWindowLong(hw, GWL_WNDPROC, (LONG)XYPushButtonProc);
	return self;
}
void InitXYPushButton()
{
	cXYPushButton = rb_define_class(XYPushButtonClassName, cXYWidget);
	rb_define_method(cXYPushButton, "changeProc", XYPushButton_changeProc, 0);
}
#endif
// ---------------------- End XYPushButton --------------------------------------

// ---------------------- For XYTextEdit ---------------------------------------
#if 1

#endif
// ---------------------- End XYTextEdit ---------------------------------------

// ---------------------- For XYPainter ---------------------------------------
#if 1
//ths class
static VALUE cXYPainter;
static const char *XYPainterClassName = "XYPainter";
#define GETWIDGET_DC(obj) (HDC)NUM2INT(rb_iv_get(rb_iv_get(obj, "@widget"), \
			"@dc"))
#define GETBRUSH_HANDLE(obj) (HBRUSH)NUM2INT(rb_iv_get(rb_iv_get(obj, \
		"@brush"), "@handle"))
#define GETORIBRUSH_HANDLE(obj) (HBRUSH)NUM2INT(rb_iv_get(rb_iv_get(obj, \
				"@oriBrush"), "@handle"))

#define GETPEN_HANDLE(obj) (HPEN)NUM2INT(rb_iv_get(rb_iv_get(obj, \
		"@pen"), "@handle"))
#define GETORIPEN_HANDLE(obj) (HPEN)NUM2INT(rb_iv_get(rb_iv_get(obj, \
		"@oriPen"), "@handle")) 
//undefed after a while 

//Drawing functions
static VALUE XYPainter_lineTo(VALUE self, VALUE x, VALUE y)
{
	LineTo(GETWIDGET_DC(self), FIX2INT(x), FIX2INT(y));
	return self;
}
static VALUE XYPainter_line(VALUE self, VALUE srcx, VALUE srcy, VALUE destx, VALUE desty)
{
	int sx = FIX2INT(srcx);
	int sy = FIX2INT(srcy);
	HDC dc = GETWIDGET_DC(self);
	MoveToEx(dc, sx, sy, NULL);
	LineTo(dc, FIX2INT(destx), FIX2INT(desty));
	return self;
}
static VALUE XYPainter_ellipse(VALUE self, VALUE cenx, VALUE ceny, VALUE a, VALUE b)
{
	int _a = FIX2INT(a);
	int _b = FIX2INT(b);
	Ellipse(GETWIDGET_DC(self), FIX2INT(cenx)-(_a>>1), FIX2INT(ceny)-(_b>>1), 
						FIX2INT(cenx)+(_a>>1), FIX2INT(ceny)+(_b>>1));
	return self;
}
static VALUE XYPainter_circle(VALUE self, VALUE cenx, VALUE ceny, VALUE r)
{
	VALUE rx = INT2FIX(FIX2INT(r)*2);
	rb_funcall(self, rb_intern("ellipse"), 4, cenx, ceny, rx, rx);
	return self;
}
static VALUE XYPainter_fillRect(VALUE self, VALUE leftx, VALUE topy, VALUE width, VALUE height)
{
	RECT rt;
	rt.left = FIX2INT(leftx);
	rt.top = FIX2INT(topy);
	rt.right = rt.left + FIX2INT(width);
	rt.bottom = rt.top + FIX2INT(height);
	FillRect(GETWIDGET_DC(self), &rt, GETBRUSH_HANDLE(self));
	return self;
}
static VALUE XYPainter_defBrush(VALUE self)
{
	HBRUSH old;
	HDC dc = GETWIDGET_DC(self);
	old = SelectObject(dc, GetStockObject(NULL_BRUSH));
	SelectObject(dc, old);
	return INT2NUM((long)old);
} 
static VALUE XYPainter_defPen(VALUE self)
{
	HPEN old;
	HDC dc = GETWIDGET_DC(self);
	old = SelectObject(dc, GetStockObject(BLACK_PEN));
	SelectObject(dc, old);
	return INT2NUM((long)old);
}
static VALUE XYPainter_setBrush(VALUE self, VALUE br)
{
	HDC dc = GETWIDGET_DC(self);
	SelectObject(dc, GETORIBRUSH_HANDLE(self));
	DeleteObject(GETBRUSH_HANDLE(self));
	
	rb_iv_set(self, "@brush", br);
	rb_funcall(br, rb_intern("create"), 0);
	SelectObject(dc, GETBRUSH_HANDLE(self));
	return self;
}
static VALUE XYPainter_setPen(VALUE self, VALUE pn)
{
	HDC dc = GETWIDGET_DC(self);
	SelectObject(dc, GETORIPEN_HANDLE(self));
	DeleteObject(GETPEN_HANDLE(self));
	
	rb_iv_set(self, "@pen", pn);
	rb_funcall(pn, rb_intern("create"), 0);
	SelectObject(dc, GETPEN_HANDLE(self));
	return self;
}
static VALUE XYPainter_text(VALUE self, VALUE str, VALUE x, VALUE y)
{
	int len = rb_funcall(str, rb_intern("length"), 0);
	HDC dc = GETWIDGET_DC(self);
	TextOut(dc, FIX2INT(x), FIX2INT(y), RSTRING_PTR(str), len/2);
	return self;
}
static VALUE XYPainter_point(VALUE self, VALUE x, VALUE y)
{
	VALUE pen = rb_iv_get(self, "@pen");
	HDC dc = GETWIDGET_DC(self);
	SetPixel(dc, FIX2INT(x), FIX2INT(y), RGB(FIX2INT(rb_iv_get(pen, "@red")),
				FIX2INT(rb_iv_get(pen, "@green")), FIX2INT(rb_iv_get(pen, "@blue"))));
	return self;
}

static void InitXYPainter()
{
	cXYPainter = rb_define_class(XYPainterClassName, rb_cObject);
	rb_define_method(cXYPainter, "lineTo", XYPainter_lineTo, 2);
	rb_define_method(cXYPainter, "line", XYPainter_line, 4);
	rb_define_method(cXYPainter, "ellipse", XYPainter_ellipse, 4);
	rb_define_method(cXYPainter, "circle", XYPainter_circle, 3);
	rb_define_method(cXYPainter, "fillRect", XYPainter_fillRect, 4);
	rb_define_method(cXYPainter, "setBrush", XYPainter_setBrush, 1);
	rb_define_method(cXYPainter, "setPen", XYPainter_setPen, 1);
	rb_define_method(cXYPainter, "text", XYPainter_text, 3);
	rb_define_method(cXYPainter, "point", XYPainter_point, 2);
	
	//Note! These method should provide to users
	rb_define_method(cXYPainter, "defBrush", XYPainter_defBrush, 0); //For windows...
	rb_define_method(cXYPainter, "defPen", XYPainter_defPen, 0);
}
#undef GETWIDGET_DC
#undef GETBRUSH_HANDLE
#undef GETORIBRUSH_HANDLE
#undef GETPEN_HANDLE
#undef GETORIPEN_HANDLE
#endif
// ---------------------- End XYPainter ---------------------------------------

// ---------------------- For XYPainterTools -----------------------------------
#if 1
static VALUE cXYPainterTool;
const char *XYPainterToolClassName = "XYPainterTool";
static VALUE cXYBrush;
const char *XYBrushClassName = "XYBrush";
static VALUE cXYPen;
const char *XYPenClassName = "XYPen";
static VALUE XYBrush_create(VALUE self)
{
	HBRUSH br = CreateSolidBrush(RGB(FIX2INT(rb_iv_get(self, "@red")), 
				FIX2INT(rb_iv_get(self, "@green")), FIX2INT(rb_iv_get(self, "@blue"))));
	VALUE r = INT2NUM((long)br);
	rb_iv_set(self, "@handle", r);
	return r;
}
static VALUE XYPen_create(VALUE self)
{
	HPEN pn = CreatePen(PS_SOLID, 1, RGB(FIX2INT(rb_iv_get(self, "@red")), 
				FIX2INT(rb_iv_get(self, "@green")), FIX2INT(rb_iv_get(self, "@blue"))));
	VALUE r = INT2NUM((long)pn);
	rb_iv_set(self, "@handle", r);
	return r;
}

static void InitXYPainterTools()
{
	cXYPainterTool = rb_define_class(XYPainterToolClassName, rb_cObject);
	cXYBrush = rb_define_class(XYBrushClassName, cXYPainterTool);
	rb_define_method(cXYBrush, "create", XYBrush_create, 0);
	
	cXYPen = rb_define_class(XYPenClassName, cXYPainterTool);
	rb_define_method(cXYPen, "create", XYPen_create, 0);
}
#endif
// ---------------------- End XYPainterTools -----------------------------------

// Init this extension
#if 1
void Init_XYGui_ext()
{
	
	InitXYApp();
	InitXYWidget();
	InitXYScrollableWidget();
	InitXYWindow();
	InitXYPushButton();
	InitXYPainter();
	InitXYPainterTools();
}
#endif
// End of Init

#ifdef __cplusplus
}
#endif
