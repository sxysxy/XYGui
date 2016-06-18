#include <windows.h>
#include <gdiplus.h>
using namespace Gdiplus;
//--------------------------
extern "C"
{
#include "ruby.h"
// -----------------------------------
// ------------------- For XYImage -------------------------------
#if 1
static VALUE cXYImage;
static const char *XYImageClassName = "XYImage";

static VALUE XYImage_afterInit(VALUE self)
{
	WCHAR buffer[256];
	Image *img;
	MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, RSTRING_PTR(rb_iv_get(self, "@filename")), -1, buffer, 255);
	try
	{
		img = new Image(buffer, FALSE);
	}catch(...)
	{
		img = NULL;
		return Qfalse;
	}
	if(!img || img -> GetLastStatus())return Qfalse;
	rb_iv_set(self, "@nativeObject", INT2NUM((int)img));
	rb_iv_set(self, "@width", INT2FIX(img -> GetWidth()));
	rb_iv_set(self, "@height", INT2FIX(img -> GetHeight()));
	return self;
}

static VALUE XYImage_destroyNativeObject(VALUE self)
{
	Image *img = (Image*)NUM2INT(rb_iv_get(self, "@nativeObject")); 
	try
	{
		if(img)
		{
			delete img;
			rb_iv_set(self, "@nativeObject", INT2FIX(0));
		}
	}catch(...)
	{
		rb_iv_set(self, "@nativeObject", INT2FIX(0));
	}
	return self;
}

static VALUE XYImage_show(VALUE self, VALUE widget, VALUE x, VALUE y, VALUE w, VALUE h)
{
	HWND hWnd = (HWND)NUM2INT(rb_iv_get(widget, "@handle"));
	HDC hdc = GetDC(hWnd);
	
	Graphics g(hdc);
	Image *img = (Image*)NUM2INT(rb_iv_get(self, "@nativeObject"));
	if(!img || img -> GetLastStatus()) return Qfalse;
	g.DrawImage(img, 0, 0, img -> GetWidth(), img -> GetHeight());
	ReleaseDC(hWnd, hdc);
	
	return self;
}

static VALUE XYImage_showOnPaint(VALUE self, VALUE widget, VALUE x, VALUE y, VALUE w, VALUE h)
{
	return self;
}

//static GdiplusStartupInput m_gdiplusStartupInput;
//static ULONG_PTR m_pGdiToken;
void InitXYImage()
{
	cXYImage = rb_define_class(XYImageClassName, rb_cObject);
	rb_define_method(cXYImage, "afterInit", XYImage_afterInit, 0);
	rb_define_method(cXYImage, "destroyNativeObject", XYImage_destroyNativeObject, 0);
	rb_define_method(cXYImage, "show", XYImage_show, 5);	
	rb_define_method(cXYImage, "showOnPaint", XYImage_showOnPaint, 5);
	//GdiplusStartup(&m_pGdiToken, &m_gdiplusStartupInput, NULL);
}
#endif
// ------------------- End XYImage -------------------------------	

// ------------------- Init the extension ------------------------
#if 1
void Init_XYGuiImg_ext()
{
	InitXYImage();
}
#endif
// ---------------------------------------------------------------

// --------------------------------------
}	// End of externC
// ------------------------------------