%include "io.mac"

.DATA
prompt1_msg db 'Enter first number ',0
prompt2_msg db 'Enter Second Number ',0
sum_msg     db 'Sum is: ',0
error_msg   db 'Overflow has occurred!',0

.UDATA
number1 resd 1
number2 resd 1
sum     resd 1



.CODE
    .STARTUP
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

