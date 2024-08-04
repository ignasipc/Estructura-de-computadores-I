*-----------------------------------------------------------
* Program    : TEST2
* Description:
*-----------------------------------------------------------
    ORG $1000
EMEM:   DC.W $2020,$C000,$53FF,$6007,$A815,$7030,$1140,$8817,$7032
        DC.W $7013,$A018,$4810,$A818,$4410,$0120,$C000,$C000
        DC.W $C000,$A815,$4C10,$C000,$0002,$0000,$0000,$0001
EIR:    DC.W 0 ;eregistro de instruccion
EPC:    DC.W 0 ;econtador de programa
ER0:    DC.W 0 ;eregistro R0
ER1:    DC.W 0 ;eregistro R1
ER2:    DC.W 0 ;eregistro R2
ER3:    DC.W 0 ;eregistro R3
ESR:    DC.W 0 ;eregistro de estado (00000000 00000ZNC)
