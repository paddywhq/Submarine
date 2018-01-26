.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.code
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initShip proc uses eax ecx,
	;-------------------------
	;初始化战斗舰位置,屏幕中心
	;--------------------------
	local	@stRect:RECT
	invoke	GetClientRect,hWinMain, addr @stRect
	mov	eax,@stRect.right
	sub	eax,@stRect.left
    sub eax,dwShipWidth
	shr eax,1	;eax = 宽度
	mov	ecx,@stRect.top	
	add	ecx,dwSkyHeight
	sub	ecx,dwShipHeight		;ecx = 高度
	mov dwShipX, eax
	mov dwShipY, ecx
    mov dwShipDead, 0
    mov dwShipPause, 0
	ret
_initShip endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initSub proc uses eax esi,
	;-------------------------
	;初始化潜艇
	;--------------------------
    local @count

	mov esi, OFFSET dwSub1
	assume esi:PTR SUBMARINE
    mov eax, dwSub1Size
	mov @count, eax
Sub1Loop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp Sub1Loop
	.endif
	assume esi: nothing

	mov esi, OFFSET dwSub2
	assume esi:PTR SUBMARINE
    mov eax, dwSub2Size
	mov @count, eax
Sub2Loop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp Sub2Loop
	.endif
	assume esi: nothing

	mov esi, OFFSET dwSub3
	assume esi:PTR SUBMARINE
    mov eax, dwSub3Size
	mov @count, eax
Sub3Loop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp Sub3Loop
	.endif
	assume esi: nothing

	mov esi, OFFSET dwSub4
	assume esi:PTR SUBMARINE
    mov eax, dwSub4Size
	mov @count, eax
Sub4Loop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE SUBMARINE
	sub @count, 1
	.if @count > 0
		jmp Sub4Loop
	.endif
	assume esi: nothing

	ret
_initSub endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initExplode proc uses eax esi,
	;-------------------------
	;初始化爆炸效果
	;--------------------------
    local @count
	mov esi, OFFSET dwExplode
	assume esi:PTR EXPLODE
    mov eax, dwExplodeSize
	mov @count, eax
CountLoop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE EXPLODE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_initExplode endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initBomb proc uses eax esi,
	;-------------------------
	;初始化炮弹
	;--------------------------
    local @count
	mov esi, OFFSET dwBomb
	assume esi:PTR BOMB
    mov eax, dwBombSize
	mov @count, eax
CountLoop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE BOMB
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_initBomb endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initTorpedo proc uses eax esi,
	;-------------------------
	;初始化鱼雷
	;--------------------------
    local @count
	mov esi, OFFSET dwTorpedo
	assume esi:PTR TORPEDO
    mov eax, dwTorpedoSize
	mov @count, eax
CountLoop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE TORPEDO
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_initTorpedo endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initMissile proc uses eax esi,
	;-------------------------
	;初始化导弹
	;--------------------------
    local @count
	mov esi, OFFSET dwMissile
	assume esi:PTR MISSILE
    mov eax, dwMissileSize
	mov @count, eax
CountLoop:
	mov [esi].X, 0
	mov [esi].Y, 0
	add esi, TYPE MISSILE
	sub @count, 1
	.if @count > 0
		jmp CountLoop
	.endif

	assume esi: nothing
	ret
_initMissile endp
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_initScore proc uses eax esi,
	;-------------------------
	;初始化分数
	;-------------------------
    mov dwLevel, 1
    mov dwScore, 0
    mov dwLife, 5
	ret
_initScore endp
end