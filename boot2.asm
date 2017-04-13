org 0x500; 
jmp 0x000: start

printString:    
	print:
		lodsb
		cmp al, 0
		je exit

		mov ah, 0xe
		int 10h	

		jmp print
	exit:
ret

start:
	mov si, str1
	call printString

	mov si, str2
	call printString
	
	mov si, str3
	call printString
	
	mov si, str4
	call printString


str1 db 'Loading structures for the kernel...', 10, 13, 0
str2 db 'Setting up protected mode...', 10, 13, 0
str3 db 'Loading kernel in memory...', 10 , 13, 0
str4 db 'Running kernel...', 10, 13, 0

times 510-($-$$) db 0		; preenche o resto do setor com zeros 
dw 0xaa55					; coloca a assinatura de boot no final
							; do setor (x86 : little endian)


