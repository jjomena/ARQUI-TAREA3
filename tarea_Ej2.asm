;TEC,Cartago,Ing Computacion
;I Semestre 2017
;IC-3101 Arquitectura de Computadores 
;AUTORES: Marlon Reyes Montero
;         Joaquín Mena Montero
;PROFESOR: Esteban Arias Mendez
;RESUMEN DEL PROGROMA: El usuario ingresa diez números, el sistema verifica que no ocurra overflow
;                      en caso contrario se muestra un mensaje de error y pregunta si desea intentar
;                      de nuevo
;
%include "io.mac"
	
.DATA
;definicion de parametros
input_prompt db  "Porfavor, Ingrese el primer número: ",0
end_msg      db  "Ingrese un número, o un 0 para terminar el programa: ",0
sum_msg      db  "La suma de los números es : ",0
ove_msg      db  "Se a producido un error!!",0
rei_msg      db  "Desea intentarlo de nuevo s/n ",0
ter_msg      db  "Se a terminado el programa",0

.UDATA
;sin uniciar

.CODE
        .STARTUP
        ;PutStr input_prompt  ; prompt for input numbers
	mov ECX, 10
	sub EAX, EAX

   read_loop:
	PutStr  end_msg
	GetLInt EDX
	cmp     EDX, 0
	je      reading_done  ; if yes, stop number
	add     EAX,EDX
	jo      overflow      ;bandera de
	cmp     ECX, 1
	je      reading_done

   skip_msg:
	loop read_loop

   overflow:
	PutStr  ove_msg
	nwln 
	mov     ECX, 10
	sub     EAX, EAX
  	PutStr  rei_msg
	GetCh  	BL
	cmp     BL, 'S'
	je      read_loop
	cmp     BL, 's'
	je      read_loop
	PutStr  ter_msg

   reading_done:
	PutStr sum_msg
	PutLInt EAX
	nwln 
        .EXIT
