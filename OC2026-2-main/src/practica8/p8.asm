extern canonical_off
extern canonical_on

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
    mov eax,[lim]
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
    
    mov edx,nline
    call puts
    mov edx,cadena
    call getche
    mov byte[edx],al
    call getche
    mov byte[edx+1],al
    mov edx,msg2
    call puts
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


    putchar:
        push ebx
        push ecx
        push edx
        push eax
        mov eax, 4
        mov ebx, 1
        mov ecx, esp
        mov edx, 1
        int 0x80
        pop eax
        pop edx
        pop ecx
        pop ebx
        ret

    puts:
        push edx
        push eax
.inicio cmp byte[edx],0
        je .final
        mov al,[edx]
        call putchar
        inc edx
        jmp .inicio
.final  pop eax
        pop edx
        ret 

    getch:
        call canonical_off
        push ebx
        push ecx
        push edx
        push eax
        mov eax, 3 
        mov ebx, 0
        mov ecx, esp
        mov edx, 1 
        int 0x80 
        pop eax
        pop edx
        pop ecx
        pop ebx
        ;CODIGO
        call canonical_on
        ret

    getche:
        call canonical_off
        push ebx
        push ecx
        push edx
        push eax
        mov eax, 3 
        mov ebx, 0
        mov ecx, esp
        mov edx, 1 
        int 0x80 
        pop eax
        pop edx
        pop ecx
        pop ebx
        call putchar
        call canonical_on
        ret

        captura:
            push eax
            push edx
            push ecx
            push ebx
            mov ebx,eax
            mov ecx,eax
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
            pop ebx
            pop ecx
            pop edx
            pop eax
            ret

    borrar:
            push eax
            cmp ecx,ebx
            je .limite 
            mov al,0x8
            call putchar    
            mov al,' '
            call putchar
            dec edx
            mov [edx],al
            mov al,0x8
            call putchar  
            inc ecx
 .limite    pop eax
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