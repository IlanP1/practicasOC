section .data

section .bss

section .text

global _start

    _start:
    
        mov eax,3
        mov ebx,0
        mov ecx,msg1+1
        mov edx,1

        miputchar:
            mov ebx,1
            mov ecx,esp
            mov edx,1
            int 0x80
            pop eax
            ret