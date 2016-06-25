/*
	Orz.....
			sxysxy -- 2016.06.25
*/

#include <windows.h>
#include <gdiplus.h>
#include <cstdio>
using namespace Gdiplus;
static GdiplusStartupInput gdiplusStartupInput;
static ULONG_PTR pGdiToken;
static bool released = false;
static bool loaded = false;
#define XYIMG_API __declspec(dllexport) 
extern "C"
{
	
XYIMG_API BOOL WINAPI DllMain(HINSTANCE hInstance, 
						DWORD why, LPVOID lpRev)
{
	switch(why)
	{
		case DLL_PROCESS_ATTACH:
			if(loaded)break;
			loaded = true;
			GdiplusStartup(&pGdiToken, &gdiplusStartupInput, NULL);
			//printf("loadin, m:%d\n", hInstance);
			break;
		case DLL_PROCESS_DETACH:
			if(released)break;
			GdiplusShutdown(pGdiToken);
			released = true;
			//printf("detach, m:%d\n", hInstance);
			break;
	}
	return TRUE;
}

XYIMG_API Image* WINAPI CreateImageObject(const char *fname)
{	
	WCHAR buffer[256];
	MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, fname, -1, buffer, 255);
	Image *img = new Image(buffer, FALSE);
	return img;
}

XYIMG_API void WINAPI DeleteImageObject(Image *img)
{
	delete img;
}

XYIMG_API void WINAPI ShowImage(Image *img, HWND hWnd, int x, int y, int w, int h)
{
	HDC hDC = GetDC(hWnd);
	Graphics g(hDC);
	g.DrawImage(img, x, y, w, h);
	ReleaseDC(hWnd, hDC);
}

XYIMG_API int WINAPI GetImageWidth(Image *img)
{
	return img -> GetWidth();
}

XYIMG_API int WINAPI GetImageHeight(Image *img)
{
	return img -> GetHeight(); 
}

} // extern c


