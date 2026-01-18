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

	%SMPL_PTR(SMPL_00, $1C8C)				; 00
	%SMPL_PTR(SMPL_01, $0129)				; 01
	%SMPL_PTR(SMPL_01, $0129)				; 02
	%SMPL_PTR(SMPL_02, $069C)				; 03
	%SMPL_PTR(SMPL_02, $069C)				; 04
	%SMPL_PTR(SMPL_03, $0048)				; 05
	%SMPL_PTR(SMPL_04, $0201)				; 06
	%SMPL_PTR(SMPL_04, $0201)				; 07
	%SMPL_PTR(SMPL_05, $06A5)				; 08
	%SMPL_PTR(SMPL_05, $06A5)				; 09
	%SMPL_PTR(SMPL_06, $020A)				; 0A
	%SMPL_PTR(SMPL_06, $020A)				; 0B
	%SMPL_PTR(SMPL_07, $06A5)				; 0C
	%SMPL_PTR(SMPL_07, $06A5)				; 0D
	%SMPL_PTR(SMPL_07, $06A5)				; 0E
	%SMPL_PTR(SMPL_07, $06A5)				; 0F

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

SMPL_DATA_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $3D00
dw INST_PRMS_00_end-INST_PRMS_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


INST_PRMS_00_start:
;	VxSRCN, VxADSR1, VxADSR2, VxGAIN, pitch mult base, pitch mult fractional (256ths)
	db $00, $FF, $E0, $B8, $07, $A0	; $00
	db $01, $FD, $E0, $B8, $03, $00	; $01
	db $02, $FF, $E0, $B8, $03, $00	; $02
	db $03, $FD, $E0, $B8, $03, $C0	; $03
	db $04, $FF, $E0, $B8, $03, $C0	; $04
	db $05, $FF, $EF, $B8, $01, $00	; $05
	db $06, $FF, $F6, $B8, $03, $10	; $06
	db $07, $FF, $F2, $B8, $03, $10	; $07
	db $08, $FD, $E0, $B8, $03, $D0	; $08
	db $09, $FF, $E0, $B8, $03, $D0	; $09
	db $0A, $FD, $E0, $B8, $03, $00	; $0A
	db $0B, $FF, $E0, $B8, $03, $00	; $0B
	db $0C, $FD, $E0, $B8, $03, $00	; $0C
	db $0D, $FD, $E0, $B8, $03, $00	; $0D
	db $0E, $FF, $F0, $B8, $03, $00	; $0E
	db $0F, $FF, $E0, $B8, $03, $00	; $0F
	db $10, $FD, $E0, $B8, $02, $00	; $10
	db $11, $FD, $E0, $B8, $02, $00	; $11
	db $12, $FD, $E0, $B8, $02, $00	; $12
	db $13, $FD, $E0, $B8, $02, $00	; $13
	db $14, $DF, $34, $B8, $02, $00	; $14
	db $15, $F6, $F1, $B8, $02, $00	; $15
	db $16, $FF, $EE, $B8, $02, $00	; $16
	db $17, $FD, $E0, $B8, $03, $00	; $17
	db $18, $FF, $E0, $B8, $03, $00	; $18
	db $19, $FF, $E0, $B8, $03, $00	; $19
	db $1A, $FF, $E0, $B8, $04, $90	; $1A
	db $1B, $FF, $E0, $B8, $07, $A0	; $1B
	db $1C, $FF, $ED, $B8, $03, $00	; $1C
	db $1D, $FF, $F0, $B8, $03, $00	; $1D
	db $1E, $FF, $F6, $B8, $03, $00	; $1E
	db $1F, $FF, $E0, $B8, $03, $00	; $1F
	db $20, $FE, $E0, $B8, $03, $C0	; $20
	db $21, $FF, $ED, $B8, $03, $C0	; $21
	db $22, $FF, $F3, $B8, $03, $C0	; $22
	db $23, $FF, $F6, $B8, $03, $C0	; $23
	db $24, $FF, $E0, $B8, $03, $C0	; $24
	db $25, $FF, $E0, $B8, $03, $C0	; $25

INST_PRMS_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $FDC0
dw SONG_TABL_00_end-SONG_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_00_start:

	dw SONG_01								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL

SONG_TABL_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $FDCC
dw SONG_TABL_01_end-SONG_TABL_01_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_01_start:

	dw SONG_04								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw SONG_02								; 
	dw $0000								; NULL
	dw SONG_03								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw SONG_05								; 
	dw SONG_00								; 
	dw SONG_00								; 

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
	%INC_SONG(SONG_04)						; Include SONG_04.bin
	%INC_SONG(SONG_05)						; Include SONG_05.bin

SONG_DATA_00_end:
; ===========================================





; ============================
; end of data, start execution
; ============================
dw $0000
dw $0400									; start execution here