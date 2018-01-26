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
include vars.inc
include myStruct.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
EXTERNDEF dwBomb		:PTR BOMB
EXTERNDEF dwBombSize	:DWORD
EXTERNDEF dwBombWidth	:DWORD
EXTERNDEF dwBombHeight  :DWORD
EXTERNDEF dwBombSpeed	:DWORD
EXTERNDEF dwBombPic     :DWORD
EXTERNDEF dwUnusedBombX :DWORD
EXTERNDEF dwUnusedBombY :DWORD
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawBomb PROTO, _hDC :DWORD,_hMemDC:DWORD
_DropBomb PROTO
_ChangeBombPic PROTO
_ReleaseBomb PROTO, _direction:DWORD
_CreateBmp_Bomb PROTO
_DestoryBmp_Bomb PROTO
_BombSub PROTO
