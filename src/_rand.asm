.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include rand.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
.code
_iRand proc uses ecx edx, first:DWORD, second:DWORD
LOCAL _st:SYSTEMTIME
	;-------------------------
	;生成first到second中的随机整数，eax=(randseed*23+7)mod(second-first+1)+first
	;--------------------------
	invoke  GetSystemTime,ADDR _st
	movzx   eax,SYSTEMTIME.wMilliseconds[_st]
	invoke  crt_srand,eax

	mov     ebx,10
	invoke  crt_rand

	mov ecx, 23
	mul ecx
	add eax, 7
	mov ecx, second
	sub ecx, first
	inc ecx
	xor edx, edx
	div ecx
	add edx, first
	mov eax, edx
	ret
_iRand endp
end