%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos

section .data
    bskey equ 0x7F
    lencadena equ 64
    ln equ 0x0A
    lim dd 63
    negativo dd 0
    resultado dd 0
    decima dd 1
    cant dd cant 0
    nline db ln,0
    msg1 db ln,'Cadena = ', 0
    msg2 db ln,'Salida = ', 0
   
   
section .bss
    cadena resb lencadena

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
   
    ; --- IMPRIMIR CADENA  ---
    mov edx, msg1        
    call puts   
    mov esi,cadena
    call captura  
    mov edx,msg2    
    call puts
    mov esi,cadena
    call ATOI
    add dword[resultado],20
    call ITOA
    mov edx,cadena
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
            push esi
            mov cx,[lim]
    .inic   call getch
            cmp al, ln
            je .fin
            cmp al, bskey
            jne .sig
            call borrar
            jmp .inic
    .sig:   call putchar
            mov [esi],al
            inc esi
            loop .inic
    .fin    mov al,0
            mov [esi],al
            call putchar
            pop esi
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
            dec esi
            mov [esi],al
            mov al,0x8
            call putchar  
            inc cx
 .limite    pop ax
            ret 

    ATOI:        
            push eax
            push ecx
            push edx
            push esi
.inicio     mov eax,[esi]
            cmp eax,'-'
            je .ngtv
            cmp eax,0
            je .final
            cmp eax,48
            jb .sig2
            cmp eax,57
            ja .sig2
            jmp .digitos
.ngtv       cmp dword[negativo],1
            jne .negar
            jmp .sig2
.negar      mov dword[negativo],1 
            jmp .sig2

.sig2       inc esi
            jmp .inicio

.digitos    push eax
            inc dword[cant]
            inc esi
            mov eax,[esi]
            cmp eax,48
            jb .convatoi
            cmp eax,57
            ja .convatoi
            jmp .digitos
.convatoi   mov ecx,[cant]
.inicio2    pop eax
            sub eax,48
            mul dword[decima]
            add [resultado],eax
            mov eax,10
            mul dword[decima]
            mov dword[decima],eax
            loop .inicio2
            cmp dword[negativo],0
            jne .multneg
            jmp .final
.multneg    mov eax,-1
            mul dword[resultado]
            mov dword[resultado],eax
            jmp .final 

.final      pop esi
            pop edx
            pop ecx
            pop eax
            ret

        ITOA:
                mov dword[decima],10
                mov dword[cant],0
                push eax
                push edx
                push ebx
                mov eax,[resultado]
                
                
.convertir      div dword[decima]
                add edx,'0'
                push edx
                inc dword[cant]
                cmp eax,0
                jne .convertir

                mov eax,[resultado]
                cmp dword[resultado],0
                jb .negativ
                jmp .pasarC
.negativ        mov ebx,'-'
                push ebx
                inc dword[cant]
                jmp .pasarC
                

.pasarC         mov ecx,[cant]
                mov edx,cadena
.convert        pop eax
                mov byte[edx],al
                inc edx
                loop .convert
                jmp .fin2



.fin2           pop ebx
                pop edx
                pop eax
                ret
                
                


