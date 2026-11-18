%macro PROTOENTRADA 0
	push ebp
	mov ebp,esp
%endmacro

%macro PROTOSALIDA 0
	mov esp,ebp
	pop ebp
%endmacro


section	.text
    global _setbit   
    global _getbit  
	
    _setbit:
        PROTOENTRADA
		PROTOSALIDA
		ret

    _getbit:
        PROTOENTRADA
		PROTOSALIDA
		ret

    
