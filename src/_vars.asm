.386
.model flat,stdcall
option casemap:none
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include vars.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.data
hInstance dd ?
hWinMain dd ?

dwWindowHeight	 dd 480
dwWindowWidth dd 640
dwWindowX	 dd 100
dwWindowY	 dd 100

dwSkyHeight   dd 110
dwSubWidth	 dd 63
dwSubHeight  dd 19
;>>>>>>>>hBitmap>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
hIcon dd ?
hBitmap_ship dd ?
hBitmap_background dd ?  
hBitmap_background_gameover dd ?
hBitmap_background_pause dd ?
hBitmap_background_die dd ?
hBitmap_ship_mask dd ? 
hBitmap_bomb_middle dd ? 
hBitmap_bomb_middle_mask dd ? 
hBitmap_bomb_left dd ? 
hBitmap_bomb_left_mask dd ? 
hBitmap_bomb_right dd ? 
hBitmap_bomb_right_mask dd ? 
hBitmap_sub1_left dd ? 
hBitmap_sub1_left_mask dd ? 
hBitmap_sub1_right dd ? 
hBitmap_sub1_right_mask dd ? 
hBitmap_sub2_left dd ? 
hBitmap_sub2_left_mask dd ? 
hBitmap_sub2_right dd ? 
hBitmap_sub2_right_mask dd ? 
hBitmap_sub3_left dd ? 
hBitmap_sub3_left_mask dd ? 
hBitmap_sub3_right dd ? 
hBitmap_sub3_right_mask dd ? 
hBitmap_sub4_left dd ? 
hBitmap_sub4_left_mask dd ? 
hBitmap_sub4_right dd ? 
hBitmap_sub4_right_mask dd ? 
hBitmap_torpedo dd ? 
hBitmap_torpedo_mask dd ?
hBitmap_missile_left dd ? 
hBitmap_missile_left_mask dd ? 
hBitmap_missile_right dd ? 
hBitmap_missile_right_mask dd ? 
hBitmap_missile_middle dd ? 
hBitmap_missile_middle_mask dd ? 
hBitmap_boom1 dd ? 
hBitmap_boom1_mask dd ? 
hBitmap_boom2 dd ? 
hBitmap_boom2_mask dd ? 
hBitmap_boom3 dd ? 
hBitmap_boom3_mask dd ? 
hBitmap_boom4 dd ? 
hBitmap_boom4_mask dd ? 
hBitmap_boom5 dd ? 
hBitmap_boom5_mask dd ? 
hBitmap_boom6 dd ? 
hBitmap_boom6_mask dd ? 
hBitmap_boom7 dd ? 
hBitmap_boom7_mask dd ? 
hBitmap_boom8 dd ? 
hBitmap_boom8_mask dd ? 
hBitmap_boom9 dd ? 
hBitmap_boom9_mask dd ? 
hBitmap_boom10 dd ? 
hBitmap_boom10_mask dd ? 
hBitmap_boom11 dd ? 
hBitmap_boom11_mask dd ? 
hBitmap_boom12 dd ? 
hBitmap_boom12_mask dd ? 
hBitmap_boom13 dd ? 
hBitmap_boom13_mask dd ? 
hBitmap_boom14 dd ? 
hBitmap_boom14_mask dd ? 
hBitmap_boom15 dd ? 
hBitmap_boom15_mask dd ? 
hBitmap_boom16 dd ? 
hBitmap_boom16_mask dd ? 
hBitmap_boom17 dd ? 
hBitmap_boom17_mask dd ? 
hBitmap_boom18 dd ? 
hBitmap_boom18_mask dd ? 
hBitmap_boom19 dd ? 
hBitmap_boom19_mask dd ? 
hBitmap_boom20 dd ? 
hBitmap_boom20_mask dd ? 
hBitmap_boom21 dd ? 
hBitmap_boom21_mask dd ? 
hBitmap_boom22 dd ? 
hBitmap_boom22_mask dd ? 

hBitmap_number0 dd ?
hBitmap_number1 dd ?
hBitmap_number2 dd ?
hBitmap_number3 dd ?
hBitmap_number4 dd ?
hBitmap_number5 dd ?
hBitmap_number6 dd ?
hBitmap_number7 dd ?
hBitmap_number8 dd ?
hBitmap_number9 dd ?

hBitmap_life dd ?
hBitmap_life_mask dd ?
hBitmap_point dd ?
hBitmap_point_mask dd ?
hBitmap_level dd ?
hBitmap_level_mask dd ?
end