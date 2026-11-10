%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

%macro FOR 4
    push ecx
    push edx
    mov ecx,%1
    mov edx,%2
    .%4:
        call %3
    loop .%4
    pop edx
    pop ecx
%endmacro

section	.text
	global _startd       ;referencia para inicio de programa
    global _imprimir     
	
	
_startd:                
    push msg1       ;SEGUNDO PARAMETRO
    push msg2       ;PRIMER PARAMETRO
    call _imprimir  ;_imprimir(msg2,msg1)
    add esp, 8      ;LIMPIA PARAMETROS DE LA FUNCION DE LA PILA

    
    push msg2       ;SEGUNDO PARAMETRO
    push msg1       ;PRIMER PARAMETRO
    call _imprimir  ;_imprimir(msg1,msg2)
    add esp, 8      ;LIMPIA PARAMETROS DE LA FUNCION DE LA PILA
   
    ;FOR 3,msg1,puts,l1    ;LLAMADA/EXPANSION DE MACRO
    ;FOR 2,msg2,puts,l2    ;LLAMADA/EXPANSION DE MACRO
    
	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	int	0x80        	; llamada al sistema - fin de programa

    _imprimir:
        push ebp
        mov ebp , esp
        sub esp, 4          ; Reservar 4 bytes en la pila para la variable local [ebp-4]
             
        mov dword[ebp-4],msg3 ;VARIABLE LOCAL

        mov edx,[ebp-4]    ;CARGAR VARIABLE LOCAL
	    call puts
        
        mov edx,[ebp+8]    ;PRIMER PARAMETRO
	    call puts
        mov edx,[ebp+12]   ;SEGUNDO PARAMETRO
	    call puts
        mov esp, ebp       ;Restaurar el puntero de la pila (libera el espacio reservado para las variables locales)
        pop ebp
        ret

    

section	.data
    msg1 db  'Hola mundo',0xa,0 
    msg2 db  'OC',0xa,0 
    msg3 db  'Practica 9',0xa,0 
    x db 1
    y db 2