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

//Global Area
#define XYWidgetCall(sig, arg1, arg2) (rb_funcall(self, rb_intern("call"), \
						3, ID2SYM(rb_intern(sig)), arg1, arg2))

//gdi functions
typedef HDC (*__MoveTo__)(HDC hDC, int x, int y);
__MoveTo__ XYMoveTo;
__MoveTo__ XYLineTo;   // LineTo is similar
						
#ifdef __cplusplus
extern "C"
{
#endif

// ---------------------- For XYApp -----------------------------------------------
#if 1
// #if 1 here, and your code editor may be able to fold these code
static VALUE cXYApp;
static const char *XYAppClassName = "XYApp";
// WndProc, Defined in XYWindow Ext
static LRESULT CALLBACK XYWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
static VALUE registerClass(VALUE self)
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
	rb_define_method(cXYApp, "registerClass", registerClass, 0);
}
#endif
//----------------------- End XYApp -----------------------------------------------


// ---------------------- For XYWidget --------------------------------------------
#if 1
// this class
static VALUE cXYWidget;
static const char *XYWidgetClassName = "XYWidget";
VALUE selfval(VALUE self)
{
	return INT2FIX(self); 
	/*
		In ruby, INT2FIX(self) is the real value of self
	*/
}
void InitXYWidget()
{
	cXYWidget = rb_define_class(XYWidgetClassName, rb_cObject);
	rb_define_method(cXYWidget, "selfval", selfval, 0);
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
	VALUE __arg2__;
	unsigned __tmp1__;
	unsigned __tmp2__;
	
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
// init XYWindow
void InitXYWindow()
{
	cXYWindow = rb_define_class(XYWindowClassName, cXYScrollableWidget);
	//rb_define_method(cXYWindow, "callproc", callproc, 4);
	//rb_define_method(cXYWindow, "wndproc", wndprocaddr, 0);
	//rb_define_method(cXYWindow, "registerClass", registerClass, 0);
}
#endif
// ---------------------- End XYWindow ----------------------------------------

// ---------------------- For XYPainter ---------------------------------------
#if 1
static VALUE cXYPainter;
static const char *XYPainterClassName = "XYPainter";
static void InitGDIFunctions()
{
	HINSTANCE h = LoadLibrary("gdi32");
	XYMoveTo = GetProcAddress(h, "MoveTo");
	XYLineTo = GetProcAddress(h, "LineTo");
}
static VALUE line(VALUE self, VALUE srcx, VALUE srcy, VALUE destx, VALUE desty)
{
	XYMoveTo(FIX2INT(rb_iv_get(self, "@dc")), FIX2INT(srcx), FIX2INT(srcy));
	XYLineTo(FIX2INT(rb_iv_get(self, "@dc")), FIX2INT(destx), FIX2INT(desty));
	return self;
}
static void InitXYPainter()
{
	cXYPainter = rb_define_class(XYPainterClassName, rb_cObject);
	rb_define_method(cXYPainter, "line", line, 4);
	
	InitGDIFunctions();
}
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
