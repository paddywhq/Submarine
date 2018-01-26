.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include score.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwLevel dd 1
dwScore dd 0
dwLife  SDWORD 5
dwNumberWidth dd 18
dwNumberHeight dd 18
dwIconWidth dd 24
dwIconHeight dd 24

dwLevelIconX dd 10
dwLevelIconY dd 10
dwLevelX dd 40
dwLevelY dd 10

dwScoreIconX dd 500
dwScoreIconY dd 10
dwScoreX dd 600
dwScoreY dd 10

dwLifeIconX dd 435
dwLifeIconY dd 10
dwLifeX dd 465
dwLifeY dd 10

arrayScore dd 5 dup(0)
dwScoreSub1 dd 10
dwScoreSub2 dd 20
dwScoreSub3 dd 50
dwScoreSub4 dd 100
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_DrawIcon proc uses eax ebx, _hDC, _hMemDC
;------------------------
;画关卡，生命，得分的icon
;-------------------------
	local @X1, @X2, @Y1, @Y2
	mov eax, dwLifeIconX
	mov ebx, dwLifeIconY
	mov @X1, eax
	mov @Y1, ebx
	add eax, dwIconWidth
	add ebx, dwIconHeight
	mov @X2, eax
	mov @Y2, ebx
	invoke SelectObject,_hMemDC,hBitmap_life_mask	  
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCAND
	invoke SelectObject,_hMemDC,hBitmap_life
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCPAINT

	mov eax, dwScoreIconX
	mov ebx, dwScoreIconY
	mov @X1, eax
	mov @Y1, ebx
	add eax, dwIconWidth
	add ebx, dwIconHeight
	mov @X2, eax
	mov @Y2, ebx
	invoke SelectObject,_hMemDC,hBitmap_point_mask	  
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCAND
	invoke SelectObject,_hMemDC,hBitmap_point
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCPAINT

	mov eax, dwLevelIconX
	mov ebx, dwLevelIconY
	mov @X1, eax
	mov @Y1, ebx
	add eax, dwIconWidth
	add ebx, dwIconHeight
	mov @X2, eax
	mov @Y2, ebx
	invoke SelectObject,_hMemDC,hBitmap_level_mask	  
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCAND
	invoke SelectObject,_hMemDC,hBitmap_level
	invoke BitBlt,_hDC,@X1, @Y1, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	ret
_DrawIcon endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawNumber proc uses eax ebx, _hDC, _hMemDC, 
	_Number:DWORD, 
	_X:DWORD, _Y:DWORD
	local @X2:DWORD, @Y2:DWORD
;-----------------------
;在屏幕上显示一个数字
;参数：X，Y坐标，数字大小
;-----------------------
	mov ebx, _X
	add ebx, dwNumberWidth
	mov @X2, ebx
	mov ebx, _Y
	add ebx, dwNumberHeight
	mov @Y2, ebx
	.if _Number == 9
		invoke SelectObject,_hMemDC,hBitmap_number9
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 8
		invoke SelectObject,_hMemDC,hBitmap_number8
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 7
		invoke SelectObject,_hMemDC,hBitmap_number7
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 6
		invoke SelectObject,_hMemDC,hBitmap_number6
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 5
		invoke SelectObject,_hMemDC,hBitmap_number5
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 4
		invoke SelectObject,_hMemDC,hBitmap_number4
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 3
		invoke SelectObject,_hMemDC,hBitmap_number3
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 2
		invoke SelectObject,_hMemDC,hBitmap_number2
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 1
		invoke SelectObject,_hMemDC,hBitmap_number1
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.elseif _Number == 0
		invoke SelectObject,_hMemDC,hBitmap_number0
		invoke BitBlt,_hDC,_X, _Y, @X2, @Y2,_hMemDC,0,0,SRCPAINT
	.endif
	ret
_DrawNumber endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawScore proc uses edi eax ebx ecx edx, _hDC, _hMemDC
;------------------------
;画分数
;-------------------------
	local @count:WORD
	invoke _DrawIcon, _hDC, _hMemDC
	invoke _DrawNumber, _hDC, _hMemDC, dwLevel, dwLevelX, dwLevelY
	invoke _DrawNumber, _hDC, _hMemDC, dwLife, dwLifeX, dwLifeY
	mov @count, 5
	mov edi, dwScoreX
	mov eax, dwScore
	mov ecx, 5
ScoreLoop:
	mov edx, 0	
	mov bx, 10
	div bx		;result = ax, left = dx
	invoke _DrawNumber, _hDC, _hMemDC, edx, edi, dwScoreY
	sub edi, dwNumberWidth
	sub @count, 1
	.if @count > 0
		jmp ScoreLoop
	.endif
	ret
_DrawScore endp


_CreateBmp_Number proc
	invoke LoadBitmap, hInstance,IDB_NUMBER0
	mov hBitmap_number0, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER1
	mov hBitmap_number1, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER2
	mov hBitmap_number2, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER3
	mov hBitmap_number3, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER4
	mov hBitmap_number4, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER5
	mov hBitmap_number5, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER6
	mov hBitmap_number6, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER7
	mov hBitmap_number7, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER8
	mov hBitmap_number8, eax
	invoke LoadBitmap, hInstance,IDB_NUMBER9
	mov hBitmap_number9, eax
	invoke LoadBitmap, hInstance,IDB_LIFE
	mov hBitmap_life, eax
	invoke LoadBitmap, hInstance,IDB_LIFE_MASK
	mov hBitmap_life_mask, eax
	invoke LoadBitmap, hInstance,IDB_POINT
	mov hBitmap_point, eax
	invoke LoadBitmap, hInstance,IDB_POINT_MASK
	mov hBitmap_point_mask, eax
	invoke LoadBitmap, hInstance,IDB_LEVEL
	mov hBitmap_level, eax
	invoke LoadBitmap, hInstance,IDB_LEVEL_MASK
	mov hBitmap_level_mask, eax
	ret
_CreateBmp_Number endp

_DestoryBmp_Number proc
	invoke DeleteObject, hBitmap_number0
	invoke DeleteObject, hBitmap_number1
	invoke DeleteObject, hBitmap_number2
	invoke DeleteObject, hBitmap_number3
	invoke DeleteObject, hBitmap_number4
	invoke DeleteObject, hBitmap_number5
	invoke DeleteObject, hBitmap_number6
	invoke DeleteObject, hBitmap_number7
	invoke DeleteObject, hBitmap_number8
	invoke DeleteObject, hBitmap_number9
	invoke DeleteObject, hBitmap_life
	invoke DeleteObject, hBitmap_life_mask
	invoke DeleteObject, hBitmap_point
	invoke DeleteObject, hBitmap_point_mask
	invoke DeleteObject, hBitmap_level
	invoke DeleteObject, hBitmap_level_mask
	ret
_DestoryBmp_Number endp
end