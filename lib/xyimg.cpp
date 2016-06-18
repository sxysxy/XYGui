/////dll made in vs 2015
// Here are main codes
//File: dllmain.cpp

#include "stdafx.h"

static GdiplusStartupInput m_gdiplusStartupInput;
static ULONG_PTR m_pGdiToken;
BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		GdiplusStartup(&m_pGdiToken, &m_gdiplusStartupInput, NULL);
		break;
	case DLL_PROCESS_DETACH:
		GdiplusShutdown(m_pGdiToken);
		break;
	}
	return TRUE;
}

// xyimg.cpp : ���� DLL Ӧ�ó���ĵ���������
//

// File: xyimg.cpp
#include "stdafx.h"
#include "xyimg.h"

/*
// ���ǵ���������һ��ʾ��
XYIMG_API int nxyimg=0;

// ���ǵ���������һ��ʾ����
XYIMG_API int fnxyimg(void)
{
    return 42;
}

// �����ѵ�����Ĺ��캯����
// �й��ඨ�����Ϣ������� xyimg.h
Cxyimg::Cxyimg()
{
    return;
}
*/

extern "C"
{
	XYIMG_API bool showImage(const char *fname, int x, int y, int w, int h, HWND hWnd)
	{
		HDC hdc = GetDC(hWnd);
		Graphics g(hdc);
		WCHAR buffer[256];
		MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, fname, -1, buffer, 255);
		Image img(buffer, FALSE);
		if(img.GetLastStatus() != Status::Ok)
		{
			printf("error");
			return false;
		}
		g.DrawImage(&img, 10, 10, img.GetWidth(), img.GetHeight());

		ReleaseDC(hWnd, hdc);
		return true;
	}
	XYIMG_API bool showImageOnPaint(const char *fname, int x, int y, int w, int h, HDC hdc)
	{
		Graphics g(hdc);
		WCHAR buffer[256];
		MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, fname, -1, buffer, 255);
		Image img(buffer, FALSE);
		if(img.GetLastStatus() != Status::Ok)
		{
			printf("error");
			return false;
		}
		g.DrawImage(&img, 10, 10, img.GetWidth(), img.GetHeight());
		return true;
	}
}