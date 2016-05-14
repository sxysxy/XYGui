#if 0  
	I like IF 0 hhhh
	
	Native Extension for XYGui (Win32 Version)
	
	sxysxy 2016.04.20
	
#endif

#include "ruby.h"
#include <windows.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C"
{
#endif

// ----------------------- Global Area ------------------------------------------
#if 1
#define XYWidgetCall(sig, arg1, arg2) (rb_funcall(self, rb_intern("call"), \
						3, ID2SYM(rb_intern(sig)), arg1, arg2))

#endif 
// ----------------------- End Global Area --------------------------------------


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
static void InitXYApp()
{
	cXYApp = rb_define_class(XYAppClassName, rb_cObject);
	rb_define_method(cXYApp, "registerClass", XYApp_registerClass, 0);
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
static LRESULT CALLBACK XYWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	VALUE __arg1__;
	//VALUE __arg2__;
	unsigned __tmp1__;
	//unsigned __tmp2__;
	
	//hWnd = FIX2INT(rb_iv_get(self, "@handle"));
	//printf("%u %u\n", FIX2INT(a1), FIX2INT(rb_iv_get(self, "@handle")));
	
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
			//rb_iv_set(self, "@dc", INT2FIX((int)GetDC(hWnd)));
			XYWidgetCall("ON_BEGINPAINT", self, Qnil);
			break; 
		case WM_COMMAND:
			__tmp1__ = LOWORD(wParam);
			rb_funcall(self, rb_intern("childCall"), 4, INT2FIX(__tmp1__), 
								ID2SYM(rb_intern("ON_COMMAND")), self, Qnil); 
			break;
		default:
			return DefWindowProc(hWnd, uMsg, wParam, lParam);
	}
	return 0;
}
/*
static VALUE callproc(VALUE self, VALUE a1, VALUE a2, VALUE a3, VALUE a4)
{
	return INT2FIX(XYWndProc(FIX2INT(a1), FIX2INT(a2), FIX2INT(a3), FIX2INT(a4)));
}
*/
/*
static VALUE wndprocaddr(VALUE self)
{
	//printf("In c: %d %p\n", XYWndProc, XYWndProc);
	return INT2FIX((int)XYWndProc);
}
*/
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
// init XYWindow
void InitXYWindow()
{
	cXYWindow = rb_define_class(XYWindowClassName, cXYScrollableWidget);
	rb_define_method(cXYWindow, "clientHeight", XYWindow_clientHeight, 0);
	rb_define_method(cXYWindow, "clientWidth", XYWindow_clientWidth, 0);
}
#endif
// ---------------------- End XYWindow ----------------------------------------



// ---------------------- For XYPainter ---------------------------------------
#if 1
//ths class
static VALUE cXYPainter;
static const char *XYPainterClassName = "XYPainter";
#define GETWIDGET_DC(obj) (HDC)NUM2INT(rb_iv_get(rb_iv_get(obj, "@widget"), "@dc"))
#define GETBRUSH_HANDLE(obj) (HBRUSH)NUM2INT(rb_iv_get(rb_iv_get(obj, "@brush"), "@handle"))
#define GETORIBRUSH_HANDLE(obj) (HBRUSH)NUM2INT(rb_iv_get(rb_iv_get(obj, "@oriBrush"), "@handle"))
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
	Ellipse(GETWIDGET_DC(self), FIX2INT(cenx)-(_a>>1), FIX2INT(ceny)-(_b>>1), FIX2INT(cenx)+(_a>>1), FIX2INT(ceny)+(_b>>1));
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
	old = SelectObject(dc, (HBRUSH)GetStockObject(BLACK_BRUSH));
	SelectObject(dc, old);
	return INT2NUM((long)old);
} 
static VALUE XYPainter_setBrush(VALUE self, VALUE br)
{
	HDC dc = GETWIDGET_DC(self);
	SelectObject(dc, GETORIBRUSH_HANDLE(self));
	DeleteObject(GETBRUSH_HANDLE(self));
	
	rb_iv_set(self, "@brush", br);
	SelectObject(dc, GETBRUSH_HANDLE(self));
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
	
	//Note! These method should provide to users
	rb_define_method(cXYPainter, "defBrush", XYPainter_defBrush, 0); //For windows...
}
#undef GETWIDGET_DC
#undef GETBRUSH_HANDLE
#undef GETORIBRUSH_HANDLE
#endif
// ---------------------- End XYPainter ---------------------------------------

// Init this extension
#if 1
void Init_XYGui_ext()
{
	InitXYApp();
	InitXYWidget();
	InitXYScrollableWidget();
	InitXYWindow();
	InitXYPainter();
}
#endif
// End of Init

#ifdef __cplusplus
}
#endif
