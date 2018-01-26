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
EXTERNDEF dwMissile				:PTR MISSILE
EXTERNDEF dwMissileSize 		:DWORD
EXTERNDEF dwMissileWidth		:DWORD
EXTERNDEF dwMissileHeight		:DWORD
EXTERNDEF dwMissileSpeed		:DWORD
EXTERNDEF dwMissileFromSubX		:DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawMissile PROTO, _hDC:DWORD, _hMemDC:DWORD
_FloatMissile PROTO
_ReleaseMissile PROTO, _SubX:DWORD, _SubY:DWORD, _direction:DWORD
_CreateBmp_Missile PROTO
_DestoryBmp_Missile PROTO
_MissileShip PROTO
