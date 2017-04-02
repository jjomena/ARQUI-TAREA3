;TEC,Cartago,Ing Computacion
;I Semestre 2017
;IC-3101 Arquitectura de Computadores 
;AUTORES: Marlon Reyes Montero
;         Joaquín Mena Montero
;PROFESOR: Esteban Arias Mendez
;RESUMEN DEL PROGROMA: Convertir Cifras de texto a números y viceversa y verificar que sean caracteres validos,
;                      Si el texto ingresado son solo numeros, retorna un valor entero
;                      En caso de recibir caracteres que combinan letras con números o solo letras o simbolos
;                      , debera escribir el valor recibido en codigo hexadeciamales y letras en mayuscula
;                     
;                     
;
%include "io.mac"
	
.DATA
;definicion de parametros
msg_bien db "Bienvenido por favor ingrese la cadena de texto: ",0
msg_sum  db "Solo se introdujeron solo numeros por lo tanto el resultado es: ",0
msg_comb db "La cadena de texto esta combinada y el resultado es el siguiente:",0
msg_car  db "El caracter ingresado no es valido!!!!!",0 
print1    db "numero",0
print2    db "minus",0
print3    db "mayus",0
print4    db "caracte",0
hex_table      db  "0123456789ABCDEF"

.UDATA
;sin uniciar
cadena   resb  40
cont     resb  10

.CODE
        .STARTUP
        PutStr msg_bien    ;Envia el msg de bienvenida
        GetStr cadena,40   ;Obtiene la cadena de texto
        mov    EBX, cadena ;le mueve la direccion de cadena
      
      determinar:          ;Determina si es unicamente son numeros, o numeros, letras,caracteres
        mov  AL,[EBX]      ;Le mueve el caracter al AL
        cmp  AL, 0         ;Compara con 0 a ver si se acabo el string
        je   movedor       ;Salta a onlynumeros porque solo numeros hay en el string
        cmp  AL, 48        ;si es menor a 47 no es numero
        jl   movedor1      ;salta a donde hay numeros, letras, caracteres
        cmp  AL, 57        ;si es mayor a 58 no es un numero
        jg   movedor1      ;salta a donde hay numeros,letras, caracteres
        inc  EBX            ;aumenta BX para moversen en la direccion del string
        jmp determinar     ;repite
      
      movedor:             ;Para aux para mover una direccion  
        sub  ECX, ECX
        mov  ECX, 0
        mov  EBX, cadena   ;mueve la direccion a BX para imprimir los numeros
        
      onlynumeros: 
        mov  AL,[EBX]      ;Mueve el digito a AL
        cmp  AL, 0         ;Compara con 0 a ver si termino
        je   aux           ;Salta a salir para terminar el programa
        sub  AL, 48        ;Resta 48 para obtener el valor en entero
        Push EAX           ;Envia en caracter a la pila
        inc  ECX           ;Cantidad de numeros que tiene el string
        inc  EBX           ;Incrementa el bx para moverse en la direccion
        jmp  onlynumeros   ;repite
      
      aux:
        sub  EAX, EAX        ;limpio el registro EAX
        sub  EDX, EDX        ;LImpio el registro EDX
        sub  EBX, EBX        ;Limpio el registro EBX
        mov  EAX, 1          ;Muevo a EAX un 1
      
      formNumero:
        pop  EDX               ;Saco de la pila el primer numero
        cmp  ECX, 0            ;condicion de parada
        je imprimirnum        ;Salta donde se imprime el numero
        push EAX              ;Guarda en la pila la potencia de 10
        mul  EDX              ;multiplica el numero por su potencia de 10
        add  EBX, EAX         ;Suma el resultado
        pop  EAX              ;Saca de la pila la potencia de 10
        mov  EDX, 10          ;Mueve a EDX un 10
        mul  EDX              ;Multiplica por EDX para aumentar la potencia de 10
        dec  ECX              ;Decrementa el contador
        jmp  formNumero
    
      imprimirnum:
        PutStr  msg_sum
        PutLInt EBX           ;Imprime el resultado
        jmp salir
      
      movedor1:             ;Para aux para mover una direccion  
        mov  EBX, cadena   ;mueve la direccion a BX para imprimir los numeros
        PutStr msg_comb
        
        
      combinado:           ;Combinacion de letras numeros, caracteres, letras
        mov  AL,[EBX]      ;muevo AL el caracter
        cmp  Al, 0         ;condicion de parada 
        je salir           ;salir
        cmp AL, 47         ;limite inferior de numeros
        jg  at1        
        jmp caracter       ;salta a caracter
        
      at1:
        cmp  AL, 58        ;limite superior de numero y inferior de caracter
        jl numero          ;salta a numero
        cmp  AL, 59       
        jg   at2
        
      at2:
        cmp AL, 65         ;limite superior de caracter y inferior de mayusculas
        JL caracter        ;salta a caracter

      at3:
        cmp AL, 91         ;Limite superior de mayusculas y inferior de caracter
        jl  mayuscula      ;salta a mayuscula

      at4:
        cmp AL,97          ;Limite superior de caracter y inferior de minusculas
        jl caracter

      at5:
        cmp AL, 123        ;limite superior de minusculas y siguien caracteres
        jl minuscula       ;salta a minusculas
        jmp caracter
        
     numero:
        PutCh AL           ;Imprime el valor
        inc BX
        jmp combinado
     
     minuscula:
        PutCh 32
        sub AL, 'a'-'A'     ;Resta para obtener la mayuscula
        PutCh AL
        PutCh 32
        inc BX
        jmp combinado
        
     mayuscula:             ;Como es mayuscula la deja normal
        PutCh 32
        PutCh AL
        PutCh 32
        inc BX
        jmp combinado
        
     caracter:
        PutCh 32
        mov     AH,AL        ; Guarda el valor de AL en AH
        push    EBX          ;Guarda en la pila la direccion porque BX se va a usar
        mov     EBX,hex_table ;Mueve a EBX la variable hexa_table
        shr     AL,4         ; Mueve 4 bits de la parte alta a la baja
        xlatb                ; Remplaza el AL por el digito Hexadecimal
        PutCh   AL           ; Escribe el primer digito Hexadecimal
        mov     AL,AH        ; Restaura el valor de AL
        and     AL,0FH       ; Pone ceros en la parte bajo por la mascara de 0s
        xlatb
        PutCh   AL           ; Escribe el ditigo hexadecimal
        PutCh 32
        pop EBX              ; Saca el puntero de la pila
        inc EBX
        jmp combinado
     
      salir:
              nwln 
              .EXIT
