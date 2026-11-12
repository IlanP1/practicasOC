%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a
%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro

%macro WHILE 6
    push ecx
    push edx
    push eax
    mov edx,%2
    mov ecx,%1
%6  cmp ecx,edx
    %3 .%5
    %4
    jmp %6 
.%5 pop eax 
    pop edx
    pop ecx
%endmacro

%macro CUERPOMAX 0
    push eax
    push edx
    mov eax,dword[ebp-4]
    mov edx,dword[ebx+ecx*4]
    cmp edx,eax
    jg .cambiarMax
    jmp .sig2

.cambiarMax:
    mov dword[ebp-4],edx
.sig2:
    inc ecx
    pop edx
    pop eax
%endmacro

%macro CUERPOMIN 0
    push eax
    push edx
    mov eax,dword[ebp-4]
    mov edx,dword[ebx+ecx*4]
    cmp edx,eax
    jl .cambiarMin
    jmp .sig3

.cambiarMin:
    mov dword[ebp-4],edx
.sig3:
    inc ecx
    pop edx
    pop eax
%endmacro

%macro CUERPOSUMATORIA 0
    push eax
    push edx
    mov eax,dword[ebp-4]
    mov edx,dword[ebx+ecx*4]
    add eax,edx
    mov dword[ebp-4],eax
    inc ecx
    pop edx
    pop eax
%endmacro

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
    global _minimo  
    global _maximo
    global _sumatoria
	
	
_startd:                

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
	
	_minimo:
		PROTOENTRADA
            sub esp,4
            push ebx
            push edx
            push ecx
            push esi
            mov ebx,dword[ebp+8];arreglo
            mov edx,dword[ebx];arreglo[0]
            mov ecx,dword[ebp+12];len
            mov dword[ebp-4],edx;maximo
            mov esi,0;cont
            WHILE esi,ecx,jge,CUERPOMIN,finalMin,cicloMin
            pop esi
            pop ecx
            pop edx
            pop ebx
            mov eax,[ebp-4]
            add esp,4
            PROTOSALIDA
            ret



        _maximo:
            PROTOENTRADA
            sub esp,4
            push ebx
            push edx
            push ecx
            push esi
            mov ebx,dword[ebp+8];arreglo
            mov edx,dword[ebx];arreglo[0]
            mov ecx,dword[ebp+12];len
            mov dword[ebp-4],edx;maximo
            mov esi,0;cont
            WHILE esi,ecx,jge,CUERPOMAX,finalMax,cicloMax
            pop esi
            pop ecx
            pop edx
            pop ebx
            mov eax,[ebp-4]
            add esp,4
            PROTOSALIDA
            ret

        _sumatoria:
            PROTOENTRADA
            sub esp,4
            push ebx
            push edx
            push ecx
            push esi
            mov ebx,dword[ebp+8];arreglo
            mov edx,dword[ebx];arreglo[0]
            mov ecx,dword[ebp+12];len
            mov dword[ebp-4],0;resultado
            mov esi,0;cont
            WHILE esi,ecx,jge,CUERPOSUMATORIA,finalSum,cicloSum
            pop esi
            pop ecx
            pop edx
            pop ebx
            mov eax,[ebp-4]
            add esp,4
            PROTOSALIDA
            ret




section	.data
    msg1 db  'Hola mundo',0xa,0 
    msg2 db  'OC',0xa,0 
    msg3 db  'Practica 9',0xa,0 
    x db 1
    y db 2