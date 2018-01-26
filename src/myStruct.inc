include windows.inc
include user32.inc
include kernel32.inc
include gdi32.inc
includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
include msvcrt.inc
includelib msvcrt.lib

BOMB struct
	X dd ? ;左上x坐标
	Y dd ? ;左上y坐标
BOMB ends

TORPEDO struct
	X dd ? ;左上x坐标
	Y dd ? ;左上y坐标
	TIMECOUNT dd ? ;到海面计时
TORPEDO ends

MISSILE struct
	X dd ? ;左上x坐标
	Y SDWORD ? ;左上y坐标
	DIRECTION dd ? ;方向，0中1左2右
MISSILE ends

SUBMARINE struct
	X SDWORD ? ;左上x坐标
	Y dd ? ;左上y坐标
	SPEED dd ? ;速度
	DIRECTION dd ? ;方向，0左1右
	CARRYBOMB dd ? ;是否携带炸弹，0是1否
SUBMARINE ends

EXPLODE struct
	X SDWORD ? ;左上x坐标
	Y dd ? ;左上y坐标
	PIC dd ? ;图片状态，按1~22次序切换
EXPLODE ends