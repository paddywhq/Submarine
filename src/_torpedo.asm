.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include torpedo.inc
include score.inc
include init.inc
include sound.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwTorpedo TORPEDO 15 dup(<0, 0, 0>)
dwTorpedoSize dd 15
dwTorpedoWidth	 dd 13
dwTorpedoHeight dd 13
dwTorpedoSpeed	 dd 2
dwTorpedoFromSubX	 dd 20
dwTorpedoTimeCount	 dd 2
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Torpedo proc	
	invoke LoadBitmap, hInstance,IDB_TORPEDO   	;鱼雷
	mov hBitmap_torpedo, eax
	invoke LoadBitmap, hInstance,IDB_TORPEDO_MASK
	mov hBitmap_torpedo_mask, eax	
	ret
_CreateBmp_Torpedo endp

_DestoryBmp_Torpedo proc
	invoke DeleteObject, hBitmap_torpedo
	invoke DeleteObject, hBitmap_torpedo_mask
	ret
_DestoryBmp_Torpedo endp

_DrawTorpedo proc uses esi ecx eax ebx, _hDC, _hMemDC
;-----------------
; 绘画鱼雷
;-----------------
	local  @TorpedoX1:SDWORD, @TorpedoY1:DWORD, @TorpedoX2:SDWORD, @TorpedoY2:DWORD, @count:DWORD
	mov esi, OFFSET dwTorpedo
	assume esi : PTR TORPEDO
    mov eax, dwTorpedoSize
	mov @count, eax
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @TorpedoX1, eax
		mov @TorpedoY1, ebx
		add eax, dwTorpedoWidth
		add ebx, dwTorpedoHeight
		mov @TorpedoX2, eax
		mov @TorpedoY2, ebx
		invoke SelectObject,_hMemDC,hBitmap_torpedo_mask	  
		invoke BitBlt,_hDC,@TorpedoX1, @TorpedoY1, @TorpedoX2, @TorpedoY2,_hMemDC,0,0,SRCAND
		invoke SelectObject,_hMemDC,hBitmap_torpedo
		invoke BitBlt,_hDC,@TorpedoX1, @TorpedoY1, @TorpedoX2, @TorpedoY2,_hMemDC,0,0,SRCPAINT
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_FloatTorpedo proc uses ecx esi ebx eax,
;-----------------
;鱼雷漂浮
;-----------------
	local @count
	mov esi, OFFSET dwTorpedo	;esi = dwTorpedo
	assume esi : PTR TORPEDO
    mov eax, dwTorpedoSize
	mov @count, eax
CountLoop:
	mov eax, dwTorpedoHeight
	shr eax, 1
	mov ecx, dwSkyHeight
	sub ecx, eax
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (ebx > ecx)
		sub ebx, dwTorpedoSpeed
		mov [esi].Y, ebx
	.elseif (ebx > 0)
		inc [esi].TIMECOUNT
	.endif
	mov ebx, [esi].TIMECOUNT
	.if ebx > dwTorpedoTimeCount
		mov [esi].X, 0
		mov [esi].Y, 0
		mov [esi].TIMECOUNT, 0
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_FloatTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseTorpedo proc uses eax ebx ecx esi, _SubX, _SubY, _direction
;-----------------
;释放炮弹
;-----------------
	local @count
    mov eax, dwTorpedoSize
	mov @count, eax
	mov eax, _SubX		;TorpedoX
	mov ebx, _SubY		;TorpedoY
	;根据按键，确定鱼雷发射的位置，0左1右
	.if _direction == 0
		add eax, dwTorpedoFromSubX
	.elseif _direction == 1
		add eax, dwSubWidth
		sub eax, dwTorpedoFromSubX
	.endif
	;更新鱼雷坐标数组
	mov esi, OFFSET dwTorpedo
	assume esi:PTR TORPEDO
CountLoop:
	mov ecx, [esi].X
	mov edx, [esi].Y
	.if (ecx == 0) && (edx == 0)	;是否有空鱼雷
		mov [esi].X, eax
		mov [esi].Y, ebx
		mov [esi].TIMECOUNT, 0
		mov @count, 1
	.endif
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_ReleaseTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_TorpedoShip proc uses ecx esi ebx eax edx,
;-----------------
;鱼雷是否炸到战舰
;-----------------
	local @countTorpedo

	mov eax, dwTorpedoSize
	mov @countTorpedo, eax
	mov esi, OFFSET dwTorpedo	;esi = dwTorpedo
	assume esi : PTR TORPEDO
TorpedoLoop:
	.if (dwShipDead == 0) && (([esi].X > 0) || ([esi].Y > 0))
		mov eax, dwShipX
		add eax, dwShipWidth
		sub eax, [esi].X
		mov ebx, dwShipY
		add ebx, dwShipHeight
		sub ebx, [esi].Y
		mov ecx, dwShipWidth
		add ecx, dwTorpedoWidth
		mov edx, dwShipHeight
		add edx, dwTorpedoHeight
		sub ecx, 11 ;为了让连炸效果更逼真
		.if (eax > 11) && (eax < ecx) && (ebx > 0) && (ebx < edx)
			invoke _Music_explode
            mov dwShipDead, 1
            dec dwLife
            .if dwLife == 0
                mov dwShipGameover, 1
            .endif
            invoke _initTorpedo
            invoke _initMissile
            invoke _initBomb
            ;mov [esi].X, 0
            ;mov [esi].Y, 0
            mov @countTorpedo, 1
		.endif
	.endif

	add esi, TYPE TORPEDO
	sub @countTorpedo, 1
	.if @countTorpedo > 0
		jmp TorpedoLoop
	.endif 
	assume esi: nothing

	ret
_TorpedoShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end