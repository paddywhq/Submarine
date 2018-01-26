.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include bomb.inc
include explode.inc
include sub1.inc
include sub2.inc
include sub3.inc
include sub4.inc
include score.inc
include init.inc
include sound.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwBomb BOMB 5 dup(<0, 0>)
dwBombSize dd 5
dwBombWidth	 dd 20
dwBombHeight dd 20
dwBombSpeed	 dd 2
dwBombPic dd 0 ;炮弹图片状态，0中，1左，2中，3右，按0123次序切换
dwUnusedBombX dd 80
dwUnusedBombY dd 10
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Bomb proc
	invoke LoadBitmap, hInstance,IDB_BOMB_MIDDLE		;炸弹
	mov hBitmap_bomb_middle, eax
	invoke LoadBitmap, hInstance,IDB_BOMB_MIDDLE_MASK
	mov hBitmap_bomb_middle_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOMB_LEFT
	mov hBitmap_bomb_left, eax
	invoke LoadBitmap, hInstance,IDB_BOMB_LEFT_MASK
	mov hBitmap_bomb_left_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOMB_RIGHT
	mov hBitmap_bomb_right, eax
	invoke LoadBitmap, hInstance,IDB_BOMB_RIGHT_MASK
	mov hBitmap_bomb_right_mask, eax
	ret
_CreateBmp_Bomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DestoryBmp_Bomb proc
	invoke DeleteObject, hBitmap_bomb_middle
	invoke DeleteObject, hBitmap_bomb_middle_mask
	invoke DeleteObject, hBitmap_bomb_left
	invoke DeleteObject, hBitmap_bomb_left_mask
	invoke DeleteObject, hBitmap_bomb_right
	invoke DeleteObject, hBitmap_bomb_right_mask
	ret
_DestoryBmp_Bomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawBomb proc uses esi ecx eax ebx, _hDC, _hMemDC
;-----------------
; 绘画炮弹
;-----------------
	local  @bombX1:SDWORD, @bombY1:DWORD, @bombX2:SDWORD, @bombY2:DWORD, @count:DWORD, @unusedX:DWORD
	mov esi, OFFSET dwBomb
	assume esi : PTR BOMB
	mov eax, dwBombSize
	mov @count, eax
	mov ecx, dwUnusedBombX
	mov @unusedX, ecx
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @bombX1, eax
		mov @bombY1, ebx
		add eax, dwBombWidth
		add ebx, dwBombHeight
		mov @bombX2, eax
		mov @bombY2, ebx
		.if (dwBombPic == 0) || (dwBombPic == 2)
			invoke SelectObject,_hMemDC,hBitmap_bomb_middle_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_middle
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.elseif dwBombPic == 1
			invoke SelectObject,_hMemDC,hBitmap_bomb_left_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_left
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.elseif dwBombPic == 3
			invoke SelectObject,_hMemDC,hBitmap_bomb_right_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_right
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.endif
	.else
		mov eax, @unusedX
		mov ecx, dwBombWidth
		add @unusedX, ecx
		mov ebx, dwUnusedBombY
		mov @bombX1, eax
		mov @bombY1, ebx
		add eax, dwBombWidth
		add ebx, dwBombHeight
		mov @bombX2, eax
		mov @bombY2, ebx
		.if (dwBombPic == 0) || (dwBombPic == 2)
			invoke SelectObject,_hMemDC,hBitmap_bomb_middle_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_middle
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.elseif dwBombPic == 1
			invoke SelectObject,_hMemDC,hBitmap_bomb_left_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_left
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.elseif dwBombPic == 3
			invoke SelectObject,_hMemDC,hBitmap_bomb_right_mask	  
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_bomb_right
			invoke BitBlt,_hDC,@bombX1, @bombY1, @bombX2, @bombY2,_hMemDC,0,0,SRCPAINT
		.endif
	.endif
	add esi, TYPE BOMB
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawBomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DropBomb proc uses ecx esi ebx eax,
;-----------------
;炮弹下落
;-----------------
	local @count,@stRect:RECT
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	ecx,@stRect.bottom
	sub	ecx,@stRect.top		;ecx = 高度
	mov esi, OFFSET dwBomb	;esi = dwWBomb
	assume esi : PTR BOMB
	mov eax, dwBombSize
	mov @count, eax
CountLoop:
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (ebx >= dwSkyHeight)	;炮弹是否被释放
		add ebx, dwBombSpeed	;释放，下落
		mov [esi].Y, ebx		;更新炮弹坐标数组
	.endif	
	.if ebx > ecx				;已经落到海底，增加炮弹
		mov [esi].X, 0
		mov [esi].Y, 0
	.endif
	add esi, TYPE BOMB
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DropBomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ChangeBombPic proc
;-----------------
;切换炮弹图片
;-----------------
	inc dwBombPic
	.if dwBombPic == 4
		mov dwBombPic, 0
	.endif
	ret
_ChangeBombPic endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseBomb proc uses eax ebx ecx esi, _direction
;-----------------
;释放炮弹
;-----------------
	local @count
    .if (dwShipDead == 0) && (dwShipPause == 0) && (dwShipGameover == 0)
	    mov eax, dwBombSize
	    mov @count, eax
	    mov eax, dwShipX		;bombX
	    mov ebx, dwShipY		;bombY
	    add ebx, dwShipHeight
	    ;根据按键，确定炮弹发射的位置，0左1中2右
	    .if _direction == 0
		    add eax, 0
	    .elseif _direction == 1
		    mov ecx, dwShipWidth
		    shr ecx, 1
		    add eax, ecx
		    mov ecx, dwBombWidth
		    shr ecx, 1
		    sub eax, ecx
	    .elseif _direction == 2
		    add eax, dwShipWidth
		    sub eax, dwBombWidth
	    .endif
	    ;更新炮弹坐标数组
	    mov esi, OFFSET dwBomb
	    assume esi:PTR BOMB
    CountLoop:
	    mov ecx, [esi].X
	    mov edx, [esi].Y
	    .if (ecx == 0) && (edx == 0)	;是否有空炮弹
		    mov [esi].X, eax
		    mov [esi].Y, ebx
		    mov @count, 1
	    .endif
	    add esi, TYPE BOMB
	    sub @count, 1
	    .if @count > 0
		    jmp CountLoop
	    .endif

	    assume esi: nothing
    .endif
	ret
_ReleaseBomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_BombSub proc uses ecx esi ebx eax edx edi,
;-----------------
;炮弹是否炸到潜艇
;-----------------
	local @countBomb,@countSub

	mov eax, dwBombSize
	mov @countBomb, eax
	mov esi, OFFSET dwBomb	;esi = dwBomb
	assume esi : PTR BOMB
BombLoop:
	.if ([esi].X > 0) || ([esi].Y > 0)
		mov edi, OFFSET dwSub1	;edi = dwSub1
		assume edi : PTR SUBMARINE
		mov eax, dwSub1Size
		mov @countSub, eax
	Sub1Loop:
		.if ([edi].X > 0) || ([edi].Y > 0)
			mov eax, [edi].X
			add eax, dwSubWidth
			sub eax, [esi].X
			mov ebx, [edi].Y
			add ebx, dwSubHeight
			sub ebx, [esi].Y
			mov ecx, dwSubWidth
			add ecx, dwBombWidth
			mov edx, dwSubHeight
			add edx, dwBombHeight
			.if (eax > 0) && (eax < ecx) && (ebx > 0) && (ebx < edx)
				invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y
				
				mov ecx, dwScore
				add ecx, dwScoreSub1
				mov dwScore, ecx
				mov [esi].X, 0
				mov [esi].Y, 0
				mov [edi].X, 0
				mov [edi].Y, 0
			.endif
		.endif
		add edi, TYPE SUBMARINE
		sub @countSub, 1
		.if @countSub > 0
			jmp Sub1Loop
		.endif
		assume edi: nothing

		mov edi, OFFSET dwSub2	;edi = dwSub2
		assume edi : PTR SUBMARINE
		mov eax, dwSub2Size
		mov @countSub, eax
	Sub2Loop:
		.if ([edi].X > 0) || ([edi].Y > 0)
			mov eax, [edi].X
			add eax, dwSubWidth
			sub eax, [esi].X
			mov ebx, [edi].Y
			add ebx, dwSubHeight
			sub ebx, [esi].Y
			mov ecx, dwSubWidth
			add ecx, dwBombWidth
			mov edx, dwSubHeight
			add edx, dwBombHeight
			.if (eax > 0) && (eax < ecx) && (ebx > 0) && (ebx < edx)
				invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y
				
				mov ecx, dwScore
				add ecx, dwScoreSub2
				mov dwScore, ecx
				mov [esi].X, 0
				mov [esi].Y, 0
				mov [edi].X, 0
				mov [edi].Y, 0
			.endif
		.endif
		add edi, TYPE SUBMARINE
		sub @countSub, 1
		.if @countSub > 0
			jmp Sub2Loop
		.endif
		assume edi: nothing

		mov edi, OFFSET dwSub3	;edi = dwSub3
		assume edi : PTR SUBMARINE
		mov eax, dwSub3Size
		mov @countSub, eax
	Sub3Loop:
		.if ([edi].X > 0) || ([edi].Y > 0)
			mov eax, [edi].X
			add eax, dwSubWidth
			sub eax, [esi].X
			mov ebx, [edi].Y
			add ebx, dwSubHeight
			sub ebx, [esi].Y
			mov ecx, dwSubWidth
			add ecx, dwBombWidth
			mov edx, dwSubHeight
			add edx, dwBombHeight
			.if (eax > 0) && (eax < ecx) && (ebx > 0) && (ebx < edx)
				invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y
				
				mov ecx, dwScore
				add ecx, dwScoreSub3
				mov dwScore, ecx
				mov [esi].X, 0
				mov [esi].Y, 0
				mov [edi].X, 0
				mov [edi].Y, 0
			.endif
		.endif
		add edi, TYPE SUBMARINE
		sub @countSub, 1
		.if @countSub > 0
			jmp Sub3Loop
		.endif
		assume edi: nothing

		mov edi, OFFSET dwSub4	;edi = dwSub4
		assume edi : PTR SUBMARINE
		mov eax, dwSub4Size
		mov @countSub, eax
	Sub4Loop:
		.if ([edi].X > 0) || ([edi].Y > 0)
			mov eax, [edi].X
			add eax, dwSubWidth
			sub eax, [esi].X
			mov ebx, [edi].Y
			add ebx, dwSubHeight
			sub ebx, [esi].Y
			mov ecx, dwSubWidth
			add ecx, dwBombWidth
			mov edx, dwSubHeight
			add edx, dwBombHeight
			.if (eax > 0) && (eax < ecx) && (ebx > 0) && (ebx < edx)
				invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y
				
				mov ecx, dwScore
				add ecx, dwScoreSub4
				mov dwScore, ecx
				mov [esi].X, 0
				mov [esi].Y, 0
				mov [edi].X, 0
				mov [edi].Y, 0
			.endif
		.endif
		add edi, TYPE SUBMARINE
		sub @countSub, 1
		.if @countSub > 0
			jmp Sub4Loop
		.endif
		assume edi: nothing
	.endif

	add esi, TYPE BOMB
	sub @countBomb, 1
	.if @countBomb > 0
		jmp BombLoop
	.endif 
	assume esi: nothing

	ret
_BombSub endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end