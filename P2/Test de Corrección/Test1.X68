*-----------------------------------------------------------
* Program    : TEST1
* Description: Comprueba si la subrutina DECOD cumple
*              con las especificaciones.
*-----------------------------------------------------------

         ORG  $1200
ECOD:    DC.W $A000,$4400,$4C00,$6000,$0000,$2000,$8000
         DC.W $4000,$4800,$5000,$7000,$1000,$C000
RINS:    DS.W 1
CPRO:    DS.W 1

         ORG  $1230
NUMCOOK: DC.B $01,$03,$05,$07,$09,$0B,$00
         DC.B $02,$04,$06,$08,$0A,$0C

         ORG  $1250
N:       EQU  13
NUMCO:   DS.B N
         DS.W 0
NUMERR:  DC.W 0

START:
    CLR.W  CPRO
    MOVE.W #N,D1
    SUBQ.W #1,D1
    CLR.W D4

LOOP:
    MOVE.W CPRO,D5
    ASL.W  #1,D5
    MOVEA.W D5,A3
    MOVE.W ECOD(A3),RINS

    SUBQ.L #2,SP
    MOVE.W RINS,-(SP)

    JSR DECOD

    ADDQ.L #2,SP
    MOVE.W (SP)+,D2

    MOVEA.W D4,A3
    MOVE.B D2,NUMCO(A3)
    MOVE.B NUMCOOK(A3),D3
    CMP.B  D2,D3
    BEQ NOERR
    ADDQ.W #1,NUMERR

    NOERR: ADDQ.W #1,D4
    ADDQ.W #1,CPRO
    DBRA D1,LOOP

    SIMHALT

DECOD: ; Colocar la subrutina a partir de aqui

    END   START