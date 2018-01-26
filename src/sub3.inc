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
EXTERNDEF dwSub3: PTR SUBMARINE
EXTERNDEF dwSub3Size   :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawSub3 PROTO, _hDC:DWORD, _hMemDC:DWORD
_ReleaseSub3 PROTO, _total:DWORD, dwSub3UpperY:DWORD, dwSub3LowerY:DWORD
_MoveSub3 PROTO
_CreateBmp_Sub3 PROTO
_DestoryBmp_Sub3 PROTO
