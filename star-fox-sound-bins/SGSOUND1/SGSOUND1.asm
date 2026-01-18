; Asar 1.91
norom

incsrc ../LABELS.def	; External Labels File
incsrc ../MACROS.inc	; Macros File

org $0000
; ===========================================
!BASE_ADDR = $3C00
dw SMPL_TABL_00_end-SMPL_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SMPL_TABL_00_start:

	%SMPL_PTR(SMPL_00, $001B)				; 00
	%SMPL_PTR(SMPL_01, $010E)				; 01
	%SMPL_PTR(SMPL_02, $0024)				; 02
	%SMPL_PTR(SMPL_03, $0024)				; 03
	%SMPL_PTR(SMPL_04, $0561)				; 04 laser blast
	%SMPL_PTR(SMPL_05, $05C4)				; 05 bomb
	%SMPL_PTR(SMPL_06, $0BA3)				; 06 player's laser
	%SMPL_PTR(SMPL_07, $0D92)				; 07 crash
	%SMPL_PTR(SMPL_08, $05C4)				; 08
	%SMPL_PTR(SMPL_09, $001B)				; 09
	%SMPL_PTR(SMPL_10, $002D)				; 0A
	%SMPL_PTR(SMPL_11, $001B)				; 0B
	%SMPL_PTR(SMPL_12, $0816)				; 0C "incoming enemy"
	%SMPL_PTR(SMPL_13, $0213)				; 0D "wing"
	%SMPL_PTR(SMPL_14, $07B3)				; 0E "damage"
	%SMPL_PTR(SMPL_15, $0870)				; 0F "twin blasters"
	%SMPL_PTR(SMPL_16, $039F)				; 10 "shield"
	%SMPL_PTR(SMPL_17, $0024)				; 11 Andross laugh
	%SMPL_PTR(SMPL_18, $05A9)				; 12
	%SMPL_PTR(SMPL_19, $001B)				; 13
	%SMPL_PTR(SMPL_20, $0360)				; 14 Crystal
	%SMPL_PTR(SMPL_20, $0360)				; 15 Crystal
	%SMPL_PTR(SMPL_20, $0360)				; 16 Crystal
	%SMPL_PTR(SMPL_21, $01B0)				; 17 comms static

SMPL_TABL_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $4000
dw SMPL_DATA_00_end-SMPL_DATA_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SMPL_DATA_00_start:

	%INC_SMPL(SMPL_00)						; Include SMPL_00.brr
	%INC_SMPL(SMPL_01)						; Include SMPL_01.brr
	%INC_SMPL(SMPL_02)						; Include SMPL_02.brr
	%INC_SMPL(SMPL_03)						; Include SMPL_03.brr
	%INC_SMPL(SMPL_04)						; Include SMPL_04.brr
	%INC_SMPL(SMPL_05)						; Include SMPL_05.brr
	%INC_SMPL(SMPL_06)						; Include SMPL_06.brr
	%INC_SMPL(SMPL_07)						; Include SMPL_07.brr
	%INC_SMPL(SMPL_08)						; Include SMPL_08.brr
	%INC_SMPL(SMPL_09)						; Include SMPL_09.brr
	%INC_SMPL(SMPL_10)						; Include SMPL_10.brr
	%INC_SMPL(SMPL_11)						; Include SMPL_11.brr
	%INC_SMPL(SMPL_12)						; Include SMPL_12.brr
	%INC_SMPL(SMPL_13)						; Include SMPL_13.brr
	%INC_SMPL(SMPL_14)						; Include SMPL_14.brr
	%INC_SMPL(SMPL_15)						; Include SMPL_15.brr
	%INC_SMPL(SMPL_16)						; Include SMPL_16.brr
	%INC_SMPL(SMPL_17)						; Include SMPL_17.brr
	%INC_SMPL(SMPL_18)						; Include SMPL_18.brr
	%INC_SMPL(SMPL_19)						; Include SMPL_19.brr
	%INC_SMPL(SMPL_20)						; Include SMPL_20.brr
	%INC_SMPL(SMPL_21)						; Include SMPL_21.brr

SMPL_DATA_00_end:
; ===========================================





; ============================
; end of data, start execution
; ============================
dw $0000
dw $0400									; start execution here