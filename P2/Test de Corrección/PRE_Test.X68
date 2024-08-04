*-----------------------------------------------------------
* Program    : TEST PREVIO
* Description: Si este test no funciona correctamente,
*              la practica no se corrige.
*-----------------------------------------------------------
    ORG $1000
EMEM:   DC.W $A807,$7012,$2050,$4860,$C000,$4460,$C000,$0001
EIR:    DC.W 0 ;eregistro de instruccion
EPC:    DC.W 0 ;econtador de programa
ER0:    DC.W 0 ;eregistro R0
ER1:    DC.W 0 ;eregistro R1
ER2:    DC.W 0 ;eregistro R2
ER3:    DC.W 0 ;eregistro R3
ESR:    DC.W 0 ;eregistro de estado (00000000 00000ZNC)
