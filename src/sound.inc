include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib
INCLUDE winmm.inc
INCLUDE comctl32.inc
INCLUDELIB winmm.lib
INCLUDELIB comctl32.lib

EXTERNDEF dbMusic_bg:BYTE
EXTERNDEF dbMusic_on:DWORD
EXTERNDEF dbSound_on:DWORD
_Music_explode PROTO
_Music_missile PROTO
BgmRepeat PROTO, 
	hWin : DWORD, 
	NameOfFile : DWORD
BgmStatus PROTO, hWin : DWORD
BgmPlay PROTO, hWin : DWORD
BgmPause PROTO, hWin : DWORD