; mario data tables

	incpublics	mdata.ext




winbuf0	equ	0
winbuf1	equ	1

defwindb macro
	db	\1,\2,\3,\4,\5
	endm

deflogb	macro
	db	\1+(\1<<2)+(\1<<4)+(\1<<6)
	endm

mwinbase

mscramwipe
val1	=	96
val2	=	96
	rept	12
	deflogb	%10
	defwindb	0,0,0,val1,winbuf0
	defwindb	223,0,223,val1,winbuf1
	defwindb	0,val1,0,val2,winbuf0
	defwindb	0,val1,0,val2,winbuf1
	defwindb	0,val2,0,191,winbuf0
	defwindb	223,val2,223,191,winbuf1
	db	-1
val1	=	val1-8
val2	=	val2+8
	endr
	dw	-1

mroundwipefill
val1	=	112
	rept	4
	deflogb		%10
	defwindb	111,0,111,95,winbuf0		;0-45
	defwindb	111,0,111,95,winbuf1
	defwindb	111,95,111,191,winbuf0
	defwindb	111,95,val1,191,winbuf1
	db	-1
val1	=	val1-28
	endr
val1	=	191
	rept	4
	deflogb		%10
	defwindb	111,0,111,95,winbuf0		;45-90
	defwindb	111,0,111,95,winbuf1
	defwindb	111,95,111,191,winbuf0
	defwindb	111,95,0,val1,winbuf1
	ifne	val1-191
	defwindb	0,val1,0,191,winbuf1
	endc
	db	-1
val1	=	val1-28
	endr
val1	=	84
	rept	3
	deflogb		%01				;90-135
	defwindb	223,0,223,191,winbuf1
	defwindb	0,0,0,val1,winbuf0
	defwindb	0,val1,112,95,winbuf0
	defwindb	112,95,112,191,winbuf0
	db	-1
val1	=	val1-28
	endr
val1	=	0					;135-225
	rept	8
	deflogb		%01
	defwindb	223,0,223,191,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	val1,0,112,95,winbuf0
	db	-1
val1	=	val1+28
	endr

val1	=	0					;225-270
	rept	3
	deflogb		%01
	defwindb	223,0,223,191,winbuf1
	defwindb	223,0,223,val1,winbuf0
	defwindb	223,val1,112,95,winbuf0
	defwindb	112,95,112,191,winbuf0
	db	-1
val1	=	val1+28
	endr
val1	=	95
	rept	4
	deflogb		%01				;270-315
	defwindb	112,0,112,95,winbuf0
	defwindb	112,0,112,95,winbuf1
	defwindb	112,95,223,val1,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	223,val1,223,191,winbuf1
	db	-1
val1	=	val1+24
	endr
val1	=	223
	rept	4
	deflogb		%01				;315-360
	defwindb	112,0,112,95,winbuf0
	defwindb	112,0,112,95,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	112,95,val1,191,winbuf1
	db	-1
val1	=	val1-28
	ifle	val1-113
val1	=	113
	endc
	endr
	dw	-1



mroundwipeclear
val1	=	112
	rept	4
	deflogb		%01
	defwindb	111,0,111,95,winbuf0
	defwindb	111,0,111,95,winbuf1
	defwindb	111,95,111,191,winbuf0
	defwindb	111,95,val1,191,winbuf1
	db	-1
val1	=	val1-28
	endr
val1	=	191
	rept	4
	deflogb		%01
	defwindb	111,0,111,95,winbuf0
	defwindb	111,0,111,95,winbuf1
	defwindb	111,95,111,191,winbuf0
	defwindb	111,95,0,val1,winbuf1
	ifne	val1-191
	defwindb	0,val1,0,191,winbuf1
	endc
	db	-1
val1	=	val1-28
	endr
val1	=	84
	rept	3
	deflogb		%10
	defwindb	223,0,223,191,winbuf1
	defwindb	0,0,0,val1,winbuf0
	defwindb	0,val1,112,95,winbuf0
	defwindb	112,95,112,191,winbuf0
	db	-1
val1	=	val1-28
	endr
val1	=	0
	rept	8
	deflogb		%10
	defwindb	223,0,223,191,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	val1,0,112,95,winbuf0
	db	-1
val1	=	val1+28
	endr
val1	=	0
	rept	3
	deflogb		%10
	defwindb	223,0,223,191,winbuf1
	defwindb	223,0,223,val1,winbuf0
	defwindb	223,val1,112,95,winbuf0
	defwindb	112,95,112,191,winbuf0
	db	-1
val1	=	val1+28
	endr
val1	=	95
	rept	4
	deflogb		%10
	defwindb	112,0,112,95,winbuf0
	defwindb	112,0,112,95,winbuf1
	defwindb	112,95,223,val1,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	223,val1,223,191,winbuf1
	db	-1
val1	=	val1+24
	endr
val1	=	223
	rept	4
	deflogb		%10
	defwindb	112,0,112,95,winbuf0
	defwindb	112,0,112,95,winbuf1
	defwindb	112,95,112,191,winbuf0
	defwindb	112,95,val1,191,winbuf1
	db	-1
val1	=	val1-28
	ifle	val1-113
val1	=	113
	endc
	endr
	dw	-1


mwipefill
	deflogb	%10
	defwindb	0,0,0,191,winbuf0
	defwindb	223,0,223,191,winbuf1
	db	-1
	deflogb	%10
	defwindb	0,0,0,191,winbuf0
	defwindb	223,0,223,191,winbuf1
	db	-1
	deflogb	%10
	defwindb	0,0,0,191,winbuf0
	defwindb	223,0,223,191,winbuf1
	db	-1
	dw	-1

mstarwipe
kscale	=	32768
kspeed	=	16
kdx	=	(112*kscale)/kspeed
kdy	=	(96*kscale)/kspeed
valx1	=	112*kscale
valy1	=	95*kscale
valx2	=	112*kscale
valy2	=	95*kscale
valx3	=	112*kscale
valy3	=	95*kscale
valx4	=	112*kscale
valy4	=	95*kscale
	rept	kspeed
	deflogb	%01
	defwindb	112,00,valx1/kscale,valy1/kscale,winbuf0
	defwindb	112,00,valx2/kscale,valy2/kscale,winbuf1
	defwindb	000,95,valx1/kscale,valy1/kscale,winbuf0
	defwindb	223,95,valx2/kscale,valy2/kscale,winbuf1
	defwindb	000,95,valx3/kscale,valy3/kscale,winbuf0
	defwindb	223,95,valx4/kscale,valy4/kscale,winbuf1
	defwindb	112,191,valx3/kscale,valy3/kscale,winbuf0
	defwindb	112,191,valx4/kscale,valy4/kscale,winbuf1
	db	-1
valx1	=	valx1-kdx
valy1	=	valy1-kdy
valx2	=	valx2+kdx
valy2	=	valy2-kdy
valx3	=	valx3-kdx
valy3	=	valy3+kdy
valx4	=	valx4+kdx
valy4	=	valy4+kdy
	endr
	dw	-1





maxztab	equ	12*1024

ztab	rept	256/2
	dw	32767
	endr

zv	=	256
	rept	(maxztab+512)/2
	dw	32767*256/zv
zv	=	zv+2
	endr


star_cols
	db	14,14,13,12,11,10,9,9,9,9,9,9,9,9,9,9
	db	14,14,13,12,11,10,9,9,9,9,9,9,9,9,9,9
	db	8,8,8,7,7,7,6,6,6,5,5,5,5,5,5,5
	db	4,4,4,3,3,3,2,2,2,1,1,1,1,1,1,1


snow_cols
	db	14,14,14,14,14,14,14,14,8,8,8,8,8,8,8,8

partfadetab
;	db	14,4,14,4,13,2,12,2,11,1,10,1,10,10,9,9

	db	9,9,9,9,10,10,10,10,1,1,1,11,2,11,2,2
	db	12,13,13,14,4,14,4,14,4,4,14,14,4,4,14,14



;	db	14,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0

	ifne	(star_cols>>16)-(ztab>>16)
	error	"star_cols MUST be in same bank as ztab"
	endc


;pcircdat	MACRO
;	db	\1/2,\2/2,14,0
;	db	((\1*90)/100)/2,((\2*90)/100)/2,2,0
;	ENDM

particle_circle
	db	0,-20
	db	-7,-6
	db	-8,7
	db	-4,4
	db	5,12
	db	-9,-15
	db	9,-4
	db	13,16
	db	-15,7
	db	-1,3
	db	1,-2
	db	12,-5
	db	-11,-13
	db	-3,2
	db	20,2
	db	-25,-18
	db	2,4
	db	-10,15
	db	20,-2
	db	-13,16
	db	-10,-26
	db	-1,6
	db	-8,29
	db	16,11
	db	0,-17
	db	3,3
	db	-19,-1
	db	5,-21
	db	2,-14
	db	-13,-1
	db	0,-1
	db	7,20
	db	12,18
	db	-1,2
	db	4,-4
	db	1,-7
	db	-16,-14
	db	0,-9
	db	-10,-18
	db	8,0
	db	15,-10
	db	27,8
	db	9,-27
	db	-6,-13
	db	-11,-23
	db	-1,-1
	db	3,4
	db	-1,-7
	db	-27,-16
	db	3,-2
	db	-3,0
	db	7,13
	db	-5,-18
	db	28,-4
	db	-31,-1
	db	6,15
	db	3,16
	db	8,9
	db	-1,7
	db	0,-31
	db	3,16
	db	24,-5
	db	-27,13
	db	0,2
	db	24,-17
	db	10,2
	db	1,22
	db	-3,12
	db	19,-4
	db	19,-3
	db	-28,9
	db	1,22
	db	1,17
	db	2,-27
	db	-3,-2
	db	-22,14
	db	-25,-4
	db	-20,17
	db	-13,0
	db	1,-6
	db	10,-24
	db	-17,-12
	db	17,14
	db	3,4
	db	-3,-5
	db	2,0
	db	-20,12
	db	8,-1
	db	4,-29
	db	-25,-8
	db	0,-8
	db	-6,26
	db	29,-6
	db	-2,-15
	db	-22,16
	db	19,-4
	db	-1,3
	db	2,-6
	db	17,25
	db	6,0
	db	-4,21
	db	-2,-8
	db	-23,-9
	db	-31,-3
	db	7,-5
	db	-1,1
	db	19,2
	db	-1,2
	db	8,21
	db	2,7
	db	-22,17
	db	-23,10
	db	-14,7
	db	2,11
	db	-3,-19
	db	-5,2
	db	-27,-15
	db	5,-10
	db	-7,22
	db	14,19
	db	13,-4
	db	-3,17
	db	7,-17
	db	-24,-6
	db	1,0
	db	24,2
	db	9,2
	db	5,6
	db	-2,-31
	db	-26,-4
	db	-29,12
	db	31,0
	db	-2,-1
	db	-22,14
	db	-4,18
	db	-29,5
	db	-17,1
	db	-8,-19
	db	12,-12
	db	-16,4
	db	-5,-31
	db	-25,11
	db	4,3
	db	-8,28
	db	20,-12
	db	-3,-13
	db	18,14
	db	15,21
	db	-8,0
	db	0,-12
	db	-17,7
	db	-13,25
	db	-9,25
	db	4,25
	db	3,9
	db	-2,-3
	db	-1,-1
	db	1,-4
	db	-19,-18
	db	-19,23
	db	7,-6
	db	10,2
	db	14,-20
	db	1,-6
	db	0,-1
	db	-28,12
	db	1,-1
	db	2,-15
	db	-3,0
	db	-6,-26
	db	27,-8
	db	15,8
	db	13,20
	db	-12,1
	db	19,-16
	db	18,4
	db	6,-10
	db	29,-3
	db	6,0
	db	-20,-3
	db	-7,3
	db	2,25
	db	17,14
	db	9,16
	db	-15,26
	db	-7,21
	db	-9,-15
	db	4,-7
	db	-6,2
	db	11,-7
	db	-28,10
	db	-4,15
	db	2,27
	db	-8,28
	db	4,12
	db	3,4
	db	8,26
	db	2,10
	db	-6,-18
	db	14,8
	db	-19,10
	db	-11,21
	db	21,4
	db	-10,18
	db	-14,-1
	db	0,-12
	db	8,3
	db	-8,16
	db	-1,-4
	db	4,-2
	db	0,6
	db	-16,-25
	db	-8,3
	db	-6,-9
	db	-20,-14
	db	-14,19
	db	-16,-8
	db	-12,7
	db	5,1
	db	5,18
	db	2,-27
	db	17,-6
	db	1,-6
	db	-25,-15
	db	-6,15
	db	10,21
	db	0,27
	db	-7,9
	db	-22,-19
	db	12,15
	db	22,-6
	db	4,0
	db	3,-5
	db	-16,8
	db	21,-21
	db	-4,5
	db	2,-5
	db	-10,-17
	db	3,-4
	db	7,-26
	db	17,18
	db	-5,0
	db	-5,-2
	db	-1,-5
	db	-20,-2
	db	-17,5
	db	2,5
	db	-10,-1
	db	-12,-6
	db	-4,1
	db	9,3
	db	17,-11
	db	-8,-4
	db	-4,7
	db	1,-2




	ifeq	1
	 pcircdat     0,31
	 pcircdat     6,30
	 pcircdat     12,28
	 pcircdat     18,25
	 pcircdat     23,20
	 pcircdat     26,15
	 pcircdat     29,9
	 pcircdat     30,3
	 pcircdat     30,-4
	 pcircdat     29,-10
	 pcircdat     26,-16
	 pcircdat     23,-21
	 pcircdat     18,-26
	 pcircdat     12,-29
	 pcircdat     6,-31
	 pcircdat     0,-31
	 pcircdat    -7,-31
	 pcircdat    -13,-29
	 pcircdat    -19,-26
	 pcircdat    -24,-21
	 pcircdat    -27,-16
	 pcircdat    -30,-10
	 pcircdat    -31,-4
	 pcircdat    -31,3
	 pcircdat    -30,9
	 pcircdat    -27,15
	 pcircdat    -24,20
	 pcircdat    -19,25
	 pcircdat    -13,28
	 pcircdat    -7,30
	endc

mchar	macro
	dw	\1
	endm

mscalechars
	IFEQ	0
	INCBINFILE	data\moji_2.fon
	ELSEIF
;A
	mchar	%0000000000000000
	mchar	%0000111110000000
	mchar	%0001111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000

;B
	mchar	%0000000000000000
	mchar	%0011111111000000
	mchar	%0011111111100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111100000
	mchar	%0011111110000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111100000
	mchar	%0011111111000000

;C
	mchar	%0000000000000000
	mchar	%0001111111000000
	mchar	%0011111111100000
	mchar	%0011100001100000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100001100000
	mchar	%0011111111100000
	mchar	%0001111111000000

;D
	mchar	%0000000000000000
	mchar	%0011111110000000
	mchar	%0011111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111000000
	mchar	%0011111110000000

;E
	mchar	%0000000000000000
	mchar	%0011111111000000
	mchar	%0011111111000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011111100000000
	mchar	%0011111100000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011111111000000
	mchar	%0011111111000000

;F
	mchar	%0000000000000000
	mchar	%0011111111000000
	mchar	%0011111111000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011111100000000
	mchar	%0011111100000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000

;G
	mchar	%0000000000000000
	mchar	%0001111110000000
	mchar	%0011111111000000
	mchar	%0011100011000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011101111000000
	mchar	%0011101111000000
	mchar	%0011100111000000
	mchar	%0011100111000000
	mchar	%0011111111000000
	mchar	%0001111110000000

;H
	mchar	%0000000000000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000

;I
	mchar	%0000000000000000
	mchar	%0001111100000000
	mchar	%0001111100000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0000111000000000
	mchar	%0001111100000000
	mchar	%0001111100000000

;J
	mchar	%0000000000000000
	mchar	%0000111111100000
	mchar	%0000111111100000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0011100011100000
	mchar	%0011111111000000
	mchar	%0001111110000000
;k
	mchar	%0000000000000000
	mchar	%0011100111000000
	mchar	%0011100110000000
	mchar	%0011101110000000
	mchar	%0011101100000000
	mchar	%0011111000000000
	mchar	%0011110000000000
	mchar	%0011111100000000
	mchar	%0011101110000000
	mchar	%0011100111000000
	mchar	%0011100111000000
	mchar	%0011100011100000
;L
	mchar	%0000000000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011111111100000
	mchar	%0011111111100000
;M
	mchar	%0000000000000000
	mchar	%0011000001100000
	mchar	%0011100011100000
	mchar	%0011110111100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011101011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
;N
	mchar	%0000000000000000
	mchar	%0010000011100000
	mchar	%0011000011100000
	mchar	%0011100011100000
	mchar	%0011110011100000
	mchar	%0011111011100000
	mchar	%0011111111100000
	mchar	%0011101111100000
	mchar	%0011100111100000
	mchar	%0011100011100000
	mchar	%0011100001100000
	mchar	%0011100000100000
;O
	mchar	%0000000000000000
	mchar	%0000111110000000
	mchar	%0001111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0001111111000000
	mchar	%0000111110000000
;P
	mchar	%0000000000000000
	mchar	%0011111110000000
	mchar	%0011111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111000000
	mchar	%0011111110000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0011100000000000
;Q
	mchar	%0000000000000000
	mchar	%0000111110000000
	mchar	%0001111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011101011100000
	mchar	%0011101111100000
	mchar	%0011100111100000
	mchar	%0001111111100000
	mchar	%0000111111110000
;R
	mchar	%0000000000000000
	mchar	%0011111110000000
	mchar	%0011111111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011111111000000
	mchar	%0011111110000000
	mchar	%0011111100000000
	mchar	%0011101110000000
	mchar	%0011100111000000
	mchar	%0011100011100000
;S
	mchar	%0000000000000000
	mchar	%0000111111000000
	mchar	%0001111110000000
	mchar	%0011100000000000
	mchar	%0011100000000000
	mchar	%0001111110000000
	mchar	%0000111111000000
	mchar	%0000000011100000
	mchar	%0000000011100000
	mchar	%0011000011100000
	mchar	%0001111111000000
	mchar	%0000111110000000
;T
	mchar	%0000000000000000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
;U
	mchar	%0000000000000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0001111111000000
	mchar	%0000111110000000
;V
	mchar	%0000000000000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0001100011000000
	mchar	%0001110111000000
	mchar	%0000110110000000
	mchar	%0000111110000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000001000000000
;W
	mchar	%0000000000000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0011101011100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0011110111100000
	mchar	%0011100011100000
	mchar	%0011000001100000
;X
	mchar	%0000000000000000
	mchar	%0011100011100000
	mchar	%0011100011100000
	mchar	%0001110111000000
	mchar	%0000110110000000
	mchar	%0000011100000000
	mchar	%0000001000000000
	mchar	%0000011100000000
	mchar	%0000110110000000
	mchar	%0001110111000000
	mchar	%0011100011100000
	mchar	%0011100011100000
;Y
	mchar	%0000000000000000
	mchar	%0011000001100000
	mchar	%0011000001100000
	mchar	%0001100011000000
	mchar	%0001100011000000
	mchar	%0000110110000000
	mchar	%0000111110000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
	mchar	%0000011100000000
;Z
	mchar	%0000000000000000
	mchar	%0011111111100000
	mchar	%0011111111100000
	mchar	%0000000011100000
	mchar	%0000000111000000
	mchar	%0000001110000000
	mchar	%0000011100000000
	mchar	%0000111000000000
	mchar	%0001110000000000
	mchar	%0011100000000000
	mchar	%0011111111100000
	mchar	%0011111111100000

;' '
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000
	mchar	%0000000000000000

	ENDC

msgtmp	macro
	defs	1,"[1]\1"

	IFS	1,1," "
	defs	1,"h"
	ENDC

	REPT	12
	irs	3,"0","1","2","3","4","5","6","7","8","9","#","-"
	run	" IFS 1,1,'%$3'"
	irs	3,"\\","]","^","_","`","a","b","c","d","e","�","["
	defs	1,"%$3"
	ENDC
	ENDR
	endm

mariomsg	macro
	defs	2,"\1;"
	UPPER	2

	REPT	30
	IFNS	2,1,";"
	run	" msgtmp <%$2>"
	run	' db 1+"%$1"-"A"'
	rols	2,1
	ENDC
	ENDR
	db	0
		endm


mariomsgs
msg_starfox
	db	41,42,43,44,45,46,47,48,49,50,0

msg_nintendo
	mariomsg	<NINTENDO>
msg_presented
	mariomsg	<PREZENTITA >

msg_presents
	mariomsg	<PREZENTAS>

msg_developed
	mariomsg	<KUN HELPO>
msg_and
	mariomsg	<AND>
msg_programmed
	mariomsg	<PROGRAMITA>
msg_by
	mariomsg	<DE>
msg_argonaut
	mariomsg	<ARGONAUT SOFTWARE>

msg_executive
	mariomsg	<PLENUMA PRODUKTORO>

msg_yamauchi
	mariomsg	<HIROSHI YAMAUCHI>

msg_producer
	mariomsg	<PRODUKTORO>

msg_miyamoto
	mariomsg	<SHIGERU MIYAMOTO>

msg_director
	mariomsg	<REQISORO>

msg_eguchi
	mariomsg	<KATSUYA EGUCHI>

msg_assistantdirector
	mariomsg	<HELPANTA REQISORO>

msg_yamada
	mariomsg	<YOICHI YAMADA>

msg_dylan
;	db	49,50,51,52,53,54,0
	mariomsg	<DYLAN CUTHBERT>
msg_giles
;	db	55,56,57,58,59,60,61,0
	mariomsg	<GILES GODDARD>

msg_krister
	mariomsg	<KRISTER WOMBELL>

msg_3dsystem
	mariomsg	<3D-SISTEMO>

msg_pete
	mariomsg	<PETE WARNES>
msg_carl
	mariomsg	<CARL GRAHAM>

msg_graphicdesigner
	mariomsg	<GRAFIKA FASONISTO>

msg_imamura
	mariomsg	<TAKAYA IMAMURA>

msg_shapedesigner
	mariomsg	<FORMA FASONISTO>

msg_watanabe
	mariomsg	<TSUYOSHI WATANABE>

msg_kondo
	mariomsg	<KOJI KONDO>

msg_hirasawa
	mariomsg	<HAJIME HIRASAWA>

msg_superfxstaff
	mariomsg	<LABORISTOJ PRI SUPERFX>

msg_ben
	mariomsg	<BEN CHEESE>

msg_nishiumi
	mariomsg	<SATOSHI NISHIUMI>

msg_kakui
	mariomsg	<HIRONOBU KAKUI>

msg_yamashiro
	mariomsg	<SHIGEKI YAMASHIRO>

msg_kawaguchi
	mariomsg	<YASUHIRO KAWAGUCHI>

msg_thanksto
	mariomsg	<THANKS TO>

msg_jez
	mariomsg	<JEZ SAN>

msg_timoteo
	mariomsg	<TIMOTEO BORONCZYK>

msg_effects
	mariomsg	<SONEFIKOJ>

msg_composer
	mariomsg	<MUZIKO>

msg_nishida
	mariomsg	<YASUNARI NISHIDA>

msg_ian
	mariomsg	<IAN CROWTHER>

msg_dan
	mariomsg	<DAN OWEN>

msg_tony
	mariomsg	<TONY HARMAN>

msg_kimura
	mariomsg	<MASATO KIMURA>

msg_zerbie
	mariomsg	<ZERBIE HYNSON>

msg_steelemage
	mariomsg	<STEELEMAGE>

msg_yamamoto
	mariomsg	<KENJI YAMAMOTO>

msg_theend
	mariomsg	<THE END>

msg_english
	mariomsg	<SUBTENO PRI LA ANGLA>

msg_esperanto
	mariomsg	<SUBTENO PRI ESPERANTO>

msg_software
	mariomsg	<SUBTENO PRI SOFTVARO>

msg_rick
	mariomsg	<RICHARD CLUCAS>

msg_jondean
	mariomsg	<JON DEAN>

msg_ces
	mariomsg	<CES DEMO>
msg_demo
	mariomsg	<VERSION>

msg_deutscher
	mariomsg	<GERMAN TEXT>

msg_claude
	mariomsg	<CLAUDE MOYSE>

msg_0	mariomsg	<0>
msg_1	mariomsg	<1>
msg_2	mariomsg	<2>
msg_3	mariomsg	<3>
msg_4	mariomsg	<4>
msg_5	mariomsg	<5>
msg_6	mariomsg	<6>
msg_7	mariomsg	<7>
msg_8	mariomsg	<8>
msg_9	mariomsg	<9>
msg_per	db $26,$00  ; <#>

msg_00  db $28,$28,$1C,$26,$00   ; <  0#>
msg_01  db $28,$28,$1D,$26,$00   ; <  1#>
msg_02  db $28,$28,$1E,$26,$00   ; <  2#>
msg_03  db $28,$28,$1F,$26,$00   ; <  3#>
msg_04  db $28,$28,$20,$26,$00   ; <  4#>
msg_05  db $28,$28,$21,$26,$00   ; <  5#>
msg_06  db $28,$28,$22,$26,$00   ; <  6#>
msg_07  db $28,$28,$23,$26,$00   ; <  7#>
msg_08  db $28,$28,$24,$26,$00   ; <  8#>
msg_09  db $28,$28,$25,$26,$00   ; <  9#>
msg_10  db $28,$1D,$1C,$26,$00   ; < 10#>
msg_11  db $28,$1D,$1D,$26,$00   ; < 11#>
msg_12  db $28,$1D,$1E,$26,$00   ; < 12#>
msg_13  db $28,$1D,$1F,$26,$00   ; < 13#>
msg_14  db $28,$1D,$20,$26,$00   ; < 14#>
msg_15  db $28,$1D,$21,$26,$00   ; < 15#>
msg_16  db $28,$1D,$22,$26,$00   ; < 16#>
msg_17  db $28,$1D,$23,$26,$00   ; < 17#>
msg_18  db $28,$1D,$24,$26,$00   ; < 18#>
msg_19  db $28,$1D,$25,$26,$00   ; < 19#>
msg_20  db $28,$1E,$1C,$26,$00   ; < 20#>
msg_21  db $28,$1E,$1D,$26,$00   ; < 21#>
msg_22  db $28,$1E,$1E,$26,$00   ; < 22#>
msg_23  db $28,$1E,$1F,$26,$00   ; < 23#>
msg_24  db $28,$1E,$20,$26,$00   ; < 24#>
msg_25  db $28,$1E,$21,$26,$00   ; < 25#>
msg_26  db $28,$1E,$22,$26,$00   ; < 26#>
msg_27  db $28,$1E,$23,$26,$00   ; < 27#>
msg_28  db $28,$1E,$24,$26,$00   ; < 28#>
msg_29  db $28,$1E,$25,$26,$00   ; < 29#>
msg_30  db $28,$1F,$1C,$26,$00   ; < 30#>
msg_31  db $28,$1F,$1D,$26,$00   ; < 31#>
msg_32  db $28,$1F,$1E,$26,$00   ; < 32#>
msg_33  db $28,$1F,$1F,$26,$00   ; < 33#>
msg_34  db $28,$1F,$20,$26,$00   ; < 34#>
msg_35  db $28,$1F,$21,$26,$00   ; < 35#>
msg_36  db $28,$1F,$22,$26,$00   ; < 36#>
msg_37  db $28,$1F,$23,$26,$00   ; < 37#>
msg_38  db $28,$1F,$24,$26,$00   ; < 38#>
msg_39  db $28,$1F,$25,$26,$00   ; < 39#>
msg_40  db $28,$20,$1C,$26,$00   ; < 40#>
msg_41  db $28,$20,$1D,$26,$00   ; < 41#>
msg_42  db $28,$20,$1E,$26,$00   ; < 42#>
msg_43  db $28,$20,$1F,$26,$00   ; < 43#>
msg_44  db $28,$20,$20,$26,$00   ; < 44#>
msg_45  db $28,$20,$21,$26,$00   ; < 45#>
msg_46  db $28,$20,$22,$26,$00   ; < 46#>
msg_47  db $28,$20,$23,$26,$00   ; < 47#>
msg_48  db $28,$20,$24,$26,$00   ; < 48#>
msg_49  db $28,$20,$25,$26,$00   ; < 49#>
msg_50  db $28,$21,$1C,$26,$00   ; < 50#>
msg_51  db $28,$21,$1D,$26,$00   ; < 51#>
msg_52  db $28,$21,$1E,$26,$00   ; < 52#>
msg_53  db $28,$21,$1F,$26,$00   ; < 53#>
msg_54  db $28,$21,$20,$26,$00   ; < 54#>
msg_55  db $28,$21,$21,$26,$00   ; < 55#>
msg_56  db $28,$21,$22,$26,$00   ; < 56#>
msg_57  db $28,$21,$23,$26,$00   ; < 57#>
msg_58  db $28,$21,$24,$26,$00   ; < 58#>
msg_59  db $28,$21,$25,$26,$00   ; < 59#>
msg_60  db $28,$22,$1C,$26,$00   ; < 60#>
msg_61  db $28,$22,$1D,$26,$00   ; < 61#>
msg_62  db $28,$22,$1E,$26,$00   ; < 62#>
msg_63  db $28,$22,$1F,$26,$00   ; < 63#>
msg_64  db $28,$22,$20,$26,$00   ; < 64#>
msg_65  db $28,$22,$21,$26,$00   ; < 65#>
msg_66  db $28,$22,$22,$26,$00   ; < 66#>
msg_67  db $28,$22,$23,$26,$00   ; < 67#>
msg_68  db $28,$22,$24,$26,$00   ; < 68#>
msg_69  db $28,$22,$25,$26,$00   ; < 69#>
msg_70  db $28,$23,$1C,$26,$00   ; < 70#>
msg_71  db $28,$23,$1D,$26,$00   ; < 71#>
msg_72  db $28,$23,$1E,$26,$00   ; < 72#>
msg_73  db $28,$23,$1F,$26,$00   ; < 73#>
msg_74  db $28,$23,$20,$26,$00   ; < 74#>
msg_75  db $28,$23,$21,$26,$00   ; < 75#>
msg_76  db $28,$23,$22,$26,$00   ; < 76#>
msg_77  db $28,$23,$23,$26,$00   ; < 77#>
msg_78  db $28,$23,$24,$26,$00   ; < 78#>
msg_79  db $28,$23,$25,$26,$00   ; < 79#>
msg_80  db $28,$24,$1C,$26,$00   ; < 80#>
msg_81  db $28,$24,$1D,$26,$00   ; < 81#>
msg_82  db $28,$24,$1E,$26,$00   ; < 82#>
msg_83  db $28,$24,$1F,$26,$00   ; < 83#>
msg_84  db $28,$24,$20,$26,$00   ; < 84#>
msg_85  db $28,$24,$21,$26,$00   ; < 85#>
msg_86  db $28,$24,$22,$26,$00   ; < 86#>
msg_87  db $28,$24,$23,$26,$00   ; < 87#>
msg_88  db $28,$24,$24,$26,$00   ; < 88#>
msg_89  db $28,$24,$25,$26,$00   ; < 89#>
msg_90  db $28,$25,$1C,$26,$00   ; < 90#>
msg_91  db $28,$25,$1D,$26,$00   ; < 91#>
msg_92  db $28,$25,$1E,$26,$00   ; < 92#>
msg_93  db $28,$25,$1F,$26,$00   ; < 93#>
msg_94  db $28,$25,$20,$26,$00   ; < 94#>
msg_95  db $28,$25,$21,$26,$00   ; < 95#>
msg_96  db $28,$25,$22,$26,$00   ; < 96#>
msg_97  db $28,$25,$23,$26,$00   ; < 97#>
msg_98  db $28,$25,$24,$26,$00   ; < 98#>
msg_99  db $28,$25,$25,$26,$00   ; < 99#>
msg_100  db $1D,$1C,$1C,$26,$00  ; <100#>
msg_xxx	mariomsg	< --->
msg_total mariomsg	<POENTARO>
msg_ave	mariomsg	<PROCENTO>
msg_stage mariomsg	<SCENO>

msg_score1000	mariomsg	<1000>
msg_score500	mariomsg	<500>
msg_score100	mariomsg	<100>




