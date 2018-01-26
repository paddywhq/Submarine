.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include sub4.inc
include rand.inc
include missile.inc
include init.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwSub4 SUBMARINE 1 dup(<0, 0, 0, 0, 0>)
dwSub4Size dd 1
dwSub4MissileTime dd 15
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Sub4 proc
	invoke LoadBitmap, hInstance,IDB_SUB4_LEFT   	;Ǳͧ4
	mov hBitmap_sub4_left, eax
	invoke LoadBitmap, hInstance,IDB_SUB4_LEFT_MASK
	mov hBitmap_sub4_left_mask, eax
	invoke LoadBitmap, hInstance,IDB_SUB4_RIGHT
	mov hBitmap_sub4_right, eax
	invoke LoadBitmap, hInstance,IDB_SUB4_RIGHT_MASK
	mov hBitmap_sub4_right_mask, eax
	ret
_CreateBmp_Sub4 endp
_DestoryBmp_Sub4 proc
	invoke DeleteObject, hBitmap_sub4_left
	invoke DeleteObject, hBitmap_sub4_left_mask
	invoke DeleteObject, hBitmap_sub4_right
	invoke DeleteObject, hBitmap_sub4_right_mask
	ret
_DestoryBmp_Sub4 endp
_DrawSub4 proc uses esi eax ebx, _hDC, _hMemDC
;-----------------
; �滭Ǳͧ4
;-----------------
	local  @subX1:SDWORD, @subY1:DWORD, @subX2:SDWORD, @subY2:DWORD, @count:DWORD

	mov esi, OFFSET dwSub4
	assume esi : PTR SUBMARINE
    mov eax, dwSub4Size
	mov @count, eax
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @subX1, eax
		mov @subY1, ebx
		add eax, dwSubWidth
		add ebx, dwSubHeight
		mov @subX2, eax
		mov @subY2, ebx
        .if [esi].X >= 0
		    .if [esi].DIRECTION == 0
			    invoke SelectObject,_hMemDC,hBitmap_sub4_left_mask	  
			    invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCAND
			    invoke SelectObject,_hMemDC,hBitmap_sub4_left
			    invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCPAINT
		    .elseif [esi].DIRECTION == 1
			    invoke SelectObject,_hMemDC,hBitmap_sub4_right_mask	  
			    invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCAND
			    invoke SelectObject,_hMemDC,hBitmap_sub4_right
			    invoke BitBlt,_hDC,@subX1, @subY1, @subX2, @subY2,_hMemDC,0,0,SRCPAINT
		    .endif
        .elseif [esi].X < 0
            dec @subX1
            not @subX1
		    .if [esi].DIRECTION == 0
			    invoke SelectObject,_hMemDC,hBitmap_sub4_left_mask	  
			    invoke BitBlt,_hDC,0, @subY1, @subX2, @subY2,_hMemDC,@subX1,0,SRCAND
			    invoke SelectObject,_hMemDC,hBitmap_sub4_left
			    invoke BitBlt,_hDC,0, @subY1, @subX2, @subY2,_hMemDC,@subX1,0,SRCPAINT
		    .elseif [esi].DIRECTION == 1
			    invoke SelectObject,_hMemDC,hBitmap_sub4_right_mask
			    invoke BitBlt,_hDC,0, @subY1, @subX2, @subY2,_hMemDC,@subX1,0,SRCAND
			    invoke SelectObject,_hMemDC,hBitmap_sub4_right
			    invoke BitBlt,_hDC,0, @subY1, @subX2, @subY2,_hMemDC,@subX1,0,SRCPAINT
		    .endif
        .endif
	.endif
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawSub4 endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseSub4 proc uses eax ecx edx esi, _total, dwSub4UpperY, dwSub4LowerY
;-----------------
;����Ǳͧ4
;-----------------
	local @subY, @speed, @direction, @count, @stRect:RECT, @height, @width, @total

    ;����Ǳͧ��
	mov esi, OFFSET dwSub4
	assume esi:PTR SUBMARINE
    mov eax, dwSub4Size
	mov @count, eax
    mov @total, 0
CountLoop:
	.if ([esi].X > 0) || ([esi].Y > 0)
        inc @total
	.endif
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing

    mov eax, _total
    .if @total < eax
	    invoke	GetClientRect,hWinMain,addr @stRect
	    mov	eax,@stRect.bottom
	    sub eax,@stRect.top	
	    mov	@height,eax		;height = �߶�
	    mov	eax,@stRect.right
	    sub	eax,@stRect.left		;width = ���
	    mov	@width,eax
	    ;���ȷ��Ǳͧ4��λ��
	    invoke _iRand, dwSub4UpperY, dwSub4LowerY
	    mov @subY, eax
	    ;���ȷ��Ǳͧ4���ٶ�
	    invoke _iRand, 5, 5
	    mov @speed, eax
	    ;���ȷ��Ǳͧ4�ķ���0��1��
	    invoke _iRand, 0, 1
	    mov @direction, eax
	    ;����Ǳͧ4��������
	    mov esi, OFFSET dwSub4
	    assume esi:PTR SUBMARINE
        mov eax, dwSub4Size
	    mov @count, eax
    SubLoop:
	    mov ecx, [esi].X
	    mov edx, [esi].Y
	    .if (ecx == 0) && (edx == 0)	;�Ƿ��п�Ǳͧ4
		    mov eax, @subY
		    mov [esi].Y, eax
		    mov eax, @speed
		    mov [esi].SPEED, eax
		    mov [esi].CARRYBOMB, 1
		    mov eax, @direction
		    mov [esi].DIRECTION, eax
		    .if (@direction == 0)
			    mov eax, @width
			    mov [esi].X, eax
		    .else
			    mov eax, 0
			    sub eax, dwSubWidth
			    mov [esi].X, eax
		    .endif
		    mov @count, 1
	    .endif
	    add esi, TYPE SUBMARINE
	    sub @count, 1
	    .if @count > 0
		    jmp SubLoop
	    .endif

	    assume esi: nothing
    .endif
	ret
_ReleaseSub4 endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MoveSub4 proc uses ecx esi ebx eax edx,
;-----------------
;Ǳͧ4�ƶ�
;-----------------
	local @count,@stRect:RECT,@width:SDWORD,@left:SDWORD
	invoke	GetClientRect,hWinMain,addr @stRect
	mov	ecx,@stRect.right
	sub	ecx,@stRect.left
	mov @width,ecx		;width = ���
	mov esi, OFFSET dwSub4	;esi = dwSub4
	assume esi : PTR SUBMARINE
    mov eax, dwSub4Size
	mov @count, eax
CountLoop:
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)	;Ǳͧ4�Ƿ񱻴���
		.if [esi].DIRECTION == 0
			sub eax, [esi].SPEED
			mov [esi].X, eax
			.if eax < @left				;�Ѿ�ͨ�����
				mov [esi].X, 0
				mov [esi].Y, 0
			.elseif (dwShipDead == 0) && (dwShipGameover == 0)
                .if [esi].CARRYBOMB == 0
				    invoke _ReleaseMissile, [esi].X, [esi].Y, [esi].DIRECTION
                .endif
				inc [esi].CARRYBOMB
                mov eax, dwSub4MissileTime
                .if [esi].CARRYBOMB == eax
                    mov [esi].CARRYBOMB, 0
                .endif
			.endif
		.elseif [esi].DIRECTION == 1
			add eax, [esi].SPEED
			mov [esi].X, eax
			.if eax > @width				;�Ѿ�ͨ���Ҷ�
				mov [esi].X, 0
				mov [esi].Y, 0
			.elseif (dwShipDead == 0) && (dwShipGameover == 0)
                .if [esi].CARRYBOMB == 0
				    invoke _ReleaseMissile, [esi].X, [esi].Y, [esi].DIRECTION
                .endif
				inc [esi].CARRYBOMB
                mov eax, dwSub4MissileTime
                .if [esi].CARRYBOMB == eax
                    mov [esi].CARRYBOMB, 0
                .endif
			.endif
		.endif
	.endif	
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_MoveSub4 endp
end