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
EXTERNDEF dwLevel :DWORD
EXTERNDEF dwScore :DWORD
EXTERNDEF dwLife  :SDWORD
EXTERNDEF dwScoreSub1 :DWORD
EXTERNDEF dwScoreSub2 :DWORD
EXTERNDEF dwScoreSub3 :DWORD
EXTERNDEF dwScoreSub4 :DWORD

_DrawScore PROTO _hDC:DWORD, _hMemDC:DWORD
_CreateBmp_Number PROTO
_DestoryBmp_Number PROTO