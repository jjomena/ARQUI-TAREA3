;Nombre:                        -
;
;           Objectivo: 
;                   
;           Entrada:
;           Salida: 
%include "io.mac"

.UDATA
;sin uniciar

	
.DATA
;definicion de parametros 
init          db 'Inicio',0
name_msg      db 'Please enter your name: ',0
query_msg     db 'How many times to repeat welcome message? ',0
confirm_msg1  db 'Repeat welcome message ',0
confirm_msg2  db ' times? (y/n) ',0 
welcome_msg   db 'welcome to Assembly Language Programming ',0
fin  db '$'

.CODE
        .STARTUP
      
      moverPuntero:
        mov      EBX, init    ;mueve el puntero al inicio del segmento de datos
      
      movimiento:
        sub      ECX, ECX     ;Limpia ECX
        mov      CX, 9        ;Contador para que imprima los 8 bits juntos
        mov      AL, [EBX]    ;Le el valor de la direccion que apunta EBX
        cmp      Al, '$'      ;Condicion de parada
        je       salir        ;Salir
        
            
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
   
      salir:
              nwln 
              .EXIT
