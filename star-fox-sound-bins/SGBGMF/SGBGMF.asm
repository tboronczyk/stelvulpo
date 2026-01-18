; Asar 1.91
norom

incsrc ../LABELS.def	; External Labels File
incsrc ../MACROS.inc	; Macros File

org $0000

; ===========================================
!BASE_ADDR = $FDC0
dw SONG_TABL_00_end-SONG_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_00_start:

	dw EXT_SONG_F4B5								; 
	dw SONG_03								; 
	dw SONG_00								; 
	dw SONG_00								; 

SONG_TABL_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $FDCC
dw SONG_TABL_01_end-SONG_TABL_01_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_01_start:

	dw EXT_SONG_F8D3								; 
	dw SONG_02								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw EXT_SONG_F77F								; 
	dw $0000								; NULL
	dw EXT_SONG_F829								; 
	dw SONG_01								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw EXT_SONG_FCF0								; 

SONG_TABL_01_end:
; ===========================================



; ===========================================
!BASE_ADDR = $E000
dw SONG_DATA_00_end-SONG_DATA_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_DATA_00_start:

	%INC_SONG(SONG_00)						; Include SONG_00.bin
	%INC_SONG(SONG_01)						; Include SONG_01.bin
	%INC_SONG(SONG_02)						; Include SONG_02.bin
	%INC_SONG(SONG_03)						; Include SONG_03.bin

SONG_DATA_00_end:
; ===========================================





; ============================
; end of data, start execution
; ============================
dw $0000
dw $0400									; start execution here