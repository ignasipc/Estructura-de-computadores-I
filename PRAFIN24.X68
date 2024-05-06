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

CODE:   DS.W    12


START:
    CLR.W EPC
    
    
    ;Volver a saltar a la etiqueta FETCH, en el caso de no se hayan 
    ;procesado todas las einstrucciones del vector EMEM. ??????
    
    
    LEA.L   EMEM,A0 ;A0 DIRECCION DE EMEM
    LEA.L   CODE,A1 ;A1 DIRECCION DE CODE
    
    MOVE.L  #12,D0  ;NUMERO DE COMPONENTES DE EMEM
    SUB.L   #1,D0   ;ITERA DE 0 A 12-1
    
RECORREREMEM:
    
    MOVE.W  (A0)+,D1    ;D1 CONTIENE LA COMPONENTE DE EMEM
    BRA DECOD
YADECODIFICADO:
    
    DBRA    D0,RECORREREMEM
    BRA FDECOD          ;A PARTIR DE AQUI CODE CONTIENE LA CODIFICACION DE EMEM


FETCH:
    ;--- IFETCH: INICIO FETCH
        ;*** En esta seccion debeis introducir el codigo necesario para cargar
        ;*** en el EIR la siguiente instruccion a ejecutar, indicada por el EPC,
	    ;*** y dejar listo el EPC para que apunte a la siguiente instruccion
	
	        ; ESCRIBID VUESTRO CODIGO AQUI	    
        
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
;D1 CONTIENE LA COMPONENTE DE EMEM

    BTST.L  #15,D1  ;COMPRUEBA BIT 15 (MAS SIGNIFICATIVO)
    BEQ CADENADEC0
    BRA CADENADEC1
    
CADENADEC0: ;DEC = 0

    BTST.L  #14,D1
    BEQ CADENADEC00
    BRA CADENADEC01
    
CADENADEC1: ;DEC = 1
    
    BTST.L  #14,D1
    BEQ CADENADEC10
    BRA CADENADEC11

CADENADEC00: ;DEC = 00

    BTST.L  #13,D1
    BEQ CADENADEC000
    BRA CADENADEC001
    
CADENADEC01: ;DEC = 01

    BTST.L  #13,D1
    BEQ CADENADEC010
    BRA CADENADEC011
    
CADENADEC10: ;DEC = 10

    BTST.L  #13,D1
    BEQ CADENADEC100
    BRA CADENADEC101
    
CADENADEC11: ;DEC = 11 = INSTRUCCION 12 (HLT)
    
    MOVE.W  #12,(A1)+
    BRA YADECODIFICADO
    
CADENADEC000: ;DEC = 000

    BTST.L  #12,D1
    BEQ CADENADEC0000
    BRA CADENADEC0001

CADENADEC001: ;DEC = 001 = INSTRUCCION 11 (JMI)

    MOVE.W  #11,(A1)+
    BRA YADECODIFICADO

CADENADEC010: ;DEC = 010

    BTST.L  #12,D1
    BEQ CADENADEC0100
    BRA CADENADEC0101
    
CADENADEC011: ;DEC = 011

    BTST.L  #12,D1
    BEQ CADENADEC0110
    BRA CADENADEC0111
    
CADENADEC100: ;DEC = 100 = INSTRUCCION 0 (STO)

    MOVE.W  #0,(A1)+
    BRA YADECODIFICADO

CADENADEC101: ;DEC = 101 = INSTRUCCION 1 (LOA)

    MOVE.W  #1,(A1)+
    BRA YADECODIFICADO
    
CADENADEC0000: ;DEC = 0000 = INSTRUCCION 9 (JMZ)
    
    MOVE.W  #9,(A1)+
    BRA YADECODIFICADO
    
CADENADEC0001: ;DEC = 0001 = INSTRUCCION 10 (JMN)
    
    MOVE.W  #10,(A1)+
    BRA YADECODIFICADO
    
CADENADEC0100: ;DEC = 0100

    BTST.L  #11,D1
    BEQ CADENADEC01000
    BRA CADENADEC01001
    
CADENADEC0101: ;DEC = 0101 = INSTRUCCION 6 (SET)
    
    MOVE.W  #6,(A1)+
    BRA YADECODIFICADO
    
CADENADEC0110: ;DEC = 0110 = INSTRUCCION 7 (ADQ)

    MOVE.W  #7,(A1)+
    BRA YADECODIFICADO
    
CADENADEC0111: ;DEC = 0111 = INSTRUCCION 8 (TRA)

    MOVE.W  #8,(A1)+
    BRA YADECODIFICADO

CADENADEC01000: ;DEC = 01000

    BTST.L  #10,D1
    BEQ CADENADEC010000
    BRA CADENADEC010001

CADENADEC01001: ;DEC = 01001

    BTST.L  #10,D1
    BEQ CADENADEC010010
    BRA CADENADEC010011

CADENADEC010000: ;DEC = 010000 = INSTRUCCION 2 (CMP)

    MOVE.W  #2,(A1)+
    BRA YADECODIFICADO
    
CADENADEC010001: ;DEC = 010001 = INSTRUCCION 3 (ADD)

    MOVE.W  #3,(A1)+
    BRA YADECODIFICADO
    
CADENADEC010010: ;DEC = 010010 = INSTRUCCION 4 (SUB)

    MOVE.W  #4,(A1)+
    BRA YADECODIFICADO
    
CADENADEC010011: ;DEC = 010011 = INSTRUCCION 5 (NOR)

    MOVE.W  #5,(A1)+
    BRA YADECODIFICADO

*--------------------------------------------------------
    
FDECOD:
    
    

    ;--- FDECOD: FIN DECOD
    END    START














*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
