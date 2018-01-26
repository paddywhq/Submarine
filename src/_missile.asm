.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include missile.inc
include score.inc
include init.inc
include sound.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwMissile MISSILE 100 dup(<0, 0, 0>)
dwMissileSize dd 100
dwMissileWidth	 dd 16
dwMissileHeight dd 16
dwMissileSpeed	 dd 7
dwMissileLeanSpeed	 dd 5
dwMissileDirectionHeight SDWORD 210
dwMissileFromSubX	 dd 20
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Missile proc	
	invoke LoadBitmap, hInstance,IDB_MISSILE_MIDDLE		;导弹
	mov hBitmap_missile_middle, eax
	invoke LoadBitmap, hInstance,IDB_MISSILE_MIDDLE_MASK
	mov hBitmap_missile_middle_mask, eax
	invoke LoadBitmap, hInstance,IDB_MISSILE_LEFT
	mov hBitmap_missile_left, eax
	invoke LoadBitmap, hInstance,IDB_MISSILE_LEFT_MASK
	mov hBitmap_missile_left_mask, eax
	invoke LoadBitmap, hInstance,IDB_MISSILE_RIGHT
	mov hBitmap_missile_right, eax
	invoke LoadBitmap, hInstance,IDB_MISSILE_RIGHT_MASK
	mov hBitmap_missile_right_mask, eax
	ret
_CreateBmp_Missile endp

_DestoryBmp_Missile proc
	invoke DeleteObject, hBitmap_missile_middle
	invoke DeleteObject, hBitmap_missile_middle_mask
	invoke DeleteObject, hBitmap_missile_left
	invoke DeleteObject, hBitmap_missile_left_mask
	invoke DeleteObject, hBitmap_missile_right
	invoke DeleteObject, hBitmap_missile_right_mask
	ret
_DestoryBmp_Missile endp

_DrawMissile proc uses esi ecx eax ebx, _hDC, _hMemDC
;-----------------
; 绘画导弹
;-----------------
	local  @MissileX1:SDWORD, @MissileY1:DWORD, @MissileX2:SDWORD, @MissileY2:DWORD, @count:DWORD
	mov esi, OFFSET dwMissile
	assume esi : PTR MISSILE
    mov eax, dwMissileSize
	mov @count, eax
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @MissileX1, eax
		mov @MissileY1, ebx
		add eax, dwMissileWidth
		add ebx, dwMissileHeight
		mov @MissileX2, eax
		mov @MissileY2, ebx
        .if [esi].Y >= 0
            .if [esi].DIRECTION == 0
		        invoke SelectObject,_hMemDC,hBitmap_missile_middle_mask  
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_middle
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCPAINT
            .elseif [esi].DIRECTION == 1
		        invoke SelectObject,_hMemDC,hBitmap_missile_left_mask  
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_left
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCPAINT
            .elseif [esi].DIRECTION == 2
		        invoke SelectObject,_hMemDC,hBitmap_missile_right_mask  
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_right
		        invoke BitBlt,_hDC,@MissileX1, @MissileY1, @MissileX2, @MissileY2,_hMemDC,0,0,SRCPAINT
            .endif
        .elseif [esi].Y < 0
            dec @MissileY1
            not @MissileY1
            .if [esi].DIRECTION == 0
		        invoke SelectObject,_hMemDC,hBitmap_missile_middle_mask  
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_middle
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCPAINT
            .elseif [esi].DIRECTION == 1
		        invoke SelectObject,_hMemDC,hBitmap_missile_left_mask  
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_left
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCPAINT
            .elseif [esi].DIRECTION == 2
		        invoke SelectObject,_hMemDC,hBitmap_missile_right_mask  
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCAND
		        invoke SelectObject,_hMemDC,hBitmap_missile_right
		        invoke BitBlt,_hDC,@MissileX1, 0, @MissileX2, @MissileY2,_hMemDC,0,@MissileY1,SRCPAINT
            .endif
        .endif
	.endif
	add esi, TYPE MISSILE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawMissile endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_FloatMissile proc uses ecx esi ebx eax,
;-----------------
;导弹追踪
;-----------------
	local @count
	mov esi, OFFSET dwMissile	;esi = dwMissile
	assume esi : PTR MISSILE
    mov eax, dwMissileSize
	mov @count, eax
CountLoop:
    .if ([esi].X > 0) || ([esi].Y > 0)
	    mov ebx, [esi].Y
        mov ecx, dwShipX
        add ecx, dwShipWidth
	    mov eax, [esi].X
        .if dwMissileDirectionHeight < ebx
            .if eax < dwShipX
	            add eax, dwMissileLeanSpeed
	            mov [esi].X, eax
	            sub ebx, dwMissileLeanSpeed
	            mov [esi].Y, ebx
                mov [esi].DIRECTION, 2
            .elseif eax > ecx
	            sub eax, dwMissileLeanSpeed
	            mov [esi].X, eax
	            sub ebx, dwMissileLeanSpeed
	            mov [esi].Y, ebx
                mov [esi].DIRECTION, 1
            .else
	            sub ebx, dwMissileSpeed
	            mov [esi].Y, ebx
                mov [esi].DIRECTION, 0
            .endif
        .else
	        sub ebx, dwMissileSpeed
	        mov [esi].Y, ebx
            mov [esi].DIRECTION, 0
        .endif
        mov ecx, 0
        sub ecx, dwMissileHeight
	    .if [esi].Y < ecx
		    mov [esi].X, 0
		    mov [esi].Y, 0
		    mov [esi].DIRECTION, 0
	    .endif
    .endif
	add esi, TYPE MISSILE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_FloatMissile endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseMissile proc uses eax ebx ecx esi, _SubX, _SubY, _direction
;-----------------
;释放导弹
;-----------------
	local @count
    mov eax, dwMissileSize
	mov @count, eax
	mov eax, _SubX		;MissileX
	mov ebx, _SubY		;MissileY
	;根据按键，确定鱼雷发射的位置，0左1右
	.if _direction == 0
		add eax, dwMissileFromSubX
	.elseif _direction == 1
		add eax, dwSubWidth
		sub eax, dwMissileFromSubX
	.endif
	;更新鱼雷坐标数组
	mov esi, OFFSET dwMissile
	assume esi:PTR MISSILE
CountLoop:
	mov ecx, [esi].X
	mov edx, [esi].Y
	.if (ecx == 0) && (edx == 0)	;是否有空鱼雷
        invoke _Music_missile
		mov [esi].X, eax
		mov [esi].Y, ebx
		mov [esi].DIRECTION, 0
		mov @count, 1
	.endif
	add esi, TYPE MISSILE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_ReleaseMissile endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MissileShip proc uses ecx esi ebx eax edx,
;-----------------
;导弹是否炸到战舰
;-----------------
	local @countMissile

	mov eax, dwMissileSize
	mov @countMissile, eax
	mov esi, OFFSET dwMissile	;esi = dwMissile
	assume esi : PTR MISSILE
MissileLoop:
	.if (dwShipDead == 0) && (([esi].X > 0) || ([esi].Y > 0))
		mov eax, dwShipX
		add eax, dwShipWidth
		sub eax, [esi].X
		mov ebx, dwShipY
		add ebx, dwShipHeight
		sub ebx, [esi].Y
		mov ecx, dwShipWidth
		add ecx, dwMissileWidth
		mov edx, dwShipHeight
		add edx, dwMissileHeight
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
            mov @countMissile, 1
		.endif
	.endif

	add esi, TYPE MISSILE
	sub @countMissile, 1
	.if @countMissile > 0
		jmp MissileLoop
	.endif 
	assume esi: nothing

	ret
_MissileShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end