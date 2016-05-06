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

#define XYWidgetCall(sig, arg1, arg2) (rb_funcall(self, rb_intern("call"), \
						3, ID2SYM(rb_intern(sig)), arg1, arg2))

#ifdef __cplusplus
extern "C"
{
#endif

// ---------------------- For XYWidget --------------------------------------------
#if 1
// #if 1 here, and your code editor may be able to fold these code
// this class
static VALUE cXYWidget;
static const char* XYWidgetClassName = "XYWidget";
void InitXYWidget()
{
	cXYWidget = rb_define_class(XYWidgetClassName, rb_cObject);
}
#endif
// ---------------------- End XYWidget --------------------------------------------


// ---------------------- For XYScrollableWidget ----------------------------------
#if 1
//this class
static VALUE cXYScrollableWidget;
static const char* XYScrollableWidgetClassName = "XYScrollableWidget";
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
static const char* XYWindowClassName = "XYWindow";
// WndProc
static VALUE XYWndProc(VALUE self, VALUE a1, VALUE a2, VALUE a3, VALUE a4)
{
	VALUE __arg1__;
	VALUE __arg2__;
	unsigned __tmp1__;
	unsigned __tmp2__;
	
	unsigned hWnd = (unsigned)FIX2INT(a1);
	unsigned uMsg = (unsigned)FIX2INT(a2);
	unsigned wParam = (unsigned)FIX2INT(a3);
	unsigned lParam = (unsigned)FIX2INT(a4);
	
	//hWnd = FIX2INT(rb_iv_get(self, "@handle"));
	printf("%u %u\n", FIX2INT(a1), FIX2INT(rb_iv_get(self, "@handle")));
	
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
			return INT2FIX(DefWindowProc(hWnd, uMsg, wParam, lParam));
	}
	return INT2FIX(0);
}
// init XYWindow
void InitXYWindow()
{
	cXYWindow = rb_define_class(XYWindowClassName, cXYScrollableWidget);
	rb_define_method(cXYWindow, "callproc", XYWndProc, 4);
}
#endif
// ------------------End XYWindow ----------------------------------------


// Init this extension
void Init_XYGui_ext()
{
	InitXYWidget();
	InitXYScrollableWidget();
	InitXYWindow();
}

#ifdef __cplusplus
}
#endif
