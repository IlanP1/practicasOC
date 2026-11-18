build: 

	nasm -f elf p10.asm
	ld -m elf_i386 p10.o -o ../../bin/practica10.exe ../../lib/libpc_io.a	
	
	gcc -m32 -c main.c
	gcc -m32 p10.o main.o -L ../../lib -lpc_io -no-pie -z noexecstack -o ../../bin/practica10c.exe
run:
	./../../bin/practica10.exe
runc:
	./../../bin/practica10c.exe