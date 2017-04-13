org 0x500; 
jmp 0x000: start

%macro printString 1
     mov   si, %1
      
	print:
		lodsb
		cmp al, 0
		je exit

		mov ah, 0xe
		int 10h	

		jmp print
	exit:
%endmacro

strInicial db 'Ola meus beberes', 0

start:
	printString strInicial

times 510-($-$$) db 0		; preenche o resto do setor com zeros 
dw 0xaa55					; coloca a assinatura de boot no final
							; do setor (x86 : little endian)


