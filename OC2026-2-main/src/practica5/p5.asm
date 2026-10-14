%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
    ; --- IMPRIMIR CADENA COMPLETA ---
    mov edx, msg          ; edx = dirección de la cadena msg
    call puts             ; imprime cadena
    mov byte[msg],'Z'     ; a
    mov edx, msg  
    call puts
    mov edx, msg+23      ; b
    mov byte[edx],'X'  
    mov edx,msg
    call puts
    mov byte[edx+26],'@'  ;c
    mov edx,msg
    call puts
    mov esi, 25           ;d
    mov byte[edx+esi],'Z'
    mov edx,msg
    call puts
    mov esi, 10            ;e
    mov byte[edx+esi+5],'P'
    mov edx,msg
    call puts
    mov edx,msg+1           ;f
    mov esi,9
    mov byte[edx+esi*2],'%'
    mov edx,msg
    call puts
    ; --- FIN DE PROGRAMA ---
    mov eax, 1            ; Llamada sys_exit
	xor ebx, ebx          ; return 0
    int 0x80              ; Fin de programa

section .data
    msg db 'abcdefghijklmnopqrstuvwxyz0123456789', 0xa, 0
    salto db 0xa