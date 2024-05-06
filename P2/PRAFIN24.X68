*-----------------------------------------------------------
* Title      : PRAFIN24
* Written by : <nombres completos de los autores>
* Date       : 26/05/2024
* Description: Emulador de la SUIBC
*-----------------------------------------------------------
    ORG $1000
EMEM:   DC.W $A00C,$00A0,$7002,$5000,$A80D,$00A0,$4420,$63FD
        DC.W $00A0,$2060,$800E,$C000,$0003,$0004,$0000
EIR:    DC.W 0 ;eregistro de instruccion
EPC:    DC.W 0 ;econtador de programa
ER0:    DC.W 0 ;eregistro R0
ER1:    DC.W 0 ;eregistro R1
ER2:    DC.W 0 ;eregistro R2
ER3:    DC.W 0 ;eregistro R3
ESR:    DC.W 0 ;eregistro de estado (00000000 00000ZNC)

RESULTADO:  DS.W    1

CODE:   DS.W    12

START:
    CLR.W EPC
    
    LEA.L   CODE,A1

FETCH:
    ;--- IFETCH: INICIO FETCH
        ;*** En esta seccion debeis introducir el codigo necesario para cargar
        ;*** en el EIR la siguiente instruccion a ejecutar, indicada por el EPC,
	    ;*** y dejar listo el EPC para que apunte a la siguiente instruccion
	
	        ; ESCRIBID VUESTRO CODIGO AQUI	    

    MOVE.W  EPC,D0
    
    MULU    #2,D0   ;2*EPC (ANTES DE AUMENTAR EPC)
    LEA.L   EMEM,A0 ;A0 = @EMEM
    ADD.W   D0,A0   ;A0 = @EMEM + 2*EPC  ASÍ OBTENEMOS LA INSTRUCCIÓN A EJECUTAR
    
    MOVE.W  (A0),EIR   ;GUARDAMOS LA INSTRUCCIÓN A EJECUTAR EN EIR
    
    ADDQ    #1,EPC	;AUMENTO EL VALOR DEL EPC PARA QUE APUNTE A LA SIGUIENTE INSTRUCCIÓN A EJECUTAR
    
BRDECOD:
    
    MOVE.W  #0,-(SP)    ;GUARDAMOS ESPACIO PARA EL RESULTADO
    MOVE.W  EIR,-(SP)   ;GUARDAMOS ESPACIO PARA EIR
    
    JSR DECOD
    
    ADD.L  #2,SP                ;QUITAMOS EIR DE LA PILA
    MOVE.W  (SP)+,RESULTADO     ;SACAMOS EL RESULTADO DE LA PILA

    MOVE.W  RESULTADO,(A1)+     ;ESCRIBIMOS EN CODE
    
    BRA FETCH   ;VOLVEMOS A FETCH

        
    ;--- FFETCH: FIN FETCH
    
    
    
    ;--- IBRDECOD: INICIO SALTO A DECOD
        ;*** En esta seccion debeis preparar la pila para llamar a la subrutina
        ;*** DECOD, llamar a la subrutina, y vaciar la pila correctamente,
        ;*** almacenando el resultado de la decodificacion en D1

    	    ; ESCRIBID VUESTRO CODIGO AQUI    	    
        
    ;--- FBRDECOD: FIN SALTO A DECOD
    
    
    
    ;--- IBREXEC: INICIO SALTO A FASE DE EJECUCION
        ;*** Esta seccion se usa para saltar a la fase de ejecucion
        ;*** NO HACE FALTA MODIFICARLA
    MULU #6,D1
    MOVEA.L D1,A1
    JMP JMPLIST(A1)
JMPLIST:
    JMP ESTO
    JMP ELOA
    JMP ECMP
    JMP EADD
    JMP ESUB
    JMP ENOR
    JMP ESET
    JMP EADQ
    JMP ETRA
    JMP EJMZ
    JMP EJMN
    JMP EJMI
    JMP EHLT
    ;--- FBREXEC: FIN SALTO A FASE DE EJECUCION
    
    
    
    ;--- IEXEC: INICIO EJECUCION
        ;*** En esta seccion debeis implementar la ejecucion de cada einstr.
	
	; ESCRIBID EN CADA ETIQUETA LA FASE DE EJECUCION DE CADA INSTRUCCION
ESTO:
ELOA:
ECMP:
EADD:
ESUB:
ENOR:
ESET:
EADQ:
ETRA:
EJMZ:
EJMN:
EJMI:
EHLT:
    ;--- FEXEC: FIN EJECUCION
    
    

    ;--- ISUBR: INICIO SUBRUTINAS
        ;*** Aqui debeis incluir las subrutinas que necesite vuestra solucion
        ;*** SALVO DECOD, que va en la siguiente seccion

	        ; ESCRIBID VUESTRO CODIGO AQUI
        
    ;--- FSUBR: FIN SUBRUTINAS
    
    

    ;--- IDECOD: INICIO DECOD
        ;*** Tras la etiqueta DECOD, debeis implementar la subrutina de 
        ;*** decodificacion, que debera ser de libreria, siguiendo la interfaz
        ;*** especificada en el enunciado
DECOD:
	        ; ESCRIBID VUESTRO CODIGO AQUI

*--------------------------------------------------------
    MOVE.L  D0,-(SP)    ;GUARDAMOS EL REGISTRO D0, YA QUE LO VAMOS A USAR
    
    MOVE.W  8(SP),D0    ;METEMOS EIR EN EL REGISTRO D0
    
    ;DECODIFICAMOS Y ESCRIBIMOS EN LA PILA EL RESULTADO

    BTST.L  #15,D0  ;COMPRUEBA BIT 15 (MAS SIGNIFICATIVO)
    BEQ CADENADEC0
    BRA CADENADEC1
    
CADENADEC0: ;DEC = 0

    BTST.L  #14,D0
    BEQ CADENADEC00
    BRA CADENADEC01
    
CADENADEC1: ;DEC = 1
    
    BTST.L  #14,D0
    BEQ CADENADEC10
    BRA CADENADEC11

CADENADEC00: ;DEC = 00

    BTST.L  #13,D0
    BEQ CADENADEC000
    BRA CADENADEC001
    
CADENADEC01: ;DEC = 01

    BTST.L  #13,D0
    BEQ CADENADEC010
    BRA CADENADEC011
    
CADENADEC10: ;DEC = 10

    BTST.L  #13,D0
    BEQ CADENADEC100
    BRA CADENADEC101
    
CADENADEC11: ;DEC = 11 = INSTRUCCION 12 (HLT)
    
    MOVE.W  #12,10(SP)
    BRA YADECODIFICADO
    
CADENADEC000: ;DEC = 000

    BTST.L  #12,D0
    BEQ CADENADEC0000
    BRA CADENADEC0001

CADENADEC001: ;DEC = 001 = INSTRUCCION 11 (JMI)

    MOVE.W  #11,10(SP)
    BRA YADECODIFICADO

CADENADEC010: ;DEC = 010

    BTST.L  #12,D0
    BEQ CADENADEC0100
    BRA CADENADEC0101
    
CADENADEC011: ;DEC = 011

    BTST.L  #12,D0
    BEQ CADENADEC0110
    BRA CADENADEC0111
    
CADENADEC100: ;DEC = 100 = INSTRUCCION 0 (STO)

    MOVE.W  #0,10(SP)
    BRA YADECODIFICADO

CADENADEC101: ;DEC = 101 = INSTRUCCION 1 (LOA)

    MOVE.W  #1,10(SP)
    BRA YADECODIFICADO
    
CADENADEC0000: ;DEC = 0000 = INSTRUCCION 9 (JMZ)
    
    MOVE.W  #9,10(SP)
    BRA YADECODIFICADO
    
CADENADEC0001: ;DEC = 0001 = INSTRUCCION 10 (JMN)
    
    MOVE.W  #10,10(SP)
    BRA YADECODIFICADO
    
CADENADEC0100: ;DEC = 0100

    BTST.L  #11,D0
    BEQ CADENADEC01000
    BRA CADENADEC01001
    
CADENADEC0101: ;DEC = 0101 = INSTRUCCION 6 (SET)
    
    MOVE.W  #6,10(SP)
    BRA YADECODIFICADO
    
CADENADEC0110: ;DEC = 0110 = INSTRUCCION 7 (ADQ)

    MOVE.W  #7,10(SP)
    BRA YADECODIFICADO
    
CADENADEC0111: ;DEC = 0111 = INSTRUCCION 8 (TRA)

    MOVE.W  #8,10(SP)
    BRA YADECODIFICADO

CADENADEC01000: ;DEC = 01000

    BTST.L  #10,D0
    BEQ CADENADEC010000
    BRA CADENADEC010001

CADENADEC01001: ;DEC = 01001

    BTST.L  #10,D0
    BEQ CADENADEC010010
    BRA CADENADEC010011

CADENADEC010000: ;DEC = 010000 = INSTRUCCION 2 (CMP)

    MOVE.W  #2,10(SP)
    BRA YADECODIFICADO
    
CADENADEC010001: ;DEC = 010001 = INSTRUCCION 3 (ADD)

    MOVE.W  #3,10(SP)
    BRA YADECODIFICADO
    
CADENADEC010010: ;DEC = 010010 = INSTRUCCION 4 (SUB)

    MOVE.W  #4,10(SP)
    BRA YADECODIFICADO
    
CADENADEC010011: ;DEC = 010011 = INSTRUCCION 5 (NOR)

    MOVE.W  #5,10(SP)
    BRA YADECODIFICADO
        
    
YADECODIFICADO: ;RECUPERAMOS LOS VALORES DE LOS REGISTROS USADOS Y VOLVEMOS
    MOVE.L  (SP)+,D0
    RTS
    
*--------------------------------------------------------
    
    
    
FDECOD:
    
    

    ;--- FDECOD: FIN DECOD
    END    START

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
