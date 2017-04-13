org 0x500; 
jmp 0x000: start


str1 db 'Loading structures for the kernel',0
str2 db 'Setting up protected mode', 0
str3 db 'Loading kernel in memory', 0
str4 db 'Running kernel', 0
dot db '.', 0
finalDot db '.', 10, 13, 0

printString: 
;; Printa a string que esta em si    
	
	lodsb
	cmp al, 0
	je exit

	mov ah, 0xe
	int 10h	

	mov dx, 100;tempo do delay
	call delay 
	
	jmp printString
	
ret

delay: 
;; Função que aplica um delay(improvisado) baseado no valor de dx
	mov bp, dx
	back:
	dec bp
	nop
	jnz back
	dec dx
	cmp dx,0    
	jnz back
ret

printDots:
;; Printa os pontos das reticências
	mov cx, 2

	for:
		mov si, dot
		call printString
		mov dx, 600
		call delay
	dec cx
	cmp cx, 0
	jne for

	mov dx, 1200
	call delay
	mov si, finalDot
	call printString
	
ret


limpaTela:
;; Limpa a tela dos caracteres colocados pela BIOS
	; Set the cursor to top left-most corner of screen
	mov dx, 0 
    mov bh, 0      
    mov ah, 0x2
    int 0x10

    ; print 2000 blanck chars to clean  
    mov cx, 2000 
    mov bh, 0
    mov al, 0x20 ; blank char
    mov ah, 0x9
    int 0x10
    
    ;Reset cursor to top left-most corner of screen
    mov dx, 0 
    mov bh, 0      
    mov ah, 0x2
    int 0x10
ret

start:
	mov bl, 10 ; Seta cor dos caracteres para verde
	call limpaTela
	
	mov si, str1
	call printString
	call printDots

	mov si, str2
	call printString
	call printDots

	mov si, str3
	call printString
	call printDots

	mov si, str4
	call printString
	call printDots

times 510-($-$$) db 0		; preenche o resto do setor com zeros 
dw 0xaa55					; coloca a assinatura de boot no final
							; do setor (x86 : little endian)


