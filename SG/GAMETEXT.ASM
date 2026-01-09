	IFEQ	GERMAN
pausetxt	TXT	14,<PA)ZITA>
	ELSEIF
pausetxt	TXT	14,<PAUSE>
	ENDC

	IFEQ	GERMAN
totalscoretxt	TXT	14,<TOTALAJ POENTOJ>
	ELSEIF
totalscoretxt	TXT	14,<GESAMTPUNKTZAHL>
	ENDC

	IFEQ	GERMAN
scoretxt	TXT	14,<PROCENTO>
	ELSEIF
scoretxt	TXT	14,<PUNKTE>
	ENDC

slashtxt	TXT	14,</>
percenttxt	TXT	14,<PERCENTAGE>

	IFEQ	GERMAN
	IFEQ	CONTEST
bonustxt	TXT	14,<KREDITO ALDONITA>
	ELSEIF
bonustxt	TXT	14,<PERFECT BONUS 1OOOOO>
	ENDC
	ELSEIF
bonustxt	TXT	14,<BONUS 1 VERSUCH>
	ENDC

percenttxt2	TXT	14,<%>
perfecttxt	TXT	14,<PERFECT//>

	IFEQ	GERMAN
teamtxt	TXT	14,<WIRMILOJ DE SKIPANOJ>
	ELSEIF
teamtxt	TXT	14,<TEAM POWER>
	ENDC

frogtxt	TXT	14,<GLIT=JO>
bunnytxt	TXT	14,<PE=JO>
cocktxt	TXT	14,<FALKO>
deadtxt	TXT	14,<MORTIS>
stagetxt	TXT	14,<SCENO>
cesmintxt	TXT	2,<m>
cessectxt	TXT	2,<s>
scoretxt2	TXT	2,<score>

;-------------------------------------------------------------------

helpsnd	=	0
downsnd	=	1
othersnd	=	2

message	MACRO	[person,english,japanese,sound]
	printf	"%tDW%t",*&WM,"%t; (",msgnum,") {english} ** {japanese}%n"
	DB	friend_{person}

	IFEQ	NARG-3
	db	othersnd
	ELSEIF
	DB	{sound}snd
	ENDC

	TXT	14,<{english}>,<{japanese}>
msgnum	=	msgnum+1
	ENDM

;-------------------------------------------------------------------

msgnum	=	1

	fopen	msgs.txt

	IFEQ	german
	include	gamemsgs.inc
	ELSEIF
	include	german.inc
	ENDC

	fclose	!

messages	include	msgs.txt




