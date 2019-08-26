section .data

	msg1 db 10,'Калькулятор',10
	lmsg1 equ $ - msg1

	msg2 db 10,'Число 1: ',0
	lmsg2 equ $ - msg2

	msg3 db 'Число 2: ',0
	lmsg3 equ $ - msg3

	msg4 db 10,'1. Сложение',10,0
	lmsg4 equ $ - msg4

	msg5 db '2. Вычитание',10,0
	lmsg5 equ $ - msg5

	msg6 db '3. Умножение',10,0
	lmsg6 equ $ - msg6

	msg7 db '4. Деление',10,0
	lmsg7 equ $ - msg7

	msg8 db 'Операция: ',0
	lmsg8 equ $ - msg8

	msg9 db 10,'Результат: ',0
	lmsg9 equ $ - msg9

	msg10 db 10,'Недопустимо',10,0
	lmsg10 equ $ - msg10

	msg11 db 10,'Повторить?',10,0
	lmsg11 equ $ - msg11

	msg12 db 10,'1.Да',10,0
	lmsg12 equ $ - msg12

	msg13 db 10,'2.Нет',10,0
	lmsg13 equ $ - msg13

	nlinea db 10,10,0
	lnlinea equ $ - nlinea

section .bss

	opc: resb 2
	num1: resb 10
	num2: resb 10
	result: resb 20
	cont: resb 2

section .text

global _start

_start:

	;Напечатать сообщение 1
	mov rax, 4
	mov rbx, 1
	mov rcx, msg1
	mov rdx, lmsg1
	int 80h

	;Напечатать сообщение 2
	mov rax, 4
	mov rbx, 1
	mov rcx, msg2
	mov rdx, lmsg2
	int 80h

	;Вводим число 1
	mov rax, 3
	mov rbx, 0
	mov rcx, num1
	mov rdx, 10
	int 80h

	mov r11, 0
	mov rcx, rax
	dec rcx
	mov rbx, 1
	;строка в число 1
strToNum1:
	mov rax, 0
	dec rcx
	mov al, [num1+rcx]
	inc rcx
	sub rax, 48
	mul rbx
	add r11, rax
	mov rax, 10
	mul rbx
	mov rbx, rax
	loop strToNum1
	push r11

	;Напечатать сообщение 3
	mov rax, 4
	mov rbx, 1
	mov rcx, msg3
	mov rdx, lmsg3
	int 80h

	;Вводим число 2
	mov rax, 3
        mov rbx, 0
        mov rcx, num2
        mov rdx, 10
        int 80h

	mov rcx, rax
	dec rcx
	mov rbx, 1
	mov r12, 0
;строка в число 2
strToNum2:
        mov rax, 0
        dec rcx
        mov al, [num2+rcx]
        inc rcx
        sub rax, 48
        mul rbx
        add r12, rax
        mov rax, 10
        mul rbx
        mov rbx, rax
        loop strToNum2
        push r12

	;Напечатать сообщение 4
	mov rax, 4
	mov rbx, 1
	mov rcx, msg4
	mov rdx, lmsg4
	int 80h

	;Напечатать сообщение 5
	mov rax, 4
	mov rbx, 1
	mov rcx, msg5
	mov rdx, lmsg5
	int 80h

	;Напечатать сообщение 6
        mov rax, 4
        mov rbx, 1
        mov rcx, msg6
        mov rdx, lmsg6
        int 80h

	;Напечатать сообщение 7
        mov rax, 4
        mov rbx, 1
        mov rcx, msg7
        mov rdx, lmsg7
        int 80h

	;Напечатать сообщение 8
        mov rax, 4
        mov rbx, 1
        mov rcx, msg8
        mov rdx, lmsg8
        int 80h

	;Выбираем операцию
	mov rbx, 0
	mov rcx, opc
	mov rdx, 2
	mov rax, 3
	int 80h

	pop r12
	pop r11

	;помещаем выбранную опцию в регистр ah
	mov ah, [opc]
	;превращаем строку в число
	sub ah, '0'

	;сравниваем введенное значение для перехода на опцию

	cmp ah, 1
	je add

	cmp ah, 2
	je subtract

	cmp ah, 3
	je multiply

	cmp ah, 4
	je divide

	;если такой опции не существует,
	;на экран выводится ошибка и прогр закрывается
	mov rax, 4
	mov rbx, 1
	mov rcx, msg10
	mov rdx, lmsg10
	int 80h

	jmp exit

add:
	add r11, r12
	jmp resl
subtract:
	sub r11, r12
	jmp resl
multiply:
	mov rax, r11
	mov rbx, r12
	mul rbx
	mov r11, rax

	jmp resl
divide:
	mov rdx, 0
	mov rax, r11
	mov rbx, r12
	div rbx
	mov r11, rax
	jmp resl

resl:
	mov rcx, 10
	mov rbx, 10
	mov rax, r11
numtostr:
	mov rdx, 0
	div rbx
	add rdx, 48
	dec rcx
	mov [result+rcx], dl
	inc rcx
	loop numtostr

	;mov rax, 1
	;mov rdi, 1
	;mov rsi, result
	;mov rdx, 11
	;int 80h

        ;Напечатать сообщение 9
        mov rax, 4
        mov rbx, 1
        mov rcx, msg9
        mov rdx, lmsg9
        int 80h

        ;Напечатать результат
        mov rax, 4
        mov rbx, 1
        mov rcx, result
        mov rdx, 10
        int 80h


;Continue

	mov rax, 4
        mov rbx, 1
        mov rcx, msg11
        mov rdx, lmsg11
        int 80h

	mov rax, 4
        mov rbx, 1
        mov rcx, msg12
        mov rdx, lmsg12
        int 80h

	mov rax, 4
        mov rbx, 1
        mov rcx, msg13
        mov rdx, lmsg13
        int 80h

	;Выбираем операцию
        mov rbx, 0
        mov rcx, cont
        mov rdx, 2
        mov rax, 3
        int 80h

        ;помещаем выбранную опцию в регистр ch
        mov ch, [cont]
        ;превращаем строку в число
        sub ch, '0'

;сравниваем введенное значение для перехода на опцию

        cmp ch, 1
        je _start

        cmp ch, 2
        je exit


exit:

	mov rax, 4
	mov rbx, 1
	mov rcx, nlinea
	mov rdx, lnlinea
	int 80h

	mov rax, 1
	mov rbx, 0
	int 80h


