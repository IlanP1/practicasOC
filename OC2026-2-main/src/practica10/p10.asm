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

section .text
    global _startd
    global set_bit
    global get_bit

_startd:

set_bit:
    PROTOENTRADA
    mov ebx,dword[ebp+8]
    movzx ecx,byte[ebp+12]
    mov eax,1
    shl eax,cl
    or [ebx],al
    PROTOSALIDA
    ret



get_bit:
    PROTOENTRADA
    movzx edx,byte[ebp+8]
    movzx ecx,byte[ebp+12]
    mov eax,1
    shl eax,cl
    and eax,edx
    PROTOSALIDA
    ret