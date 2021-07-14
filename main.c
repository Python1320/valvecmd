
#include <windows.h>
#include <string.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
	if (argc<2) {
		fprintf( stderr, "Usage: %s \"say hello world\"",argv[0]);
		return 3;
	}
	HWND wnd = FindWindow("Valve001", NULL);
	if (wnd) {
		LPCTSTR cmd = argv[1];
		COPYDATASTRUCT cds;
		cds.dwData = 0;
		cds.cbData = (strlen(cmd) + 1);
		cds.lpData = (void*)cmd;
		return SendMessageA(wnd, WM_COPYDATA, (WPARAM)wnd, (LPARAM)(LPVOID)&cds)!=1;
	}
	return 2;
}
