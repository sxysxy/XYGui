#include "ruby.h"
#include <windows.h>

static LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	return 0;
}

void* xy_window_get_wndproc()
{
	return (void*)WndProc;
}


VALUE cXYWindow;
void Init_xy_window_ext()
{
	
}
