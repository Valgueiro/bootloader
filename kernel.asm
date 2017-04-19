;Jogo

org 0x8600
jmp 0x0000:start

;Tabuleiro
pos1 db '-'
pos2 db '-'
pos3 db '-'
pos4 db '-'
pos5 db '-'
pos6 db '-'
pos7 db '-'
pos8 db '-'
pos9 db '-'

;Tabuleiro há 3 turnos atrás.
pos1A db '-'
pos2A db '-'
pos3A db '-'
pos4A db '-'
pos5A db '-'
pos6A db '-'
pos7A db '-'
pos8A db '-'
pos9A db '-'

turno db 1
pontos1 db 0
pontos2 db 0

Hacking db 'Iniciando o hack!', 13
Recalling db 'Voce ja sentiu a sensacao de dejavu?', 13
EMPing db 'Apagando as luzes!', 13

start:

	xor ax, ax
	mov ds, ax

	;Modo vídeo.
	mov ah, 0
	mov al, 12h
	int 10h

	mov ah, 0xb
	mov bh, 0
	mov bl, 7
	int 10h
	
	call printTabuleiro

	turno1:
		mov ah, 0
		int 16h

		cmp al, '1'
		je put1

		cmp al, '2'
		je put2

		cmp al, '3'
		je put3

		cmp al, '4'
		je put4

		cmp al, '5'
		je put5

		cmp al, '6'
		je put6

		cmp al, '7'
		je put7
	
		cmp al, '8'
		je put8

		cmp al, '9'
		je put9

		cmp al, 'h'
		je Hack

		cmp al, 'j'
		je Recall

		cmp al, 'k'
		je EMP


	put1: 
		mov al, '-'
		cmp al, byte[pos1]
		jne turno1 ;Posição já ocupada.
		
		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 7
		mov dl, 25
		int 10h

		call TURNO
		mov byte[pos1], al
		call PUTCHAR
	
		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta1

		cmp al, byte[pos4]
		je acrescenta1

		cmp al, byte[pos2]
		jne termino

		acrescenta1: call ACRESCENTA

	jmp termino		
	
	put2: 
		mov al, '-'
		cmp al, byte[pos2]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 7
		mov dl, 37
		int 10h
		
		call TURNO
		mov byte[pos2], al
		call PUTCHAR	

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta2

		cmp al, byte[pos3]
		je acrescenta2

		cmp al, byte[pos4]
		je acrescenta2

		cmp al, byte[pos6]
		je acrescenta2

		cmp al, byte[pos1]
		jne termino

		acrescenta2: call ACRESCENTA

	jmp termino		
	
	put3: 
		mov al, '-'
		cmp al, byte[pos3]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 7
		mov dl, 49
		int 10h
		
		call TURNO
		mov byte[pos3], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta3

		cmp al, byte[pos6]
		je acrescenta3

		cmp al, byte[pos2]
		jne termino

		acrescenta3: call ACRESCENTA	

	jmp termino	

	put4: 
		mov al, '-'
		cmp al, byte[pos4]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 12
		mov dl, 25
		int 10h
		
		call TURNO
		mov byte[pos4], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta4

		cmp al, byte[pos1]
		je acrescenta4

		cmp al, byte[pos2]
		je acrescenta4

		cmp al, byte[pos8]
		je acrescenta4

		cmp al, byte[pos7]
		jne termino

		acrescenta4: call ACRESCENTA	

	jmp termino	
	
	put5: 
		mov al, '-'
		cmp al, byte[pos5]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 12
		mov dl, 37
		int 10h
		
		call TURNO
		mov byte[pos5], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos1]
		je acrescenta5

		cmp al, byte[pos2]
		je acrescenta5

		cmp al, byte[pos3]
		je acrescenta5

		cmp al, byte[pos4]
		je acrescenta5

		cmp al, byte[pos6]
		je acrescenta5

		cmp al, byte[pos7]
		je acrescenta5

		cmp al, byte[pos8]
		je acrescenta5

		cmp al, byte[pos9]
		jne termino

		acrescenta5: call ACRESCENTA

	jmp termino		
	
	put6: 
		mov al, '-'
		cmp al, byte[pos6]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 12
		mov dl, 49
		int 10h
		
		call TURNO
		mov byte[pos6], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta6

		cmp al, byte[pos3]
		je acrescenta6

		cmp al, byte[pos2]
		je acrescenta6

		cmp al, byte[pos8]
		je acrescenta6

		cmp al, byte[pos9]
		jne termino

		acrescenta6: call ACRESCENTA
	
	jmp termino		
	
	put7: 
		mov al, '-'
		cmp al, byte[pos7]
		jne turno1
		
		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 17
		mov dl, 25
		int 10h
		
		call TURNO
		mov byte[pos7], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta7

		cmp al, byte[pos4]
		je acrescenta7

		cmp al, byte[pos8]
		jne termino

		acrescenta7: call ACRESCENTA

	jmp termino		
	
	put8:
		mov al, '-'
		cmp al, byte[pos8]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 17
		mov dl, 37
		int 10h
		
		call TURNO
		mov byte[pos8], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta8

		cmp al, byte[pos4]
		je acrescenta8

		cmp al, byte[pos7]
		je acrescenta8

		cmp al, byte[pos6]
		je acrescenta8

		cmp al, byte[pos9]
		jne termino

		acrescenta8: call ACRESCENTA

	jmp termino		
	
	put9:
		mov al, '-'
		cmp al, byte[pos9]
		jne turno1

		;Setando o cursor.
		mov ah, 02h
		mov bh, 00h
		mov dh, 17
		mov dl, 49
		int 10h
		
		call TURNO
		mov byte[pos9], al
		call PUTCHAR

		;Verificando adjacências:
		cmp al, byte[pos5]
		je acrescenta9

		cmp al, byte[pos6]
		je acrescenta9

		cmp al, byte[pos8]
		jne termino

		acrescenta9: call ACRESCENTA		
	
	termino:
 	
	call winCheck
	cmp dh, 1
	jne turno1
	
	call CURSORV
	call PUTCHAR
	jmp exit

	Hack:
		mov al, byte[turno]
		cmp al, 1 ; X conjurou.
		je xVerify
	
		;O conjurou.
		mov dl, byte[pontos2]
		sub dl, 1
		cmp dl, 0
		jl turno1 ; -O- não tem pelo menos 1 ponto para conjurar Hackear.

		jmp hackExec

		xVerify:
		mov dl, byte[pontos1]
		sub dl, 2
		cmp dl, 0
		jl turno1 ; -X- não tem pelo menos 2 pontos para conjurar Hackear.

		hackExec:

		;Atualizando os pontos.
		call atualizaPontos

		;Mudando a cor da tela.
		mov ah, 0xb
		mov bh, 0
		mov bl, 5
		int 10h
	
		;Setando o cursor;
		mov ah, 02h
		mov bh, 00h
		mov dh, 26
		mov dl, 29
		int 10h

		;Printando a frase.
		mov si, Hacking
		call printString

		;Algoritmo (não veja isso se não quiser perder a sensação de hacker!):

		;Minha ideia (be free to change):
		;Primeira coluna rotacionada para cima.
		;Segunda coluna rotacionada para baixo.
		;2 primeiras linhas deslocadas para a esquerda.
		;3ª linha deslocada para a direita.
		;9º elemento apagado.

		;falta implementar a função que atualiza o tabuleiro.
		

	 jmp termino
	Recall:
		mov al, byte[turno]
		cmp al, 1 ; X conjurou.
		je xVerify2
	
		; O conjurou.
		mov dl, byte[pontos2]
		sub dl, 2
		cmp dl, 0
		jl turno1 ; -O- não tem pelo menos 2 pontos para conjurar Retroceder.

		jmp recallExec

		xVerify2:
		mov dl, byte[pontos1]
		sub dl, 3
		cmp dl, 0
		jl turno1 ; -X- não tem pelo menos 3 pontos para conjurar Retroceder.

		recallExec:

		;Atualizando os pontos.
		call atualizaPontos

		;Mudando a cor da tela.
		mov ah, 0xb
		mov bh, 0
		mov bl, 3
		int 10h
	
		;Setando o cursor;
		mov ah, 02h
		mov bh, 00h
		mov dh, 26
		mov dl, 19
		int 10h		
		
		;Printando a frase.
		mov si, Recalling
		call printString

		;Retroceder: o tabuleiro volta ao seu estado três turnos atrás.
		;falta implementar um contador pra os turnos, aí é só colocar posx em posxA sempre a partir do 3º.
		;recall coloca posxA em posx para todas as peças e atualiza o tabuleiro.
		

	jmp termino

	EMP: 
		mov al, byte[turno]
		cmp al, 1 ; X conjurou.
		je xVerify3
	
		; O conjurou.
		mov dl, byte[pontos2]
		sub dl, 2
		cmp dl, 0
		jl turno1 ; -O- não tem pelo menos 2 pontos para conjurar Pulso Eletromagnético.

		jmp EMPExec

		xVerify3:
		mov dl, byte[pontos1]
		sub dl, 3
		cmp dl, 0
		jl turno1 ; -X- não tem pelo menos 3 pontos para conjurar Pulso Eletromagnético.

		EMPExec:

		;Atualizando os pontos.
		call atualizaPontos

		;Mudando a cor da tela.
		mov ah, 0xb
		mov bh, 0
		mov bl, 0
		int 10h
	
		;Setando o cursor;
		mov ah, 02h
		mov bh, 00h
		mov dh, 26
		mov dl, 29
		int 10h		
		
		;Printando a frase.
		mov si, EMPing
		call printString

		;Pulso Eletromagnético:
		;1º passo: a fronteira do tabuleiro "é apagada" (fica só invisível, mas o oponente pode colocar uma peça em qualquer lugar). 	
		;2º passo: as peças na fronteira são trocadas (X vira O, O vira X).
		;3º passo: as peças voltam a ser visíveis e o ritmo segue.
		;O 1º passo dura o próximo turno inteiro, então precisamos trocar o turno (chamar TURNO) e fazer uma chamada de turno1 aqui (colocando ret nele).

	call TURNO
	jmp termino 

atualizaPontos:
	cmp al, 1
	je xPontos

	mov byte[pontos2], dl
	ret

	xPontos:
	mov byte[pontos1], dl
ret

printString:
	lodsb

	call PUTCHAR

	cmp al, 13
	jne printString
ret

TURNO:
	mov al, 1
	cmp byte[turno], al
	je X

	mov al, 'O'
	mov byte[turno], 1
	ret

	X: mov al, 'X'
	mov byte[turno], 2
	ret

PUTCHAR:
	mov ah, 0xe
	mov bh, 0
	mov bl, 0xf
	int 10h
ret

ACRESCENTA:
	cmp al, 'X'
	je acrX

	inc byte[pontos2]
	ret

	acrX:
	inc byte[pontos1]
ret

CURSORV:	
	mov ah, 02h
	mov bh, 00h
	mov dh, 28
	mov dl, 37
	int 10h
ret
	
winCheck:

	mov ah, 02h
	mov bh, 00h
	mov dh, 28
	mov dl, 25
	int 10h

	mov al, byte[pontos1]
	add al, 48
	call PUTCHAR

	mov ah, 02h
	mov bh, 00h
	mov dh, 28
	mov dl, 49
	int 10h

	mov al, byte[pontos2]
	add al, 48
	call PUTCHAR
	
	linha1:
	mov al, byte[pos1]
	mov cl, byte[pos2]
	mov dl, byte[pos3]

	cmp al, '-'
	je linha2

	cmp al, cl
	jne linha2

	cmp al, dl
	jne linha2

	mov dh, 1
	ret

	linha2:
	mov al, byte[pos4]
	mov ah, byte[pos5]
	mov dl, byte[pos6]

	cmp al, '-'
	je linha3

	cmp al, ah
	jne linha3

	cmp al, dl
	jne linha3

	mov dh, 1
	ret

	linha3:
	mov al, byte[pos7]
	mov ah, byte[pos8]
	mov dl, byte[pos9]

	cmp al, '-'
	je col1

	cmp al, ah
	jne col1

	cmp al, dl
	jne col1

	mov dh, 1
	ret

	col1:
	mov al, byte[pos1]
	mov ah, byte[pos4]
	mov dl, byte[pos7]

	cmp al, '-'
	je col2

	cmp al, ah
	jne col2

	cmp al, dl
	jne col2

	mov dh, 1
	ret

	col2:
	mov al, byte[pos2]
	mov ah, byte[pos5]
	mov dl, byte[pos8]

	cmp al, '-'
	je coluna3

	cmp al, ah
	jne coluna3

	cmp al, dl
	jne coluna3

	mov dh, 1
	ret

	coluna3:
	mov al, byte[pos3]
	mov ah, byte[pos6]
	mov dl, byte[pos9]

	cmp al, '-'
	je diagonal1

	cmp al, ah
	jne diagonal1

	cmp al, dl
	jne diagonal1

	mov dh, 1
	ret

	diagonal1:
	mov al, byte[pos1]
	mov ah, byte[pos5]
	mov dl, byte[pos9]

	cmp al, '-'
	je diagonal2

	cmp al, ah
	jne diagonal2

	cmp al, dl
	jne diagonal2

	mov dh, 1
	ret

	diagonal2:
	mov al, byte[pos3]
	mov ah, byte[pos5]
	mov dl, byte[pos7]

	cmp al, '-'
	je retorna

	cmp al, ah
	jne retorna

	cmp al, dl
	jne retorna

	mov dh, 1
	retorna:
ret

printTabuleiro:
	
	;Printando as colunas...
	mov dx, 80
	coluna1:
	mov ah, 0Ch
	mov bh, 0
	mov al, 0xf
	mov cx, 250	
	int 10h	

	inc dx
	cmp dx, 320
	jne coluna1

	mov dx, 80
	coluna2:
	mov ah, 0Ch
	mov bh, 0
	mov al, 0xf
	mov cx, 350	
	int 10h	

	inc dx
	cmp dx, 320
	jne coluna2

	;Printando as linhas...
	mov cx, 160
	l1:
	mov ah, 0Ch
	mov bh, 0
	mov al, 0xf
	mov dx, 160	
	int 10h	

	inc cx
	cmp cx, 450
	jne l1

	mov cx, 160
	l2:
	mov ah, 0Ch
	mov bh, 0
	mov al, 0xf
	mov dx, 240	
	int 10h	

	inc cx
	cmp cx, 450
	jne l2	

ret

;printString:
;	lodsb

;	mov ah, 0xe
;	mov bh, 0
;	mov bl, 0xf
;	int 10h

;	cmp al, 13
;	jne printString
;ret

exit:


