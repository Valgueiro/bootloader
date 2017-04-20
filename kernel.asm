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

;Tabuleiros em todos os turnos.
tabuleiro1 db '---------'
tabuleiro2 db '---------'
tabuleiro3 db '---------'
tabuleiro4 db '---------'

turno db 1
pontos1 db 0
pontos2 db 0

Hacking db 'Iniciando o hack...', 13
Hacked db 'Tabuleiro hackeado!', 13
Recalling db 'Voce ja sentiu a sensacao de... dejavu?', 13
EMPing db 'Apagando as luzes!', 13
neutra db '                                       ', 13

Retorno db '> Jogar novamente', 13
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
		call turnoSeta	
	
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao1

		mov al, '-'
		cmp al, byte[pos1]
		jne turno1 ;Posição já ocupada.
		
		sai_restricao1:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao2
		
		mov al, '-'
		cmp al, byte[pos2]
		jne turno1

		sai_restricao2:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao3

		mov al, '-'
		cmp al, byte[pos3]
		jne turno1

		sai_restricao3:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao4

		mov al, '-'
		cmp al, byte[pos4]
		jne turno1

		sai_restricao4:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao6

		mov al, '-'
		cmp al, byte[pos6]
		jne turno1

		sai_restricao6:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao7
 
		mov al, '-'
		cmp al, byte[pos7]
		jne turno1
		
		sai_restricao7:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao8

		mov al, '-'
		cmp al, byte[pos8]
		jne turno1

		sai_restricao8:
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
		cmp ch, 2 ;Estou no turno pós-ativação de EMP. A restrição não vale.
		je sai_restricao9

		mov al, '-'
		cmp al, byte[pos9]
		jne turno1

		sai_restricao9:
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

	call RECALL_Tabuleiros ;Atualizando os tabuleiros.	

	cmp ch, 2 ;Estou no fim do turno pós-ativação de EMP.
	je EMP_volta

	mov ch, 0 ;Recall finalizado.
 	
	call winCheck
	cmp dh, 1
	jne turno1
	
	call CURSORV
	call PUTCHAR
	jmp opcao

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
		mov dl, 19
		int 10h

		;Zerando a frase.
		mov si, neutra
		call printString
	
		;Setando o cursor;
		mov ah, 02h
		mov bh, 00h
		mov dh, 26
		mov dl, 28
		int 10h

		;Printando a frase.
		mov si, Hacking
		call printString

		;Algoritmo (não veja isso se não quiser perder a sensação de hacker!):

		;Primeira coluna rotacionada para cima.
		call HACK_Rot1Up
		
		call atualizaTabuleiro
		call delay

		;Segunda coluna rotacionada para baixo.
		call HACK_Rot2Down

		call atualizaTabuleiro
		call delay

		;Primeira linha rotacionada para a direita.
		call HACK_Rot1Right	

		call atualizaTabuleiro
		call delay	
	
		;3ª rotacionada para a esquerda.
		call HACK_Rot3Left

		call atualizaTabuleiro
		call delay
		
		;Elemento do centro apagado.
		mov byte[pos5], '-'

		call atualizaTabuleiro

		;Setando o cursor;
		mov ah, 02h
		mov bh, 00h
		mov dh, 26
		mov dl, 28
		int 10h

		;Printando a frase.
		mov si, Hacked
		call printString		

	 jmp termino

	Recall:
		mov al, byte[turno]
		cmp al, 1 ; X conjurou.
		je xVerify2
	
		; O conjurou.
		mov dl, byte[pontos2]
		sub dl, 2
		cmp dl, 0
		jl turno1 ; -O- não tem pelo menos 1 ponto para conjurar Retroceder.

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

		;Retroceder: 
		mov ch, 1 ;Recall ativado!
		;1º passo: o tabuleiro volta ao seu estado 3 turnos atrás (o tabuleiro 1 contém isso).
		call RECALL_1
		
		;2º passo: o tabuleiro é atualizado.
		call atualizaTabuleiro

		;OBS.: o jogador que conjurou ainda tem a vez, então TURNO não é chamada.
		
	jmp termino

	EMP: 
		mov al, byte[turno]
		cmp al, 1 ; X conjurou.
		je xVerify3
	
		; O conjurou.
		mov dl, byte[pontos2]
		sub dl, 1
		cmp dl, 0
		jl turno1 ; -O- não tem pelo menos 2 pontos para conjurar Pulso Eletromagnético.

		jmp EMPExec

		xVerify3:
		mov dl, byte[pontos1]
		sub dl, 1
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
		mov dl, 19
		int 10h

		;Zerando a frase.
		mov si, neutra
		call printString
	
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

		mov ch, 2 ;EMP ativado!.
		;1º passo: a fronteira do tabuleiro "é apagada" (fica só invisível, mas o oponente pode colocar uma peça em qualquer lugar).
		call atualizaTabuleiro 
		;2º passo: as peças na fronteira são trocadas (X vira O, O vira X).
		call EMP_troca

		;3º passo: esse turno é encerrado e um turno "às escuras" é iniciado.
		call TURNO
		jmp turno1

		EMP_volta:
		;4º passo: no fim do turno seguinte, as peças voltam a ser visíveis e o ritmo segue.
		mov ch, 0 ;EMP finalizado.
		mov ah, 0xb
		mov bh, 0
		mov bl, 7
		int 10h
		call atualizaTabuleiro

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

atualizaTabuleiro:

	;Posição 1.
	mov ah, 02h
	mov bh, 00h
	mov dh, 7
	mov dl, 25
	int 10h
	mov al, byte[pos1]
	call PUTCHAR

	;Posição 2.
	mov ah, 02h
	mov bh, 00h
	mov dh, 7
	mov dl, 37
	int 10h
	mov al, byte[pos2]
	call PUTCHAR

	;Posição 3.
	mov ah, 02h
	mov bh, 00h
	mov dh, 7
	mov dl, 49
	int 10h
	mov al, byte[pos3]
	call PUTCHAR

	;Posição 4.
	mov ah, 02h
	mov bh, 00h
	mov dh, 12
	mov dl, 25
	int 10h
	mov al, byte[pos4]
	call PUTCHAR

	cmp ch, 2 ;PEM foi ativado!
	je pula5

	;Posição 5.
	mov ah, 02h
	mov bh, 00h
	mov dh, 12
	mov dl, 37
	int 10h
	mov al, byte[pos5]
	call PUTCHAR

	pula5:
	;Posição 6.
	mov ah, 02h
	mov bh, 00h
	mov dh, 12
	mov dl, 49
	int 10h
	mov al, byte[pos6]
	call PUTCHAR

	;Posição 7.
	mov ah, 02h
	mov bh, 00h
	mov dh, 17
	mov dl, 25
	int 10h
	mov al, byte[pos7]
	call PUTCHAR

	;Posição 8.
	mov ah, 02h
	mov bh, 00h
	mov dh, 17
	mov dl, 37
	int 10h
	mov al, byte[pos8]
	call PUTCHAR

	;Posição 9.
	mov ah, 02h
	mov bh, 00h
	mov dh, 17
	mov dl, 49
	int 10h
	mov al, byte[pos9]
	call PUTCHAR
	
ret

;HABILIDADES

HACK_Rot1Up:
	mov al, byte[pos1]
	mov dl, byte[pos7]
	mov cl, byte[pos4]
	
	;1 pra 7.
	mov byte[pos7], al
	;7 pra 4.
	mov byte[pos4], dl
	;4 pra 1.
	mov byte[pos1], cl
ret

HACK_Rot2Down:
	mov al, byte[pos2]
	mov dl, byte[pos5]
	mov cl, byte[pos8]
	
	;2 pra 5.
	mov byte[pos5], al
	;5 pra 8.
	mov byte[pos8], dl
	;8 pra 2.
	mov byte[pos2], cl
ret

HACK_Rot1Right:
	mov al, byte[pos1]
	mov dl, byte[pos2]
	mov cl, byte[pos3]

	;1 para 2.	
	mov byte[pos2], al
	;2 para 3.
	mov byte[pos3], dl
	;3 para 1.
	mov byte[pos1], cl
ret

HACK_Rot3Left:
	mov al, byte[pos7]
	mov dl, byte[pos8]
	mov cl, byte[pos9]

	;9 para 8.	
	mov byte[pos8], cl
	;8 para 7.
	mov byte[pos7], dl
	;7 para 9.
	mov byte[pos9], al
ret


RECALL_Tabuleiros:

	mov bx, 0

	;Tabuleiro 1 recebe o 2.
	tabuleiro2_1:
		mov al, byte[tabuleiro2+bx]
		mov byte[tabuleiro1+bx], al
		
		inc bx
		cmp bx, 8
		jng tabuleiro2_1

	mov bx, 0

	;Tabuleiro 2 recebe o 3.
	tabuleiro3_2:
		mov al, byte[tabuleiro3+bx]
		mov byte[tabuleiro2+bx], al
		
		inc bx
		cmp bx, 8
		jng tabuleiro3_2
	
	mov bx, 0

	;Tabuleiro 3 recebe o 4.
	tabuleiro4_3:
		mov al, byte[tabuleiro4+bx]
		mov byte[tabuleiro3+bx], al
		
		inc bx
		cmp bx, 8
		jng tabuleiro4_3

	mov bx, 0

	;Tabuleiro 4 recebe a configuração atual.
	tabuleiroatual_4:
		mov al, byte[pos1]
		mov byte[tabuleiro4+0], al
		
		mov al, byte[pos2]
		mov byte[tabuleiro4+1], al

		mov al, byte[pos3]
		mov byte[tabuleiro4+2], al

		mov al, byte[pos4]
		mov byte[tabuleiro4+3], al

		mov al, byte[pos5]
		mov byte[tabuleiro4+4], al

		mov al, byte[pos6]
		mov byte[tabuleiro4+5], al

		mov al, byte[pos7]
		mov byte[tabuleiro4+6], al

		mov al, byte[pos8]
		mov byte[tabuleiro4+7], al

		mov al, byte[pos9]
		mov byte[tabuleiro4+8], al

ret

RECALL_1:
	;Como a configuração de tabuleiro 1 vai ser a atual, todos os tabuleiros têm que ser atualizados.

	mov al, byte[tabuleiro1+0]
	mov byte[pos1], al

	mov al, byte[tabuleiro1+1]
	mov byte[pos2], al

	mov al, byte[tabuleiro1+2]
	mov byte[pos3], al

	mov al, byte[tabuleiro1+3]
	mov byte[pos4], al

	mov al, byte[tabuleiro1+4]
	mov byte[pos5], al

	mov al, byte[tabuleiro1+5]
	mov byte[pos6], al

	mov al, byte[tabuleiro1+6]
	mov byte[pos7], al

	mov al, byte[tabuleiro1+7]
	mov byte[pos8], al

	mov al, byte[tabuleiro1+8]
	mov byte[pos9], al	
ret

EMP_troca:
	mov al, byte[pos1]
	call change
	mov byte[pos1], al

	mov al, byte[pos2]
	call change
	mov byte[pos2], al

	mov al, byte[pos3]
	call change
	mov byte[pos3], al

	mov al, byte[pos4]
	call change
	mov byte[pos4], al

	mov al, byte[pos6]
	call change
	mov byte[pos6], al

	mov al, byte[pos7]
	call change
	mov byte[pos7], al

	mov al, byte[pos8]
	call change
	mov byte[pos8], al

	mov al, byte[pos9]
	call change
	mov byte[pos9], al
ret

change:
	cmp al, '-'
	je saindo2

	cmp al, 'X'
	je changetoO

	mov al, 'X'
	ret	

	changetoO:
	mov al, 'O'

saindo2:
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
	cmp al, '-'
	jne printaAlgo

	mov al, ' '	

	printaAlgo:
	cmp ch, 2 ;PEM foi ativado!
	je PEM_invisivel

	mov bl, 0xf
	jmp PUTCHARExec	

	PEM_invisivel: ;As peças ficarão pretas.
	mov bl, 0

	PUTCHARExec:
	mov ah, 0xe
	mov bh, 0
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

	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 25
	int 10h
	
	mov al, 'X'
	call PUTCHAR 


	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 49
	int 10h
	
	mov al, 'O'
	call PUTCHAR

ret

delay:
	mov bp, 850
	mov dx, 850
	delay2:
		dec bp
		nop
		jnz delay2
	dec dx
	jnz delay2

ret

turnoSeta:
	mov bl, byte[turno]
	cmp bl, 2 ;O
	je turnoO
	
	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 23
	int 10h

	mov al, '>'
	call PUTCHAR

	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 47
	int 10h

	mov al, ' '
	call PUTCHAR
	ret

	turnoO:
	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 47
	int 10h

	mov al, '>'
	call PUTCHAR
	
	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 23
	int 10h

	mov al, ' '
	call PUTCHAR
ret

opcao:
	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 23
	int 10h

	mov al, ' '
	call PUTCHAR

	mov ah, 02h
	mov bh, 00h
	mov dh, 27
	mov dl, 47
	int 10h

	mov al, ' '
	call PUTCHAR	
	
	mov ah, 02h
	mov bh, 00h
	mov dh, 26; linha
	mov dl, 19
	int 10h

	mov si, neutra
	call printString

	mov ah, 02h
	mov bh, 00h
	mov dh, 26; linha
	mov dl, 29
	int 10h

	mov si, Retorno
	call printString
	
	esperaEnter:
		mov ah, 0
		int 16h
			
		cmp al, 13
		jne esperaEnter

	je retornoParaMenu

ret

retornoParaMenu:
	;Zerando variaveis
	mov byte[pos1], '-'
	mov byte[pos2], '-'
	mov byte[pos3], '-'
	mov byte[pos4], '-'
	mov byte[pos5], '-'
	mov byte[pos6], '-'
	mov byte[pos7], '-'
	mov byte[pos8], '-'
	mov byte[pos9], '-'
	
	mov bx, 0
	for:
		mov byte[tabuleiro1 + bx], '-'
		mov byte[tabuleiro2 + bx], '-'
		mov byte[tabuleiro3 + bx], '-'
		mov byte[tabuleiro4 + bx], '-'
	
		inc bx

		cmp bx, 8
		jne for

	mov byte[turno], 1
	mov byte[pontos1], 0
	mov byte[pontos2], 0	

	jmp 0x8600

exit:
