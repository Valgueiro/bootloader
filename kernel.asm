;Jogo da Velha: ULTRA
org 0x7E00
jmp 0x0000:start

titulo db 'Jogo da Velha', 13, 10, $
ultra db 'ULTRA', 13, 10, $
iniciar db ' Iniciar Jogo', 13, 10, $
guia db ' Guia', 13, 10, $

;Regras:
introducao db 'O jogo e similar ao Jogo da Velha classico, mas os jogadores agora possuem poderes! Conquiste pontos para conjurar suas habilidades e venca!', 13, 10, $


start:
	; Modo vídeo.
	mov ah, 0
	mov al, 12h
	int 10h

	call telaInicial

	jmp exit

telaInicial:

	;Colorindo a tela de cinza claro.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 7   
	int 10h 

	;Setando o cursor.
	mov ah, 02h
	mov bh, 00h
	mov dh, 07h
	mov dl, 20h
	int 10h

	mov si, titulo
	printTitulo:
		lodsb

		mov ah, 0xe
		mov bh, 0
		mov bl, 0xf
		int 10h

		call delay

		cmp al, 13
		jne printTitulo

	call animacaoColorida

	call menu	
			
ret

menu:
	mov ah, 02h
	mov bh, 00h
	mov dh, 10h
	mov dl, 10h
	int 10h

	mov ah, 0xe
	mov al, '>'
	mov bh, 0
	mov bl, 0xf
	int 10h

	mov si, iniciar
	call printString

	mov ah, 02h
	mov bh, 00h
	mov dh, 12h
	mov dl, 11h
	int 10h

	mov si, guia
	call printString

	mov cx, 1 ;CX contém a posição da seta.
	call mudancaSeta

	
ret

mudancaSeta:
	
	mov ah, 0
	int 16h

	cmp al, 's'
	je Baixo

	cmp al, 'w'
	je Cima

	cmp al, 13
	jne mudancaSeta

	ret

	Baixo:
		cmp cx, 2
		je Cima

		;Os 4 grupos de instruções abaixo deslocam a seta para baixo.

		mov ah, 02h
		mov bh, 00h
		mov dh, 10h
		mov dl, 10h
		int 10h

		mov ah, 0xe
		mov al, 0
		mov bh, 0
		mov bl, 0xf
		int 10h

		mov ah, 02h
		mov bh, 00h
		mov dh, 12h
		mov dl, 10h
		int 10h

		mov ah, 0xe
		mov al, '>'
		mov bh, 0
		mov bl, 0xf
		int 10h

		mov cx, 2
		jmp mudancaSeta

	Cima:
		cmp cx, 1
		je Baixo

		;Os 4 grupos de instruções abaixo deslocam a seta para cima.

		mov ah, 02h
		mov bh, 00h
		mov dh, 10h
		mov dl, 10h
		int 10h

		mov ah, 0xe
		mov al, '>'
		mov bh, 0
		mov bl, 0xf
		int 10h

		mov ah, 02h
		mov bh, 00h
		mov dh, 12h
		mov dl, 10h
		int 10h

		mov ah, 0xe
		mov al, 0
		mov bh, 0
		mov bl, 0xf
		int 10h

		mov cx, 1
		jmp mudancaSeta

animacaoColorida:

	;Colorindo a tela de amarelo.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 0xE   
	int 10h	

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

	mov bl, 1
	mov si, ultra
	call printUltra
	call delay

	;Colorindo a tela de azul.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 1   
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

	mov bl, 2
	mov si, ultra
	call printUltra
	call delay

	;Colorindo a tela de verde.
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 2   
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

	mov bl, 4
	mov si, ultra
	call printUltra
	call delay

	;Colorindo a tela de vermelho (fim).
	mov ah, 0xb  
	mov bh, 0     
	mov bl, 4   
	int 10h

	mov ah, 02h
	mov bh, 00h
	mov dh, 08h
	mov dl, 24h
	int 10h

	mov bl, 0xe
	mov si, ultra
	call printUltra
ret

printUltra:
	lodsb

	mov ah, 0xe
	mov bh, 0
	int 10h

	cmp al, 13
	jne printUltra
ret

printString:
	lodsb

	mov ah, 0xe
	mov bh, 0
	mov bl, 0xf
	int 10h

	cmp al, 13
	jne printString
ret

delay:
	mov bp, 1000
	mov dx, 750
	delay2:
		dec bp
		nop
		jnz delay2
	dec dx
	jnz delay2

ret


exit:
;times 1022 -($-$$) db 0
;dw 0xaa55

