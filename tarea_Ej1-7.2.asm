%include "io.mac"

.DATA
;definicion de parametros 
init          db 'Inicio',0
prompt1_msg db 'Enter first number ',0
prompt2_msg db 'Enter Second Number ',0
sum_msg     db 'Sum is: ',0
error_msg   db 'Overflow has occurred!',0
fin  db '$'

.UDATA
number1 resd 1
number2 resd 1
sum     resd 1



.CODE
    .STARTUP
      moverPuntero:
        mov      EBX, init    ;mueve el puntero al inicio del segmento de datos
      
      movimiento:
        sub      ECX, ECX     ;Limpia ECX
        mov      CX, 9        ;Contador para que imprima los 8 bits juntos
        mov      AL, [EBX]    ;Le el valor de la direccion que apunta EBX
        cmp      Al, '$'      ;Condicion de parada
        je       program      ;Secuencia normal del programa
        
            
      celdaMemoria:           ;Procesa cada valor guardado el el segmento
        cmp      CX, 1        ;Condicion que se acabo el segmento
        je       incEBX       ;Salta para agregar la b y un espacio y aumentar el puntero
        mov      DX, AX       ;Guarda AX para no perderlo en la resta
        add      AL, 128      ;Suma el valor de AL con 128 = 1000 0000 el cual funciona como mascara para el bit mas significativo
        jc       imprimir1    ;Si el bit mas significativo es un 1 salta por el carry a  imprimir un 1
        mov      AX, DX       ;Retorna el valor actual de AX
        shl      AL, 1        ;Realiza un corrimiento hacia la izquierda para quitar el bit evaluado
        PutCh    '0'          ;Imprime un 0 porque el bit mas significativo era un 0
        loop     celdaMemoria ;repite
      
      incEBX:
        ;PutCh 'b'             ;imprime una b al final del numero
        PutCh 32              ;imprime un espacio
        inc EBX               ;incrementa el puntero
        jmp movimiento        ;repite todo
               
     imprimir1:               ;rutina encargada de imprimir un 1, porque el bit mas significativo era un 1
        mov     AX, DX        ;retorna AX
        shl     AL, 1         ;Realiza un corrimiento hacia la izquierda para quitar el bit evaluado
        PutCh   '1'           ;imprime un 1
        loop    celdaMemoria  ;repite 

program:
    nwln
    PutStr  prompt1_msg
    GetLInt [number1]

    PutStr  prompt2_msg
    GetLInt [number2]    
    
    mov EAX,[number1]
    add EAX,[number2]
    mov [sum],EAX

    jno no_overflow
    PutStr error_msg
    nwln
    jmp done

no_overflow:
    PutStr sum_msg
    PutLInt [sum]
    nwln
    
done:
    .EXIT

