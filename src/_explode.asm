.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
include explode.inc
include battleship.inc
include sub1.inc
include sub2.inc
include sub3.inc
include sub4.inc
include bomb.inc
include score.inc
include init.inc
include sound.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
dwExplode EXPLODE 30 dup(<0, 0, 0>)
dwExplodeSize dd 30
dwExplodeWidth	 dd 66
dwExplodeHeight dd 66
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
_CreateBmp_Explode proc
	invoke LoadBitmap, hInstance,IDB_BOOM1   	;爆炸效果
	mov hBitmap_boom1, eax
	invoke LoadBitmap, hInstance,IDB_BOOM1_MASK
	mov hBitmap_boom1_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM2
	mov hBitmap_boom2, eax
	invoke LoadBitmap, hInstance,IDB_BOOM2_MASK
	mov hBitmap_boom2_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM3
	mov hBitmap_boom3, eax
	invoke LoadBitmap, hInstance,IDB_BOOM3_MASK
	mov hBitmap_boom3_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM4
	mov hBitmap_boom4, eax
	invoke LoadBitmap, hInstance,IDB_BOOM4_MASK
	mov hBitmap_boom4_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM5
	mov hBitmap_boom5, eax
	invoke LoadBitmap, hInstance,IDB_BOOM5_MASK
	mov hBitmap_boom5_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM6
	mov hBitmap_boom6, eax
	invoke LoadBitmap, hInstance,IDB_BOOM6_MASK
	mov hBitmap_boom6_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM7
	mov hBitmap_boom7, eax
	invoke LoadBitmap, hInstance,IDB_BOOM7_MASK
	mov hBitmap_boom7_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM8
	mov hBitmap_boom8, eax
	invoke LoadBitmap, hInstance,IDB_BOOM8_MASK
	mov hBitmap_boom8_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM9
	mov hBitmap_boom9, eax
	invoke LoadBitmap, hInstance,IDB_BOOM9_MASK
	mov hBitmap_boom9_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM10
	mov hBitmap_boom10, eax
	invoke LoadBitmap, hInstance,IDB_BOOM10_MASK
	mov hBitmap_boom10_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM11
	mov hBitmap_boom11, eax
	invoke LoadBitmap, hInstance,IDB_BOOM11_MASK
	mov hBitmap_boom11_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM12
	mov hBitmap_boom12, eax
	invoke LoadBitmap, hInstance,IDB_BOOM12_MASK
	mov hBitmap_boom12_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM13
	mov hBitmap_boom13, eax
	invoke LoadBitmap, hInstance,IDB_BOOM13_MASK
	mov hBitmap_boom13_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM14
	mov hBitmap_boom14, eax
	invoke LoadBitmap, hInstance,IDB_BOOM14_MASK
	mov hBitmap_boom14_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM15
	mov hBitmap_boom15, eax
	invoke LoadBitmap, hInstance,IDB_BOOM15_MASK
	mov hBitmap_boom15_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM16
	mov hBitmap_boom16, eax
	invoke LoadBitmap, hInstance,IDB_BOOM16_MASK
	mov hBitmap_boom16_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM17
	mov hBitmap_boom17, eax
	invoke LoadBitmap, hInstance,IDB_BOOM17_MASK
	mov hBitmap_boom17_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM18
	mov hBitmap_boom18, eax
	invoke LoadBitmap, hInstance,IDB_BOOM18_MASK
	mov hBitmap_boom18_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM19
	mov hBitmap_boom19, eax
	invoke LoadBitmap, hInstance,IDB_BOOM19_MASK
	mov hBitmap_boom19_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM20
	mov hBitmap_boom20, eax
	invoke LoadBitmap, hInstance,IDB_BOOM20_MASK
	mov hBitmap_boom20_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM21
	mov hBitmap_boom21, eax
	invoke LoadBitmap, hInstance,IDB_BOOM21_MASK
	mov hBitmap_boom21_mask, eax
	invoke LoadBitmap, hInstance,IDB_BOOM22
	mov hBitmap_boom22, eax
	invoke LoadBitmap, hInstance,IDB_BOOM22_MASK
	mov hBitmap_boom22_mask, eax
	ret
_CreateBmp_Explode endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DestoryBmp_Explode proc
	invoke DeleteObject, hBitmap_boom1
	invoke DeleteObject, hBitmap_boom1_mask
	invoke DeleteObject, hBitmap_boom2
	invoke DeleteObject, hBitmap_boom2_mask
	invoke DeleteObject, hBitmap_boom3
	invoke DeleteObject, hBitmap_boom3_mask
	invoke DeleteObject, hBitmap_boom4
	invoke DeleteObject, hBitmap_boom4_mask
	invoke DeleteObject, hBitmap_boom5
	invoke DeleteObject, hBitmap_boom5_mask
	invoke DeleteObject, hBitmap_boom6
	invoke DeleteObject, hBitmap_boom6_mask
	invoke DeleteObject, hBitmap_boom7
	invoke DeleteObject, hBitmap_boom7_mask
	invoke DeleteObject, hBitmap_boom8
	invoke DeleteObject, hBitmap_boom8_mask
	invoke DeleteObject, hBitmap_boom9
	invoke DeleteObject, hBitmap_boom9_mask
	invoke DeleteObject, hBitmap_boom10
	invoke DeleteObject, hBitmap_boom10_mask
	invoke DeleteObject, hBitmap_boom11
	invoke DeleteObject, hBitmap_boom11_mask
	invoke DeleteObject, hBitmap_boom12
	invoke DeleteObject, hBitmap_boom12_mask
	invoke DeleteObject, hBitmap_boom13
	invoke DeleteObject, hBitmap_boom13_mask
	invoke DeleteObject, hBitmap_boom14
	invoke DeleteObject, hBitmap_boom14_mask
	invoke DeleteObject, hBitmap_boom15
	invoke DeleteObject, hBitmap_boom15_mask
	invoke DeleteObject, hBitmap_boom16
	invoke DeleteObject, hBitmap_boom16_mask
	invoke DeleteObject, hBitmap_boom17
	invoke DeleteObject, hBitmap_boom17_mask
	invoke DeleteObject, hBitmap_boom18
	invoke DeleteObject, hBitmap_boom18_mask
	invoke DeleteObject, hBitmap_boom19
	invoke DeleteObject, hBitmap_boom19_mask
	invoke DeleteObject, hBitmap_boom20
	invoke DeleteObject, hBitmap_boom20_mask
	invoke DeleteObject, hBitmap_boom21
	invoke DeleteObject, hBitmap_boom21_mask
	invoke DeleteObject, hBitmap_boom22
	invoke DeleteObject, hBitmap_boom22_mask
	ret
_DestoryBmp_Explode endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_DrawBoom proc uses esi ecx eax ebx, _hDC, _hMemDC
;-----------------
; 绘画爆炸效果
;-----------------
	local  @boomX1:SDWORD, @boomY1:DWORD, @boomX2:SDWORD, @boomY2:DWORD, @count:DWORD
	mov esi, OFFSET dwExplode
	assume esi : PTR EXPLODE
	mov eax, dwExplodeSize
	mov @count, eax
CountLoop:	
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)
		mov @boomX1, eax
		mov @boomY1, ebx
		add eax, dwExplodeWidth
		add ebx, dwExplodeHeight
		mov @boomX2, eax
		mov @boomY2, ebx
		.if [esi].X >= 0
			.if [esi].PIC == 1
				invoke SelectObject,_hMemDC,hBitmap_boom1_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom1
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 2
				invoke SelectObject,_hMemDC,hBitmap_boom2_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom2
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 3
				invoke SelectObject,_hMemDC,hBitmap_boom3_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom3
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 4
				invoke SelectObject,_hMemDC,hBitmap_boom4_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom4
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 5
				invoke SelectObject,_hMemDC,hBitmap_boom5_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom5
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 6
				invoke SelectObject,_hMemDC,hBitmap_boom6_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom6
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 7
				invoke SelectObject,_hMemDC,hBitmap_boom7_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom7
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 8
				invoke SelectObject,_hMemDC,hBitmap_boom8_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom8
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 9
				invoke SelectObject,_hMemDC,hBitmap_boom9_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom9
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 10
				invoke SelectObject,_hMemDC,hBitmap_boom10_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom10
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 11
				invoke SelectObject,_hMemDC,hBitmap_boom11_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom11
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 12
				invoke SelectObject,_hMemDC,hBitmap_boom12_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom12
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 13
				invoke SelectObject,_hMemDC,hBitmap_boom13_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom13
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 14
				invoke SelectObject,_hMemDC,hBitmap_boom14_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom14
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 15
				invoke SelectObject,_hMemDC,hBitmap_boom15_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom15
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 16
				invoke SelectObject,_hMemDC,hBitmap_boom16_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom16
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 17
				invoke SelectObject,_hMemDC,hBitmap_boom17_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom17
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 18
				invoke SelectObject,_hMemDC,hBitmap_boom18_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom18
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 19
				invoke SelectObject,_hMemDC,hBitmap_boom19_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom19
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 20
				invoke SelectObject,_hMemDC,hBitmap_boom20_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom20
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 21
				invoke SelectObject,_hMemDC,hBitmap_boom21_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom21
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.elseif [esi].PIC == 22
				invoke SelectObject,_hMemDC,hBitmap_boom22_mask	  
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom22
				invoke BitBlt,_hDC,@boomX1, @boomY1, @boomX2, @boomY2,_hMemDC,0,0,SRCPAINT
			.endif
		.elseif [esi].X < 0
			dec @boomX1
			not @boomX1
			.if [esi].PIC == 1
				invoke SelectObject,_hMemDC,hBitmap_boom1_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom1
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 2
				invoke SelectObject,_hMemDC,hBitmap_boom2_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom2
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 3
				invoke SelectObject,_hMemDC,hBitmap_boom3_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom3
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 4
				invoke SelectObject,_hMemDC,hBitmap_boom4_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom4
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 5
				invoke SelectObject,_hMemDC,hBitmap_boom5_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom5
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 6
				invoke SelectObject,_hMemDC,hBitmap_boom6_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom6
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 7
				invoke SelectObject,_hMemDC,hBitmap_boom7_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom7
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 8
				invoke SelectObject,_hMemDC,hBitmap_boom8_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom8
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 9
				invoke SelectObject,_hMemDC,hBitmap_boom9_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom9
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 10
				invoke SelectObject,_hMemDC,hBitmap_boom10_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom10
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 11
				invoke SelectObject,_hMemDC,hBitmap_boom11_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom11
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 12
				invoke SelectObject,_hMemDC,hBitmap_boom12_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom12
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 13
				invoke SelectObject,_hMemDC,hBitmap_boom13_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom13
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 14
				invoke SelectObject,_hMemDC,hBitmap_boom14_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom14
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 15
				invoke SelectObject,_hMemDC,hBitmap_boom15_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom15
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 16
				invoke SelectObject,_hMemDC,hBitmap_boom16_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom16
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 17
				invoke SelectObject,_hMemDC,hBitmap_boom17_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom17
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 18
				invoke SelectObject,_hMemDC,hBitmap_boom18_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom18
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 19
				invoke SelectObject,_hMemDC,hBitmap_boom19_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom19
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 20
				invoke SelectObject,_hMemDC,hBitmap_boom20_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom20
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 21
				invoke SelectObject,_hMemDC,hBitmap_boom21_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom21
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.elseif [esi].PIC == 22
				invoke SelectObject,_hMemDC,hBitmap_boom22_mask	  
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCAND
				invoke SelectObject,_hMemDC,hBitmap_boom22
				invoke BitBlt,_hDC,0, @boomY1, @boomX2, @boomY2,_hMemDC,@boomX1,0,SRCPAINT
			.endif
		.endif
	.endif
	add esi, TYPE EXPLODE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_DrawBoom endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ChangeBoomPic proc uses ecx esi ebx eax,
;-----------------
;切换爆炸效果图片
;-----------------
	local @count
	mov esi, OFFSET dwExplode	;esi = dwExplode
	assume esi : PTR EXPLODE
	mov eax, dwExplodeSize
	mov @count, eax
CountLoop:
	mov eax, [esi].X
	mov ebx, [esi].Y
	.if (eax > 0) || (ebx > 0)	;爆炸效果是否存在
		inc [esi].PIC
		.if [esi].PIC == 23
			mov [esi].PIC, 0
			mov [esi].X, 0
			mov [esi].Y, 0
		.endif
	.endif	
	add esi, TYPE EXPLODE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_ChangeBoomPic endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ReleaseBoom proc uses eax ebx esi, _SubX:SDWORD, _SubY:DWORD
;-----------------
;释放爆炸效果
;-----------------
	local @countBoom
	mov esi, OFFSET dwExplode	;esi = dwExplode
	assume esi : PTR EXPLODE
	mov eax, dwExplodeSize
	mov @countBoom, eax
CountLoop:
	.if ([esi].X == 0) && ([esi].Y == 0)
		mov eax, _SubX
		mov [esi].X, eax
		mov ebx, dwExplodeHeight
		sub ebx, dwSubHeight
		shr ebx, 1
		mov eax, _SubY
		sub eax, ebx
		mov [esi].Y, eax
		mov [esi].PIC, 1
		mov @countBoom, 1
	.endif
	add esi, TYPE EXPLODE
	sub @countBoom, 1
	.if @countBoom > 0
		jmp CountLoop
	.endif
	assume esi: nothing
	ret
_ReleaseBoom endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_BoomSub proc uses ecx esi ebx eax edx edi,
;-----------------
;爆炸效果是否炸到潜艇
;-----------------
	local @countBoom0,@countSub

	mov eax, dwExplodeSize
	mov @countBoom0, eax
	mov esi, OFFSET dwExplode	;esi = dwExplode
	assume esi : PTR EXPLODE
Boom0Loop:
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
			add ecx, dwExplodeWidth
			mov edx, dwSubHeight
			add edx, dwExplodeHeight
			sub ecx, 11 ;为了让连炸效果更逼真
			sub edx, 6
			.if (eax > 11) && (eax < ecx) && (ebx > 6) && (ebx < edx)
				;invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y				
				mov ecx, dwScore
				add ecx, dwScoreSub1
				mov dwScore, ecx
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
			add ecx, dwExplodeWidth
			mov edx, dwSubHeight
			add edx, dwExplodeHeight
			sub ecx, 11 ;为了让连炸效果更逼真
			sub edx, 6
			.if (eax > 11) && (eax < ecx) && (ebx > 6) && (ebx < edx)
				;invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y
				
				mov ecx, dwScore
				add ecx, dwScoreSub2
				mov dwScore, ecx
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
			add ecx, dwExplodeWidth
			mov edx, dwSubHeight
			add edx, dwExplodeHeight
			sub ecx, 11 ;为了让连炸效果更逼真
			sub edx, 6
			.if (eax > 11) && (eax < ecx) && (ebx > 6) && (ebx < edx)
				;invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y				
				mov ecx, dwScore
				add ecx, dwScoreSub3
				mov dwScore, ecx
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
			add ecx, dwExplodeWidth
			mov edx, dwSubHeight
			add edx, dwExplodeHeight
			sub ecx, 11 ;为了让连炸效果更逼真
			sub edx, 6
			.if (eax > 11) && (eax < ecx) && (ebx > 6) && (ebx < edx)
				;invoke _Music_explode
				invoke _ReleaseBoom, [edi].X, [edi].Y				
				mov ecx, dwScore
				add ecx, dwScoreSub4
				mov dwScore, ecx
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

	add esi, TYPE EXPLODE
	sub @countBoom0, 1
	.if @countBoom0 > 0
		jmp Boom0Loop
	.endif 
	assume esi: nothing

	ret
_BoomSub endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_BoomShip proc uses ecx esi ebx eax edx,
;-----------------
;爆炸效果是否炸到战舰
;-----------------
	local @countBoom0

	mov eax, dwExplodeSize
	mov @countBoom0, eax
	mov esi, OFFSET dwExplode	;esi = dwExplode
	assume esi : PTR EXPLODE
Boom0Loop:
	.if (dwShipDead == 0) && (([esi].X > 0) || ([esi].Y > 0))
		mov eax, dwShipX
		add eax, dwShipWidth
		sub eax, [esi].X
		mov ebx, dwShipY
		add ebx, dwShipHeight
		sub ebx, [esi].Y
		mov ecx, dwShipWidth
		add ecx, dwExplodeWidth
		mov edx, dwShipHeight
		add edx, dwExplodeHeight
		sub ecx, 16 ;为了让连炸效果更逼真
		sub edx, 11
		.if (eax > 16) && (eax < ecx) && (ebx > 11) && (ebx < edx)
            mov dwShipDead, 1
            dec dwLife
            .if dwLife == 0
                mov dwShipGameover, 1
            .endif
            invoke _initTorpedo
            invoke _initMissile
            invoke _initBomb
            mov @countBoom0, 1
		.endif
	.endif

	add esi, TYPE EXPLODE
	sub @countBoom0, 1
	.if @countBoom0 > 0
		jmp Boom0Loop
	.endif 
	assume esi: nothing

	ret
_BoomShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end