.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include battleship.inc
include explode.inc
include init.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwShipX		 dd ?
dwShipY		 dd ?
dwShipWidth	 dd 64
dwShipHeight dd 27
dwShipSpeed  dd 6
dwShipDead dd 0
dwShipDeadTime dd 50
dwShipPause dd 0
dwShipGameover dd 0
dwShipKeyDown dd 0
dwShipDirection dd 0
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Ship proc
	invoke LoadBitmap,hInstance,IDB_SHIP		
	mov hBitmap_ship, eax	  	  	  
	invoke LoadBitmap,hInstance, IDB_SHIP_MASK;	
	mov hBitmap_ship_mask,eax
	ret
_CreateBmp_Ship endp

_DestoryBmp_Ship proc
	invoke DeleteObject, hBitmap_ship
	invoke DeleteObject, hBitmap_ship_mask
	ret
_DestoryBmp_Ship endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawShip proc uses eax ebx, _hdc, _hMemDC
	;-------------------------
	;画船
	;-------------------------
	local @dwShipEndX, @dwShipEndY, @boomX1, @boomY1, @boomX2, @boomY2
    .if dwShipDead == 0
	    mov ebx, dwShipX
	    add ebx, dwShipWidth
	    mov @dwShipEndX, ebx
	    mov ebx, dwShipY
	    add ebx, dwShipHeight
	    mov @dwShipEndY, ebx
	    ;上面的图的阴影部分
	    invoke SelectObject,_hMemDC,hBitmap_ship_mask	  
	    invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCAND
	    ;上面的图
	    invoke SelectObject,_hMemDC,hBitmap_ship
	    invoke BitBlt,_hdc,dwShipX,dwShipY,@dwShipEndX,@dwShipEndY,_hMemDC,0,0,SRCPAINT
    .elseif dwShipDead > 0
        mov eax, dwExplodeHeight
        sub eax, dwShipHeight
        shr eax, 1
        mov ebx, dwShipX
        mov @boomX1, ebx
	    add ebx, dwExplodeWidth
	    mov @boomX2, ebx
	    mov ebx, dwShipY
        sub ebx, eax
        mov @boomY1, ebx
	    mov ebx, dwShipY
	    add ebx, dwExplodeHeight
	    mov @boomY2, ebx
		.if dwShipDead == 1
			invoke SelectObject,_hMemDC,hBitmap_boom1_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom1
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 2
			invoke SelectObject,_hMemDC,hBitmap_boom2_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom2
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 3
			invoke SelectObject,_hMemDC,hBitmap_boom3_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom3
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 4
			invoke SelectObject,_hMemDC,hBitmap_boom4_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom4
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 5
			invoke SelectObject,_hMemDC,hBitmap_boom5_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom5
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 6
			invoke SelectObject,_hMemDC,hBitmap_boom6_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom6
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 7
			invoke SelectObject,_hMemDC,hBitmap_boom7_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom7
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 8
			invoke SelectObject,_hMemDC,hBitmap_boom8_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom8
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 9
			invoke SelectObject,_hMemDC,hBitmap_boom9_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom9
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 10
			invoke SelectObject,_hMemDC,hBitmap_boom10_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom10
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 11
			invoke SelectObject,_hMemDC,hBitmap_boom11_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom11
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 12
			invoke SelectObject,_hMemDC,hBitmap_boom12_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom12
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 13
			invoke SelectObject,_hMemDC,hBitmap_boom13_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom13
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 14
			invoke SelectObject,_hMemDC,hBitmap_boom14_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom14
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 15
			invoke SelectObject,_hMemDC,hBitmap_boom15_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom15
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 16
			invoke SelectObject,_hMemDC,hBitmap_boom16_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom16
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 17
			invoke SelectObject,_hMemDC,hBitmap_boom17_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom17
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 18
			invoke SelectObject,_hMemDC,hBitmap_boom18_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom18
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 19
			invoke SelectObject,_hMemDC,hBitmap_boom19_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom19
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 20
			invoke SelectObject,_hMemDC,hBitmap_boom20_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom20
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 21
			invoke SelectObject,_hMemDC,hBitmap_boom21_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom21
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.elseif dwShipDead == 22
			invoke SelectObject,_hMemDC,hBitmap_boom22_mask	  
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
			invoke SelectObject,_hMemDC,hBitmap_boom22
			invoke BitBlt,_hdc,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
		.endif
        .if (dwShipPause == 0) && (dwShipGameover == 0)
            inc dwShipDead
            mov eax, dwShipDeadTime
            .if dwShipDead == eax
                invoke _initShip
            .endif
        .elseif (dwShipPause == 0) && (dwShipDead < 23)
            inc dwShipDead
        .endif
    .endif
	ret
_DrawShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_MoveShip proc uses ebx
	;-------------------------
	;根据按键移动战斗舰
	;-------------------------
	local	@stRect:RECT
    .if (dwShipDead == 0) && (dwShipPause == 0) && (dwShipGameover == 0) && (dwShipKeyDown >= 1)
   	    invoke	GetClientRect,hWinMain,addr @stRect
	    mov	eax,@stRect.right
	    sub	eax,@stRect.left	;eax = 屏幕宽度
	    mov ebx, dwShipX
	    .if dwShipDirection == 0		;left
		    sub ebx, dwShipSpeed
	    .elseif dwShipDirection == 1	;right
		    add ebx, dwShipSpeed
	    .endif	
	    .if ebx > 10					;在屏幕左边界内	
		    sub eax, ebx		
		    sub eax, dwShipWidth
		    .if eax > 10				;在屏幕右边界内
			    mov dwShipX, ebx
		    .endif
	    .endif
    .endif
	ret
_MoveShip endp
end