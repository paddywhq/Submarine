include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include myStruct.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF dwSub2: PTR SUBMARINE
EXTERNDEF dwSub2Size   :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub2 PROTO, _hDC :DWORD,_hMemDC:DWORD
_ReleaseSub2 PROTO, _total:DWORD, dwSub2UpperY:DWORD, dwSub2LowerY:DWORD
_MoveSub2 PROTO
_CreateBmp_Sub2 PROTO
_DestoryBmp_Sub2 PROTO
