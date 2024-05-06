*------------------------------------------------
* Titulo : P1 (2023-2024) - Sieve of Eratosthenes
* Autores: Elena Morey Martín y Ignasi Paredes Casasnovas
*------------------------------------------------
    ORG $1000
N:  EQU 10
P:  DS.B N
    DS.W 0
C:  DS.W 1
*--------------------------------------------

P2: DS.B N
    DS.W 0

START:

*****************************************************************************
;CREAMOS P2 = {1, 2, ..., N}

    MOVEA.L #0,A0
    LEA.L   P2,A0
    
    CLR D0
    CLR D1
    MOVE.B   #1,D0
    MOVE.B   #N,D1
    SUB.B    #1,D1
    
CREARVECTORP2:

    MOVE.B  D0,(A0)+
    ADD.B   #01,D0
    
    DBRA    D1,CREARVECTORP2  

;YA TENEMOS CREADO P2 = {1, 2, ..., N}
*****************************************************************************



*****************************************************************************
;ALGORITMO DE CRIBA DE ERATOSTENES, DONDE CONVERTIMOS LOS NUMEROS NO PRIMOS
;DE P2 A 0
   
    CLR D0
    CLR D1
    CLR D2
    CLR D3
    CLR D4
    CLR D5
    MOVEA.L #0,A0   ;TODO LO QUE VAMOS A USAR A 0s
    
    ADD.W   #0,D0   ;D0 CONTIENE LA ITERACION K (0 <= K <= N-1)
    
    LEA.L   P2,A0   ;A0 CONTIENE LA DIRECCION DE P2
    
DOWHILE:   ;ITERACION DE 0 A N-1 (N ITERACIONES), DONDE VAMOS COPIANDO EN D1
           ;LOS COMPONENTES DE P2
    MOVE.B  (A0)+,D1
    
    CMP #0,D1
    BEQ ES0 ;SI ES 0, NOS AHORRAMOS LA ITERACION, MAYOR EFICIENCIA
    
    CMP #1,D1
    BEQ ES1 ;SI ES 1, LO IGNORAMOS, YA QUE NO SIRVE EL METODO CON EL 1

    ;FOR DE D2=2 TO D2=N, MULTIPLICAMOS D1 POR D2 PARA OBTENER SUS MULTIPLOS
    MOVE.W   #2,D2
FOR1:
SIGUIENTE:
    MOVE.W  D1,D3
    MULU.W  D2,D3
    
    CMP #N,D3
    BHI MAYORAN ;SI EL MULTIPLO YA SOBREPASA N, NO HACE FALTA COMPROBAR NADA
                ;MAYOR EFICIENCIA
    
    ;FOR DE D4=1 TO D4=N, RECORRE P2 BUSCANDO NUMEROS IGUALES A D3
    MOVE.W  #1,D4
    MOVEA.L #0,A1
    LEA.L   P2,A1
FOR2:
    MOVE.B  (A1),D5

    CMP D3,D5
    
    BEQ IGUALES
    ;SI SON IGUALES PONEMOS A 0
        
    BRA NOIGUALES
    ;SI NO, SEGUIMOS BUSCANDO
    
IGUALES:
    MOVE.B  #0,(A1)
    BRA SIGUIENTE   ;YA HEMOS ENCONTRADO EL NUMERO, ENTONCES ACABA EL BUCLE
                    ;MEJORA DE LA EFICIENCIA
    
NOIGUALES:
    ADDQ    #1,A1
    ADD.W   #1,D4
    CMP #N,D4
    BLS FOR2
;END FOR 2

MAYORAN:

    ADD.W   #1,D2
    CMP #N,D2
    BLS FOR1 ;SEGUIMOS BUSCANDO MULTIPLOS O NO
;END FOR 1

ES1:    ;NO HACEMOS NADA CON EL 1
ES0:    ;SI YA ES 0, NO TENEMOS QUE MULTIPLICAR POR NADA, MEJORAMOS
        ;EFICIENCIA

    ADD.W   #1,D0
    CMP #N,D0
    BLO DOWHILE     ;VAMOS A BUSCAR EL SIGUIENTE VALOR DE P2 O YA HEMOS
                    ;RECORRIDO TODO EL VECTOR

;YA TENEMOS P2 CON LOS NUMEROS PRIMOS Y LOS NO PRIMOS A VALOR 0
*****************************************************************************



*****************************************************************************
;ALGORITMO DE ORDENACION DE P2 A P DEJANDO LOS PRIMOS AL PRINCIPIO Y LOS 0s
;AL FINAL

    MOVEA.L #0,A0
    MOVEA.L #0,A1
    MOVEA.L #0,A2
    LEA.L   P,A0        ;A0 DIRECCION PRIMERA COMPONENTE DE P
    LEA.L   P2,A1       ;A1 DIRECCION PRIMERA COMPONENTE DE P2
    LEA.L   C,A2        ;A2 DIRECCION ULTIMA COMPONENTE DE P
    
    CLR D0              ;D0 CONTENDRA EL DATO DE CADA COMPONENTE EN CADA ITER
    CLR D1              ;D1 NUMERO DE ITERACIONES (N)
    CLR D2              ;D2 CONTENDRA EL NUMERO DE PRIMOS DE P
    CLR D3
    MOVE.B   #N,D1
    SUB.B    #1,D1
    
    ;SI ES N IMPAR TIENE QUE RESTAR 1 A A2, SINO, NO
    MOVE.B  #N,D3
    BTST    #0,D3   ;COMPROBAMOS EL BIT MENOS SIGNIFICATIVO DE N PARA SABER
                    ;SI ES PAR O IMPAR
    
    BEQ ESPAR       ;SI Z=0 ES PAR, SINO, ES IMPAR Y TENEMOS QUE RESTAR
    SUBA    #1,A2
    
ESPAR:
    
P2APORDENADO:

    MOVE.B  (A1)+,D0
    
    CMP #0,D0
    BNE P2NOES0   ;LA COMPONENTE DE P2 != 0
    
    ;SI ES 0 
    MOVE.B  D0,-(A2)    ;LO AÑADIMOS AL FINAL DEL VECTOR P
    
    BRA FINCOPIARP2SIN0S
    
P2NOES0:
    ADD.B   #1,D2      ;SI NO ES 0 TENEMOS UN NUMERO PRIMO Y SUMAMOS 1 A C
    MOVE.B  D0,(A0)+    ;Y AÑADIMOS EL PRIMO AL PRINCIPIO DEL VECTOR DE P

FINCOPIARP2SIN0S:

    ADD.B   #1,D0
    
    DBRA    D1,P2APORDENADO  ;REALIZAMOS N ITERACIONES
    
    MOVE.W  D2,C             ;GUARDAMOS EL NUMERO DE PRIMOS EN C
    
    
;YA TENEMOS P ORDENADO Y ACABAMOS LA EJECUCION
*****************************************************************************

    SIMHALT

    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
