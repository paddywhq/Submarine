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
EXTERNDEF dwSub4: PTR SUBMARINE
EXTERNDEF dwSub4Size   :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub4 PROTO, _hDC:DWORD, _hMemDC:DWORD
_ReleaseSub4 PROTO, _total:DWORD, dwSub4UpperY:DWORD, dwSub4LowerY:DWORD
_MoveSub4 PROTO
_CreateBmp_Sub4 PROTO
_DestoryBmp_Sub4 PROTO
