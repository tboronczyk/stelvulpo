; Asar 1.91
norom

incsrc ../LABELS.def	; External Labels File
incsrc ../MACROS.inc	; Macros File

org $0000

; ===========================================
!BASE_ADDR = $3C70
dw SMPL_TABL_00_end-SMPL_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SMPL_TABL_00_start:

	%SMPL_PTR(SMPL_00, $0F27)				; 1C
	%NULL_PTR()								; 1D NULL
	%NULL_PTR()								; 1E NULL
	%NULL_PTR()								; 1F NULL

SMPL_TABL_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $C720
dw SMPL_DATA_00_end-SMPL_DATA_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SMPL_DATA_00_start:

	%INC_SMPL(SMPL_00)						; Include SMPL_00.brr

SMPL_DATA_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $3D00
dw INST_PRMS_00_end-INST_PRMS_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


INST_PRMS_00_start:
;	VxSRCN, VxADSR1, VxADSR2, VxGAIN, pitch mult base, pitch mult fractional (256ths)
	db $00, $FF, $E0, $B8, $03, $40	; $00
	db $01, $FF, $E0, $B8, $03, $10	; $01
	db $02, $FF, $E0, $B8, $02, $B0	; $02
	db $03, $FF, $E0, $B8, $02, $F0	; $03
	db $04, $FF, $E0, $B8, $06, $40	; $04
	db $05, $FF, $E0, $B8, $06, $B0	; $05
	db $06, $FF, $E0, $B8, $03, $B0	; $06
	db $07, $FF, $E0, $B8, $02, $00	; $07
	db $08, $FF, $E0, $B8, $02, $00	; $08
	db $09, $FF, $E0, $B8, $04, $70	; $09
	db $0A, $FF, $E0, $B8, $00, $80	; $0A
	db $0B, $FF, $E0, $B8, $03, $C0	; $0B
	db $0C, $FF, $E0, $B8, $07, $A0	; $0C
	db $0D, $FF, $E0, $B8, $03, $D0	; $0D
	db $0E, $FF, $E0, $B8, $05, $B0	; $0E
	db $0F, $FF, $E0, $B8, $07, $A0	; $0F
	db $10, $FF, $E0, $B8, $07, $A0	; $10
	db $11, $FF, $EC, $B8, $02, $A0	; $11
	db $12, $FF, $E0, $B8, $07, $A0	; $12
	db $13, $FF, $E0, $B8, $03, $C0	; $13
	db $14, $DF, $34, $B8, $02, $00	; $14
	db $15, $F6, $F1, $B8, $02, $00	; $15
	db $16, $FF, $EE, $B8, $02, $00	; $16
	db $17, $FF, $E0, $B8, $05, $B0	; $17
	db $18, $FF, $E0, $B8, $03, $00	; $18
	db $19, $FF, $E0, $B8, $03, $00	; $19
	db $1A, $FF, $E0, $B8, $01, $B0	; $1A
	db $1B, $FF, $E0, $B8, $03, $90	; $1B
	db $1C, $FF, $F9, $B8, $03, $A0	; $1C
	db $1D, $F4, $F1, $B8, $03, $A0	; $1D
	db $1E, $FF, $E0, $B8, $03, $A0	; $1E
	db $1F, $FF, $F3, $B8, $03, $80	; $1F
	db $20, $FE, $E0, $B8, $03, $A0	; $20
	db $21, $FF, $F0, $B8, $03, $80	; $21
	db $22, $F6, $E0, $B8, $03, $00	; $22
	db $23, $FF, $E0, $B8, $03, $00	; $23
	db $24, $FF, $F8, $B8, $01, $50	; $24
	db $25, $FF, $E0, $B8, $1D, $F0	; $25
	db $26, $FF, $F2, $B8, $06, $F0	; $26
	db $27, $FF, $EF, $B8, $01, $00	; $27
	db $28, $FF, $E0, $B8, $01, $00	; $28
	db $29, $FF, $E0, $B8, $07, $A0	; $29
	db $2A, $FF, $E0, $B8, $03, $00	; $2A
	db $2B, $FF, $E0, $B8, $03, $00	; $2B
	db $2C, $FF, $E0, $B8, $03, $D0	; $2C
	db $2D, $FF, $E0, $B8, $03, $00	; $2D
	db $2E, $FF, $E0, $B8, $03, $00	; $2E

INST_PRMS_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $E000
dw SONG_DATA_00_end-SONG_DATA_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_DATA_00_start:

	%INC_SONG(SONG_00)						; Include SONG_00.bin

SONG_DATA_00_end:
; ===========================================



; ===========================================
!BASE_ADDR = $FDC0
dw SONG_TABL_00_end-SONG_TABL_00_start		; calculate size in bytes
dw !BASE_ADDR								; spc destination


SONG_TABL_00_start:

	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw SONG_00								; 
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL
	dw $0000								; NULL

SONG_TABL_00_end:
; ===========================================





; ============================
; end of data, start execution
; ============================
dw $0000
dw $0400									; start execution here