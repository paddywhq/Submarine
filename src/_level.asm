.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include level.inc
include sub1.inc
include sub2.inc
include sub3.inc
include sub4.inc
include score.inc
include rand.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
.code
_SetLevel proc
	;-------------------------
	;¹Ø¿¨
	;--------------------------
	.if	dwLevel == 1
		invoke _ReleaseSub1, 10, 160, 360
        .if dwScore >= 100
            inc dwLevel
        .endif
    .elseif dwLevel == 2
    	invoke _iRand, 1, 3
		.if eax == 1 || eax == 3
			invoke _ReleaseSub1, 10, 110, 130
		.elseif eax == 2
			invoke _ReleaseSub1, 5, 130, 210
		.endif
        .if dwScore >= 300
            inc dwLevel
        .endif
    .elseif dwLevel == 3
    	invoke _iRand, 1, 3
		.if eax == 2
			invoke _ReleaseSub1, 5, 160, 260
		.elseif eax == 1 || eax == 3
			invoke _ReleaseSub2, 5, 260, 360
		.endif
        .if dwScore >= 550
            inc dwLevel
            inc dwLife
        .endif
    .elseif dwLevel == 4
    	invoke _iRand, 1, 3
		.if eax == 2
			invoke _ReleaseSub1, 5, 160, 260
		.elseif eax == 1 || eax == 3
			invoke _ReleaseSub3, 5, 260, 410
		.endif
        .if dwScore >= 800
            inc dwLevel
        .endif
    .elseif dwLevel == 5
		invoke _ReleaseSub3, 10, 260, 410
        .if dwScore >= 1250
            inc dwLevel
            inc dwLife
        .endif
    .elseif dwLevel == 6
    	invoke _iRand, 1, 3
		.if eax == 2
			invoke _ReleaseSub2, 5, 160, 260
		.elseif eax == 1 || eax == 3
			invoke _ReleaseSub3, 5, 260, 360
		.endif
        .if dwScore >= 1800
            inc dwLevel
        .endif
    .elseif dwLevel == 7
    	invoke _iRand, 1, 3
		.if eax == 1
			invoke _ReleaseSub1, 3, 160, 260
		.elseif eax == 2
			invoke _ReleaseSub2, 3, 260, 360
		.elseif eax == 3
			invoke _ReleaseSub3, 3, 260, 360
		.endif
        .if dwScore >= 2400
            inc dwLevel
            inc dwLife
        .endif
    .elseif dwLevel == 8
    	invoke _iRand, 1, 3
		.if eax == 1
			invoke _ReleaseSub1, 4, 110, 210
		.elseif eax == 2
			invoke _ReleaseSub2, 4, 210, 310
		.elseif eax == 3
			invoke _ReleaseSub3, 4, 310, 410
		.endif
        .if dwScore >= 3100
            inc dwLevel
        .endif
    .elseif dwLevel == 9
    	invoke _iRand, 1, 5
		.if eax == 1
			invoke _ReleaseSub1, 3, 110, 210
		.elseif eax == 2
			invoke _ReleaseSub2, 2, 210, 310
		.elseif eax == 3
			invoke _ReleaseSub3, 2, 310, 410
		.elseif eax == 4 || eax == 5
			invoke _ReleaseSub4, 1, 400, 400
		.endif
        .if dwScore >= 4000
            mov dwLevel, 0
            mov dwLife, 9
        .endif
    .elseif dwLevel == 0
    	invoke _iRand, 1, 5
		.if eax == 1
			invoke _ReleaseSub1, 5, 110, 210
		.elseif eax == 2
			invoke _ReleaseSub2, 5, 210, 310
		.elseif eax == 3
			invoke _ReleaseSub3, 5, 310, 410
		.elseif eax == 4 || eax == 5
			invoke _ReleaseSub4, 1, 400, 400
		.endif
    .endif
    ret
_SetLevel endp
end