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
EXTERNDEF dwExplode		 :PTR EXPLODE
EXTERNDEF dwExplodeSize  :DWORD
EXTERNDEF dwExplodeWidth :DWORD
EXTERNDEF dwExplodeHeight:DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawBoom PROTO, _hDC:DWORD, _hMemDC:DWORD
_ChangeBoomPic PROTO
_ReleaseBoom PROTO, _SubX:SDWORD, _SubY:DWORD
_BoomSub PROTO
_CreateBmp_Explode PROTO
_DestoryBmp_Explode PROTO
_BoomShip PROTO
