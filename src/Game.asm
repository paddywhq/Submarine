.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Include 库文件
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
; Include 自定义文件
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include bomb.inc
include rand.inc
include sub1.inc
include sub2.inc
include sub3.inc
include sub4.inc
include torpedo.inc
include missile.inc
include explode.inc
include timer.inc
include score.inc
include init.inc
include sound.inc
include level.inc
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

IDM_MAIN    equ   1000h
IDA_MAIN    equ   1000h
IDM_START   equ   1001h
IDM_PAUSE	equ   1002h
IDM_EXIT	equ   1003h
IDM_INFO	equ   1004h
IDM_ABOUT	equ   1005h
IDM_CONTINUE equ  1006h
IDM_MUSIC equ 1007h
IDM_SOUND_EFFECT equ 1008h
IDM_LEVEL1 equ 1011h
IDM_LEVEL2 equ 1012h
IDM_LEVEL3 equ 1013h
IDM_LEVEL4 equ 1014h
IDM_LEVEL5 equ 1015h
IDM_LEVEL6 equ 1016h
IDM_LEVEL7 equ 1017h
IDM_LEVEL8 equ 1018h
IDM_LEVEL9 equ 1019h
IDM_LEVEL0 equ 1010h
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 数据段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
szAbout db "++++++++++++++++++++++++++++++++++",0ah, 0dh,
		   "                       Great Navy Battles",0ah, 0dh,
		   "++++++++++++++++++++++++++++++++++",0ah, 0dh,
		   "By : Huaqing Wang, Yuting Wang, Hao Sun", 0ah, 0dh,
		   "Version : 3.14.1.5926", 0ah, 0dh, 
		   "Date : 2014/04/13", 0
		
szInfo db "Use left(<-) an right(->) to move the battleship", 0ah, 0dh,
		  "Use Z,X,C to drop bomb.", 0ah, 0dh,
		  "Watch out submarines and missiles!!", 0
szCaption_Info db "Game Guide", 0
szCaption_About db "About", 0
szMenu_continue db "Continue(&O)", 0
szMenu_pause db "Pause(&P)", 0
ClassName db "Great Navy Battles",0
AppName  db "Great Navy Battles",0
CommandLine LPSTR ?
hMenu	dd	?

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 代码段
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_Init proc

_Init endp
_CreateBmp proc uses eax
	invoke LoadBitmap,hInstance,IDB_BACKGROUND		;背景图
	mov hBitmap_background,eax
	invoke LoadBitmap,hInstance,IDB_BACKGROUND_GAMEOVER
	mov hBitmap_background_gameover,eax
	invoke LoadBitmap,hInstance,IDB_BACKGROUND_PAUSE
	mov hBitmap_background_pause,eax
	invoke LoadBitmap,hInstance,IDB_BACKGROUND_DIE
	mov hBitmap_background_die,eax
	invoke _CreateBmp_Ship
	invoke _CreateBmp_Bomb	
	invoke _CreateBmp_Sub1
	invoke _CreateBmp_Sub2
	invoke _CreateBmp_Sub3	
	invoke _CreateBmp_Sub4	
	invoke _CreateBmp_Torpedo	
	invoke _CreateBmp_Missile
	invoke _CreateBmp_Explode
	invoke _CreateBmp_Number
	ret
_CreateBmp endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DestroyBmp proc
	invoke DeleteObject, hBitmap_background
	invoke DeleteObject, hBitmap_background_gameover
	invoke DeleteObject, hBitmap_background_pause
	invoke DeleteObject, hBitmap_background_die
	invoke _DestoryBmp_Ship
	invoke _DestoryBmp_Bomb
	invoke _DestoryBmp_Sub1
	invoke _DestoryBmp_Sub2
	invoke _DestoryBmp_Sub3
	invoke _DestoryBmp_Sub4
	invoke _DestoryBmp_Torpedo
	invoke _DestoryBmp_Missile
	invoke _DestoryBmp_Explode	
	invoke _DestoryBmp_Number
	ret
_DestroyBmp endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
start:
	invoke GetModuleHandle, NULL
	mov    hInstance,eax
	;wyt
	invoke	LoadMenu,hInstance,IDM_MAIN
	mov	hMenu,eax	
	invoke GetCommandLine
	mov    CommandLine,eax
	invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
	invoke ExitProcess,eax
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	LOCAL hwnd:HWND
	LOCAL @hAccelerator
	invoke	LoadAccelerators,hInstance,IDA_MAIN
	mov	@hAccelerator,eax
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	mov   wc.cbClsExtra,NULL
	mov   wc.cbWndExtra,NULL
	push  hInstance
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_WINDOW+1
	mov   wc.lpszMenuName,NULL
	mov   wc.lpszClassName,OFFSET ClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	mov   wc.hIconSm,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	invoke RegisterClassEx, addr wc
;********************************************************************
; 建立并显示窗口
;********************************************************************
		
	INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
		   WS_OVERLAPPED or WS_CAPTION or WS_SYSMENU ,\
		   dwWindowX,dwWindowY,dwWindowWidth,dwWindowHeight,
		   NULL,hMenu, hInst,NULL
	mov   hwnd,eax
	mov   hWinMain,eax
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow, hwnd
    invoke BgmRepeat ,hwnd, addr dbMusic_bg
;********************************************************************
; 消息循环
;********************************************************************
	.while TRUE
		invoke GetMessage, ADDR msg,NULL,0,0
		.break .if eax == 0
		invoke TranslateAccelerator, hWinMain, @hAccelerator, ADDR msg
		.if eax == 0
		invoke TranslateMessage, ADDR msg
		invoke DispatchMessage, ADDR msg
		.endif
	.endw
	mov     eax,msg.wParam
	ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
   LOCAL ps:PAINTSTRUCT
   LOCAL hdc:HDC
   LOCAL hMemDC:HDC
   LOCAL hImgDC:HDC
   LOCAL hImg:HBITMAP
   LOCAL rect:RECT
   ;加载图片
   .if uMsg==WM_CREATE 
        invoke LoadIcon, hInstance, ICO_ICON
        mov hIcon, eax
        invoke SendMessage, hWnd, WM_SETICON, ICON_BIG, hIcon
		invoke _CreateBmp
	;初始化
	.elseif uMsg == WM_SIZE
		invoke  _initShip
		invoke  _SetTimer
	.elseif uMsg == WM_COMMAND
		mov eax, wParam
		movzx eax, ax
		.if eax == IDM_START
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            invoke _initScore
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_CONTINUE
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			invoke	InvalidateRect,hWnd,NULL,FALSE
            .if dwShipGameover == 1
                mov eax, 0
            .elseif dwShipPause == 1
                dec dwShipPause
            .endif
			invoke _SetTimer
		.elseif eax == IDM_MUSIC
			invoke GetMenuState, hMenu, IDM_MUSIC, MF_BYCOMMAND
			.if eax & MF_CHECKED				
				invoke CheckMenuItem, hMenu, IDM_MUSIC, MF_UNCHECKED
				mov dbMusic_on, 0
				invoke BgmPause, hWnd
				invoke BgmStatus, hWnd
			.else
				invoke CheckMenuItem, hMenu, IDM_MUSIC, MF_CHECKED
				mov dbMusic_on, 1
				invoke BgmPlay, hWnd
			.endif
		.elseif eax == IDM_SOUND_EFFECT
			invoke GetMenuState, hMenu, IDM_SOUND_EFFECT, MF_BYCOMMAND
			.if eax & MF_CHECKED
				invoke CheckMenuItem, hMenu, IDM_SOUND_EFFECT, MF_UNCHECKED
				mov dbSound_on, 0
			.else
				invoke CheckMenuItem, hMenu, IDM_SOUND_EFFECT, MF_CHECKED
				mov dbSound_on, 1
			.endif
		.elseif eax == IDM_PAUSE			
            .if (dwShipPause == 0) && (dwShipGameover == 0)
				invoke ModifyMenu,hMenu,IDM_PAUSE,MF_BYCOMMAND,IDM_CONTINUE,addr szMenu_continue;修改菜单项"Continue(&O)...Ctrl+O"
			    inc dwShipPause
                invoke _KillTimer
            .endif
		.elseif eax == IDM_EXIT
			invoke _DestroyBmp
			invoke _KillTimer
			invoke PostQuitMessage,NULL
		.elseif eax == IDM_INFO
            .if  (dwShipPause == 0) && (dwShipGameover == 0)
                .if (dwShipPause == 0) && (dwShipGameover == 0)
			        inc dwShipPause
                    invoke _KillTimer
                .endif
			    invoke	MessageBox,NULL,offset szInfo,offset szCaption_Info,MB_OK
                .if (dwShipPause == 1) && (dwShipGameover == 0)
			        dec dwShipPause
                    invoke _SetTimer
                .endif
            .else
			    invoke	MessageBox,NULL,offset szInfo,offset szCaption_Info,MB_OK
            .endif
		.elseif eax == IDM_ABOUT
            .if  (dwShipPause == 0) && (dwShipGameover == 0)
                .if (dwShipPause == 0) && (dwShipGameover == 0)
			        inc dwShipPause
                    invoke _KillTimer
                .endif
			    invoke	MessageBox,NULL,offset szAbout,offset szCaption_About,MB_OK
                .if (dwShipPause == 1) && (dwShipGameover == 0)
			        dec dwShipPause
                    invoke _SetTimer
                .endif
            .else
			    invoke	MessageBox,NULL,offset szAbout,offset szCaption_About,MB_OK
            .endif
		.elseif eax == IDM_LEVEL1
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 1
            mov dwScore, 0
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL2
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 2
            mov dwScore, 100
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL3
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 3
            mov dwScore, 300
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL4
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 4
            mov dwScore, 550
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL5
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 5
            mov dwScore, 800
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL6
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 6
            mov dwScore, 1250
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL7
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 7
            mov dwScore, 1800
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL8
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 8
            mov dwScore, 2400
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL9
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 9
            mov dwScore, 3100
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.elseif eax == IDM_LEVEL0
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _initShip
            invoke _initSub
            invoke _initExplode
            invoke _initBomb
            invoke _initTorpedo
            invoke _initMissile
            mov dwLevel, 0
            mov dwScore, 4000
            mov dwLife, 5
            invoke _KillTimer
		    invoke  _SetTimer
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_ENABLED
			invoke ModifyMenu,hMenu,IDM_CONTINUE,MF_BYCOMMAND,IDM_PAUSE,addr szMenu_pause;修改菜单项
			.if dwShipGameover == 1
				dec dwShipGameover
			.endif
		.endif
	;按键反应
    .elseif uMsg == WM_KEYUP
		mov eax, wParam
		.if ax == VK_LEFT
			and dwShipKeyDown, 2
            mov dwShipDirection, 1
		.elseif ax == VK_RIGHT
			and dwShipKeyDown, 1
            mov dwShipDirection, 0
		.endif
	.elseif uMsg == WM_KEYDOWN
		mov eax, wParam
		.if ax == VK_LEFT
            or dwShipKeyDown, 1
            mov dwShipDirection, 0
		.elseif ax == VK_RIGHT
            or dwShipKeyDown, 2
            mov dwShipDirection, 1
		.elseif ax == VK_Z
			invoke _ReleaseBomb, 0
		.elseif ax == VK_X
			invoke _ReleaseBomb, 1
		.elseif ax == VK_C
			invoke _ReleaseBomb, 2	
		.endif
		invoke	InvalidateRect,hWnd,NULL,FALSE
	;定时器消息，让整个客户区失效，重新绘制WM_Paint
	;InvalidRect函数最后的True参数要求把整个客户区清除成背景色
	.elseif	uMsg ==	WM_TIMER
		mov	eax,wParam
		.if	eax ==	ID_TIMER
			invoke	InvalidateRect,hWnd,NULL,FALSE
			invoke _MoveShip
			invoke _MoveSub1
			invoke _MoveSub2
			invoke _MoveSub3
			invoke _MoveSub4
			invoke _BombSub
			invoke _BoomSub
            invoke _BoomShip
            invoke _TorpedoShip
            invoke _MissileShip
		.elseif eax == ID_TIMER_BOMB
			invoke _DropBomb
			invoke _FloatTorpedo
			invoke _FloatMissile
			invoke _ChangeBoomPic
		.elseif eax == ID_TIMER_RANDOM
            invoke _SetLevel
		.elseif eax == ID_TIMER_CHANGEPIC
			invoke _ChangeBombPic
		.endif
	;画图片
   .elseif uMsg==WM_PAINT 
		invoke BeginPaint,hWnd,addr ps
		mov hdc,eax
		invoke CreateCompatibleDC,hdc
		mov hMemDC,eax
    	invoke CreateCompatibleDC, hdc
        mov hImgDC, eax
    	invoke CreateCompatibleBitmap, hdc, dwWindowWidth, dwWindowHeight
	    mov hImg, eax
        invoke SelectObject,hMemDC,hImg

		invoke GetClientRect,hWnd,addr rect		
		invoke SelectObject,hImgDC,hBitmap_background	;背景图
		invoke BitBlt,hMemDC,0,0,rect.right,rect.bottom,hImgDC,0,0,SRCCOPY
		invoke _DrawBomb, hMemDC, hImgDC		;画炸弹
		invoke _DrawShip, hMemDC, hImgDC		;画战舰
		invoke _DrawBoom, hMemDC, hImgDC		;画爆炸效果
		invoke _DrawTorpedo, hMemDC, hImgDC		;画鱼雷
		invoke _DrawMissile, hMemDC, hImgDC		;画导弹
		invoke _DrawSub1, hMemDC, hImgDC		;画潜艇1
		invoke _DrawSub2, hMemDC, hImgDC		;画潜艇2
		invoke _DrawSub3, hMemDC, hImgDC		;画潜艇3
		invoke _DrawSub4, hMemDC, hImgDC		;画潜艇4
        .if dwShipGameover == 1
		    invoke SelectObject,hImgDC,hBitmap_background_gameover
		    invoke BitBlt,hMemDC,0,0,rect.right,rect.bottom,hImgDC,0,0,SRCPAINT
			invoke EnableMenuItem, hMenu, IDM_PAUSE, MF_DISABLED
        .elseif dwShipPause == 1
		    invoke SelectObject,hImgDC,hBitmap_background_pause
		    invoke BitBlt,hMemDC,0,0,rect.right,rect.bottom,hImgDC,0,0,SRCPAINT
        .elseif dwShipDead > 1
		    invoke SelectObject,hImgDC,hBitmap_background_die
		    invoke BitBlt,hMemDC,0,0,rect.right,rect.bottom,hImgDC,0,0,SRCPAINT
        .endif
		invoke _DrawScore, hMemDC, hImgDC
		invoke BitBlt,hdc,0,0,rect.right,rect.bottom,hMemDC,0,0,SRCCOPY
		invoke DeleteDC,hMemDC
		invoke DeleteDC,hImgDC
	    invoke DeleteObject, hImg
		invoke EndPaint,hWnd,addr ps
	;清理
	.elseif uMsg==WM_DESTROY
		invoke _DestroyBmp
		invoke _KillTimer
		invoke PostQuitMessage,NULL
	.ELSE
		invoke DefWindowProc,hWnd,uMsg,wParam,lParam		
		ret
	.ENDIF
	xor eax,eax
	ret
WndProc endp
end start
