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
EXTERNDEF dwTorpedo				:PTR TORPEDO
EXTERNDEF dwTorpedoSize 		:DWORD
EXTERNDEF dwTorpedoWidth		:DWORD
EXTERNDEF dwTorpedoHeight		:DWORD
EXTERNDEF dwTorpedoSpeed		:DWORD
EXTERNDEF dwTorpedoFromSubX		:DWORD
EXTERNDEF dwTorpedoTimeCount	:DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawTorpedo PROTO, _hDC:DWORD, _hMemDC:DWORD
_FloatTorpedo PROTO
_ReleaseTorpedo PROTO, _SubX:DWORD, _SubY:DWORD, _direction:DWORD
_CreateBmp_Torpedo PROTO
_DestoryBmp_Torpedo PROTO
_TorpedoShip PROTO
