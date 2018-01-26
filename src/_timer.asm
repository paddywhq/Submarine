.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include timer.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_SetTimer proc
	invoke	SetTimer,hWinMain, ID_TIMER,		   55, NULL	
	invoke  SetTimer,hWinMain, ID_TIMER_BOMB,	   55, NULL
	invoke  SetTimer,hWinMain, ID_TIMER_RANDOM,	   100, NULL
	invoke  SetTimer,hWinMain, ID_TIMER_CHANGEPIC, 200, NULL
	ret
_SetTimer endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_KillTimer proc
	invoke	KillTimer,hWinMain,ID_TIMER
	invoke	KillTimer,hWinMain,ID_TIMER_BOMB
	invoke	KillTimer,hWinMain,ID_TIMER_RANDOM
	invoke	KillTimer,hWinMain,ID_TIMER_CHANGEPIC
	ret
_KillTimer endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end