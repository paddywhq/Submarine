.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include sound.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 初始数据定义，便于在mciSendCommand和playsound中调取命令
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
Mp3DeviceID			dd 0
Mp3Device			db "MPEGVideo",0
dbMusic_bg			db "music/bgm.wav",0
dbMusic_explode		db "music/explode.wav",0
dbMusic_missile		db "music/missile.wav",0
dbMusic_gameover	db "music/gameover.wav",0
dbSound_on dd 1
dbMusic_on dd 1
PlayParms MCI_PLAY_PARMS <>
StatusParms MCI_STATUS_PARMS <>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_Music_explode PROC uses eax
	.if dbSound_on == 1
		invoke PlaySound, offset dbMusic_explode, NULL, SND_ASYNC
	.endif
	ret
_Music_explode ENDP
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_Music_missile PROC uses eax
	.if dbSound_on == 1
		invoke PlaySound, offset dbMusic_missile, NULL, SND_ASYNC
	.endif
	ret
_Music_missile ENDP
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 背景音过程，循环播放
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
BgmRepeat PROC uses eax, hWin : DWORD, NameOfFile : DWORD
	LOCAL mciOpenParms : MCI_OPEN_PARMS, mciPlayParms : MCI_PLAY_PARMS
	mov eax, hWin
	mov mciPlayParms.dwCallback, eax
	mov eax, OFFSET Mp3Device
	mov mciOpenParms.lpstrDeviceType, eax
	mov eax, NameOfFile
	mov mciOpenParms.lpstrElementName, eax
	invoke mciSendCommand, 0, MCI_OPEN, MCI_OPEN_TYPE or MCI_OPEN_ELEMENT, addr mciOpenParms
	mov eax, mciOpenParms.wDeviceID
	mov Mp3DeviceID, eax
	invoke mciSendCommand, Mp3DeviceID, MCI_PLAY, 00010000h, addr mciPlayParms
	ret  
BgmRepeat ENDP

BgmPlay PROC uses eax, hWin:DWORD
	mov eax, hWin
	mov PlayParms.dwCallback, eax
	invoke mciSendCommand, Mp3DeviceID, MCI_PLAY, 0, addr PlayParms
	ret
BgmPlay ENDP

BgmPause PROC uses eax, hWin:DWORD
	mov eax, hWin
	mov PlayParms.dwCallback, eax
	invoke mciSendCommand, Mp3DeviceID, MCI_PAUSE, 0, addr PlayParms
	ret
BgmPause ENDP

BgmStatus PROC uses eax, hWin:DWORD
	invoke mciSendCommand, Mp3DeviceID, MCI_STATUS, MCI_STATUS_POSITION, addr StatusParms
	mov eax, StatusParms.dwReturn
	mov PlayParms.dwFrom, eax
	ret
BgmStatus ENDP
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end