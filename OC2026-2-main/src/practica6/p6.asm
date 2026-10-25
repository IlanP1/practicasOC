%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .data
    bskey equ 0x7F
    lencadena equ 255
    ln equ 0x0A
    lim dd 254
    nline db ln,0
    msg1 db ln,'Captura: ', 0
    msg2 db ln,'Cadena: ', 0
    
section .bss
    cadena resb lencadena

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
   
    ; --- IMPRIMIR CADENA  ---
    mov edx, msg1        
    call puts   
    mov edx,cadena
    call captura  
    mov edx,msg2    
    call puts
    mov edx, cadena
    call puts 

    mov edx, cadena
    call mayusculas
    mov edx,msg2    
    call puts
    mov edx, cadena
    call puts

    mov edx, cadena
    call minusculas
    mov edx,msg2    
    call puts
    mov edx, cadena
    call puts

    jmp .fin_programa 
    
    
    ; --- FIN DE PROGRAMA ---
    .fin_programa: 
        mov edx, nline    
        call puts     
        call puts     
        mov eax, 1            ; Llamada sys_exit
	    xor ebx, ebx          ; return 0
        int 0x80              ; Fin de programa

   
   


    captura:
            push ax
            push edx
            mov cx,[lim]
    .inic   call getch
            cmp al, ln
            je .fin
            cmp al, bskey
            jne .sig
            call borrar
            jmp .inic
    .sig:   call putchar
            mov [edx],al
            inc edx
            loop .inic
    .fin    mov al,0
            mov[edx],al
            call putchar
            pop edx
            pop ax
            ret

    borrar:
            push ax
            cmp cx,[lim]
            je .limite 
            mov al,0x8
            call putchar    
            mov al,' '
            call putchar
            dec edx
            mov [edx],al
            mov al,0x8
            call putchar  
            inc cx
 .limite    pop ax
            ret 

            mayusculas:
            push edx
    .inic2  cmp byte[edx],0
            je .fin2
            cmp byte [edx],97
            jnae .sig2
            cmp byte [edx],122
            ja .sig2
            sub byte [edx],32
    .sig2   inc edx
            jmp .inic2
    .fin2   pop edx
            ret 

            minusculas:
            push edx
    .inic3  cmp byte[edx],0
            je .fin3
            cmp byte [edx],65
            jnae .sig3
            cmp byte [edx],90
            ja .sig3
            add byte [edx],32
    .sig3   inc edx
            jmp .inic3
    .fin3   pop edx
            ret