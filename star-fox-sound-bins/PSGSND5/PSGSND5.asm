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

	%SMPL_PTR(SMPL_00, $1827)				; 00
	%SMPL_PTR(SMPL_01, $243F)				; 01
	%SMPL_PTR(SMPL_01, $243F)				; 02
	%SMPL_PTR(SMPL_02, $001B)				; 03
	%SMPL_PTR(SMPL_02, $001B)				; 04
	%SMPL_PTR(SMPL_02, $001B)				; 05
	%SMPL_PTR(SMPL_03, $0D92)				; 06
	%SMPL_PTR(SMPL_03, $0D92)				; 07
	%SMPL_PTR(SMPL_04, $001B)				; 08
	%SMPL_PTR(SMPL_05, $2BF2)				; 09
	%NULL_PTR()								; 0A NULL
	%NULL_PTR()								; 0B NULL

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

SMPL_DATA_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $3D00
dw INST_PRMS_00_end-INST_PRMS_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


INST_PRMS_00_start:
;	VxSRCN, VxADSR1, VxADSR2, VxGAIN, pitch mult base, pitch mult fractional (256ths)
	db $00, $FF, $E0, $B8, $07, $A0	; $00
	db $01, $FD, $E0, $B8, $07, $A0	; $01
	db $02, $FF, $E0, $B8, $07, $A0	; $02
	db $03, $FD, $E0, $B8, $00, $F0	; $03
	db $04, $F6, $E0, $B8, $00, $F0	; $04
	db $05, $FF, $E0, $B8, $00, $F0	; $05
	db $06, $F6, $E0, $B8, $02, $00	; $06
	db $07, $FF, $E0, $B8, $02, $00	; $07
	db $08, $FF, $E0, $B8, $03, $C0	; $08
	db $09, $FF, $E0, $B8, $07, $A0	; $09

INST_PRMS_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $FDDE
dw SONG_TABL_00_end-SONG_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_00_start:

	dw SONG_00								; 
	dw EXT_SONG_FCCE								; 

SONG_TABL_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $F7AB
dw SONG_DATA_00_end-SONG_DATA_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_DATA_00_start:

	%INC_SONG(SONG_00)						; Include SONG_00.bin

SONG_DATA_00_end:
; ===========================================





; ============================
; end of data, start execution
; ============================
dw $0000
dw $0400									; start execution here