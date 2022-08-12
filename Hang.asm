IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
; Your variables here
; --------------------------

;================
;single variables
;================
	
	randomNumber db (?) ;The procedure "Random" puts a "Random" number in here.
	WordOffset dw (?)   ;Contains the offset of the word
	difficulty db (?)   ;Contains the difficulty, or word langth (4-6).
	wrongGusses db (?)  ;Contains the number of wrong guesses the user has made.
	
;======
;arrays
;======
	
	letterStatus db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ;one cell for each letter. when a letter is gussed, it's status will be 1.
	
	;=========
	;Word Bank
	;=========
	
	;32 4-letter words. Can be changed.
	FourLetterWords db "able","acid","ball","bomb","copy","desk","dust","edge"
					db "face","fish","gift","high","idea","join","more","lost"
					db "made","nose","open","pink","quit","race","stay","tall"
					db "user","vine","wide","blue","yoga","zone","ally","pine"
	
	;32 5-letter words. Can be changed.
	FiveLetterWords db "ready","among","delay","wheat","shave","chart","arrow","radio"
					db "liver","penny","scene","sheep","books","peace","tread","sting"
					db "watch","owner","medal","opera","night","bacon","bring","touch"
					db "guide","world","rally","child","album","stamp","dozen","zvika"
	
	;32 6-letter words. Can be changed.
	SixLetterWords db "symbol","punish","palace","office","peanut","attack","tissue","strive"
	               db "longer","indoor","update","spread","remain","behead","swords","infect"
				   db "wonder","theory","weapon","immune","snatch","center","basket","follow"
				   db "source","island","pigeon","unrest","artist","linear","refund","stereo"
				   
	;===============
	;Hangman picture
	;===============
	
	;This array contains the 'X' values of the pixels.
	hangmanX dw 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174;Hangman 1/9
			 dw 149, 150, 151, 149, 150, 151, 149, 150, 151, 149, 150, 151, 149, 150, 151, 149, 150, 151, 149, 150, 151, 149, 150, 151, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150, 150;Hangman 2/9
			 dw 151, 152, 153, 154, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 164, 164, 164, 164;Hangman 3/9
			 dw 163, 164, 165, 162, 163, 164, 165, 166, 161, 162, 163, 164, 165, 166, 167, 161, 162, 163, 164, 165, 166, 167, 161, 162, 163, 164, 165, 166, 167, 162, 163, 164, 165, 166, 163, 164, 165 ;Hangman 4/9
			 dw 9 dup (164) ;Hangman 5/9
			 dw 157, 158, 159, 160, 161, 162, 163 ;Hangman 6/9
			 dw 165, 166, 167, 168, 169, 170, 171 ;Hangman 7/9
			 dw 163, 163, 162, 162, 161, 161 ;Hangman 8/9
			 dw 165, 165, 166, 166, 167, 167 ;Hangman 9/9
	
	;This array contains the 'Y' values of the pixels.
	hangmanY dw 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118, 118 ;Hangman 1/9
			 dw 117, 117, 117, 116, 116, 116, 115, 115, 115, 114, 114, 114, 113, 113, 113, 112, 112, 112, 111, 111, 111, 110, 110, 110, 109, 108, 107, 106, 105, 104, 103, 102, 101, 100, 99, 98, 97, 96, 95, 94, 93, 92, 91, 90, 89, 88 ;Hangman 2/9
			 dw 92, 91, 90, 89, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 88, 89, 90, 91, 92 ;Hangman 3/9
			 dw 93, 93, 93, 94, 94, 94, 94, 94, 95, 95, 95, 95 ,95, 95, 95, 96, 96, 96, 96, 96, 96, 96, 97, 97, 97, 97, 97, 97, 97, 98, 98, 98, 98, 98, 99, 99, 99 ;Hangman 4/9
			 dw 100, 101, 102, 103, 104, 105, 106, 107, 108 ;Hangman 5/9
			 dw 96, 97, 98, 99, 100, 101, 102 ;Hangman 6/9
			 dw 102, 101, 100, 99, 98, 97, 96 ;Hangman 7/9
			 dw 109, 110, 111, 112, 113, 114 ;Hangman 8/9
			 dw 109, 110, 111, 112, 113, 114 ;Hangman 9/9
			 
	;This array contains the Color values of the pixels.
	hangmanColor db 97 dup (6) ;6 = brown
				 db 72 dup (64h) ;64h = blue
	
	;number of pixels you need to print to get each stage of the Hangman picture (29- first 29 pixels, 70- first 70 pixels...)
	Pixels dw 29, 70, 96, 134, 143, 150, 157, 163, 169
	
	;=========================
	;Text (messages, story...)
	;=========================
	
	Hangman db "                Hangman!", 10, 13,  "$"
	PressStart db "        Press any key to start!", 10, 13,  "$"
	theWord db "The word:", 10, 13, '$'
	enterDifficulty db "Please enter word length (number between 4 and 6):", 10, 13, "$"
	wrongInput db 10, 13,"Whoops! Thats not a valid input!", 10, 13, "$"
	gussedLettersMessage db 10,13,10,13,"Letters you guessed:",10,13,"$"
	gusseLetterMessage db 10,13,10,13,"Please enter (small) letter you wish to guess:",10,13,"$"
	playAgain db 10, 13, 10, 13,"Whould you like to play again? ", 10, 13
			  db "Enter (small) y to play again,", 10, 13
			  db "or anything else to quit:", 10, 13, '$'
	PressToQuit db 10, 13, 10, 13, "Press any key to quit . . .$"
	wordWas db 10, 13,"The word was:", 10, 13, '$'
	YouWin db "You Win!",10,13
		   db "The barbarians will have to find", 10, 13
		   db "someone else to eat!", 10, 13, 10, 13, '$'
	YouLose db "You lose!",10,13
		   db "At least you were a tasty burger.", 10, 13, 10, 13, '$'
	story db "----------------------------------------", 10, 13
		  db "                 story", 10, 13
		  db "----------------------------------------", 10, 13
		  db 10, 13
		  db "Man was a very famous explorer, until", 10, 13
		  db "one day, when he was about to find his", 10, 13
		  db "greatest discovery yet, he was attacked!", 10, 13
		  db "A barbarian tribe trapped him and was", 10, 13
		  db "about to hang him above the fire and", 10, 13
		  db "make their grandmother's special", 10, 13
		  db "human-burger recipe!", 10, 13, 10, 13
		  db "Man begged for mercy. The tribe leader", 10, 13
		  db "told Man: ""I will let you go, but only", 10, 13
		  db "if you can guess the word I am thinking", 10, 13
		  db "about this very moment"".", 10, 13
		  db 10, 13
		  db "Press any key to continue . . .$"
		  
CODESEG

; --------------------------
; Your procedures here
; --------------------------
	
	proc SetAllLetterStatusesToTrue
	;Sets all the valus of letterStatus array to 1 (true).
		mov cx, 26
		xor di, di
		mov bx, offset letterStatus
		mov ah, 1
			setLetter:
				;set letter to true(runs 26 times).
				mov [ds:bx+di], ah
				inc di
			loop setLetter 
		ret
	endp SetAllLetterStatusesToTrue
	
	
	proc ResetGameValues
	;Resets the wrong gusses counter, main registers, and the letter status array.
		;reset wrong guesses
		mov [wrongGusses], 0
		;reset letters status
		mov cx, 26
		xor di, di
		mov bx, offset letterStatus
		mov ah, 0
			ResetLetter:
				;set letter to true(runs 26 times).
				mov [ds:bx+di], ah
				inc di
			loop ResetLetter
		;reset main registers
		call ResetRegisters
		ret
	endp ResetGameValues


	proc WordPrint 
	;prints word acording to letter status. If letter wasn't gussed, it will print "-".
		push ax
		push bx
		push cx
		push dx
		xor cx, cx
		xor di, di
		mov cl, [difficulty]
			PrintLetter:
				;print letter acording to status. runs [difficulty] times.
				mov bx, [WordOffset]
				add bx, di
				mov bl, [ds:bx]
				xor bh, bh
				mov dl, bl
				cmp [letterStatus+bx-97], 1
				je LetterWasGussed
				mov dl, '-';thing to print instead of the letter
				LetterWasGussed:
				mov ah, 2
				int 21h
				inc di
			loop PrintLetter
		pop dx
		pop cx
		pop bx
		pop ax
		ret 
	endp WordPrint
	
	
	proc PrintGussedLetters
	;Print every letter the user guesed (every letter with a "true" status in [letterStatus]).
		push ax
		push bx
		push cx
		push dx
		mov dx, offset gussedLettersMessage
		mov ah, 9
		int 21h
		mov cx, 26
		mov bx, offset letterStatus
		xor di, di
			LetterChackLoop:
				;print letter if was guesed. runs 26 times.
				add bx, di
				mov ah, 0
				cmp [ds:bx], ah
				je wasntGussed
				mov ah, 2
				mov dx, di
				add dx, 97
				int 21h
				mov dx, ','
				int 21h
				wasntGussed:
				sub bx, di
				inc di
			loop LetterChackLoop
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp PrintGussedLetters	
	
	
	proc ManuallyDrawMan
	;Manually draw hangmam. in claim: [bp+4]- number of pixels to draw.
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		PixelsToDraw equ [bp+4]
		push offset hangmanX
		push offset hangmanY
		push offset hangmanColor
		mov bx, PixelsToDraw
		push bx
		call PrintPnoClear
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	endp ManuallyDrawMan
	
	proc DrawMan
	;Draw the Hangman picture acording to wrong guesses ([wrongGusses]=3 => Draws hangman 3/9)
		push ax
		push bx
		push cx
		push dx
		push offset hangmanX
		push offset hangmanY
		push offset hangmanColor
		cmp [wrongGusses], 0
		jne NotZero
		pop ax
		pop ax
		pop ax 
		jmp EndDrawingMan
		NotZero:
		xor bx, bx
		mov bl, [wrongGusses]
		add bx, bx
		sub bx, 2
		push [pixels +bx]
		call PrintPnoClear
EndDrawingMan:
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	endp DrawMan
	
	
	proc ChackIfWrong
	;Chack if user input is wrong (letter isn't in word). if it is wrong, increce [wrongGusses] by 1.
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		letter equ [bp+4]
		mov ax, letter
		xor cx, cx
		mov cl, [difficulty]
		inc [wrongGusses]
		mov bx, [WordOffset]
		xor di, di
			ChackIfLetterIsInWord:
				;chack if letter is in word, and jump if it is. runs up to [difficulty] times.
				cmp al, [ds:bx+di] 
				je LetterIsInWord
				inc di
			loop ChackIfLetterIsInWord
		jmp LetterIsNotInWord
LetterIsInWord:
		dec [wrongGusses]
LetterIsNotInWord:
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	endp ChackIfWrong
		
		
	proc Random 
	;Recives the number to random (generates a number between 0 and the number) and generates a random number in that area. the number can be 1, 3, 7, 15, 31, 63, 127, 255.
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		next equ [bp+4]
		;======================
		;move miliseconds to ax
		;======================
		mov ax, 40h
		mov es, ax
		mov ax, [es:6Ch]
		;================================================================================================
		;set var randomNumber as a number in the range 0-(next-1). Same output as rnd.Next(0,next) in C#.
		;================================================================================================
		and al, next 
		mov [randomNumber], al
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	endp Random
	
	
	proc printPnoClear 
	;in claim: x (dw arr),y (dw arr),color(db arr), langth of arr (dw) (arr are passed by ref. you only push offset)
	;A procedure that recives a list of dots (x, y, color) and number of pixels to print. If the number is 8 for example, it will print the first 8 pixels.
	;After print is finished, the function won't wait for user input, and unlike the regular printP, won't return to text mode, and clear the screen. 
	;picture will remain at the background and text size will be increced. Can clear screen and restore font size with proc "ReturnToText". Can wait for
	;user input with the proc "WaitKey".
		push bp
		mov bp, sp
		push ax
		push bx
		push cx
		push dx
		Xoffset equ [bp+10]
		Yoffset equ [bp+8]
		colorOffset equ [bp+6]
		langth equ [word ptr bp+4]
		;===========
		; Print dots
		;===========
		mov cx, langth
		xor di, di
		xor si, si
			printDot:
				;prints a dot. runs langth ([bp+6]) times.
				push cx
				mov bh,0h ;book says bl needs to be 0. maybe they ment bh?
				mov bx, Xoffset
				mov cx, [ds:bx]
				mov bx, Yoffset
				mov dx, [ds:bx]
				mov bx, colorOffset
				mov al, [ds:bx]
				mov ah,	0ch ;bios  inturrupt
				int 10h
				pop cx
				mov ax, 2
				mov bx, 1
				add Xoffset, ax
				add Yoffset, ax
				add colorOffset, bx
			loop printDot
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 8
	endp printPnoClear
	
	
	proc ReturnToText
	; Return to text mode
		push ax
		mov ax, 2
		int 10h
		pop ax
		ret
	endp ReturnToText
	
	
	proc WaitSecond
	;A procedure that stops the program for (aproximatry) one second.	
		push ax
		push bx
		push cx
		push dx 
		mov ah, 2Ch
		int 21h
		mov bh, dh
			ChackTime:
				;run untill seconds value is changed.
				mov ah, 2Ch
				int 21h
				cmp dh, bh
			je ChackTime
		pop dx
		pop cx
		pop bx
		pop ax
		ret 
	endp WaitSecond
	
	
	proc WaitKey
	; Wait for key press
		mov ah,	00h
		int 16h
		ret
	endp
	
	
	proc ClearScreen
	;clears the screen by switching between text and graphic mode.
		push ax
		;switch to text mode
		mov ax, 2
		int 10h
		;switch to graphic mode
		mov ax, 13h
		int 10h
		pop ax
		ret
	endp ClearScreen
	
	
	proc ResetRegisters
	;Resets all 6 main registers
		xor ax, ax
		xor bx, bx
		xor cx, cx
		xor dx, dx
		xor di, di
		xor si, si
		ret
	endp ResetRegisters
	
	
start:
	mov ax, @data
	mov ds, ax
; --------------------------
; Your code here
; --------------------------

;==========
;Game Start
;==========

	;======================
	;switch to graphic mode
	;======================
	mov ax, 13h
	int 10h
	;======================================================
	;Print title screen (waits one second for each drawing)
	;======================================================
	;======================================================
	;Print title screen (waits one second for each drawing)
	;======================================================
	mov di, 0 ;counter
	mov cx, 9 ;9 frames
		PrintTitle:
			push di
			call WaitSecond
			push [pixels+di]
			call ManuallyDrawMan
			pop di
			add di, 2
		loop PrintTitle
	;============
	; Print title
	;============
	mov ah, 9h
	mov dx ,offset Hangman
	int 21h
	mov dx, offset PressStart
	int 21h
	;===============================
	;wait for user input to continue
	;===============================
	;clear buffer so the game won't count button presses during animation
	mov ah, 0ch
	int 21h
	call WaitKey
	;==========================================
	;print story and wait for input to continue
	;==========================================
	call ClearScreen
	mov ah, 9
	mov dx, offset story
	int 21h
	call WaitKey
	call ClearScreen
;===========
;game starts
;===========


newGame:
	;=========================================
	;generate a random number between 0 and 31
	;=========================================
	push 31
	call Random
	;====================================================================
	;varuable randomNumber now contains a random number between 0 and 31.
	;====================================================================
	;================
	;clear the screen
	;================
	call ClearScreen
	;============================
	;get difficulty from the user
	;============================
	jmp skipInvalidInputMessage	;skips the massege for wrong input
InvalidInput:
	mov dx, offset wrongInput	;print message about invalid input.
	mov ah, 9
	int 21h
skipInvalidInputMessage:
	mov dx, offset enterDifficulty	;print message about difficulty input (4-6)
	mov ah, 9
	int 21h
;==============
;get difficulty
;==============
	mov ah, 1
	int 21h
	;============================================================================================
	;chack if user input is valid. If it isn't, will print a fitting message and get input again.
	;============================================================================================
	cmp al, 34h
	jb InvalidInput ;Jump if input's ascii code is below a's
	cmp al, 36h
	ja InvalidInput ;Jump if input's ascii code is above z's
	;==========================================================
	;mov to difficulty the difficulty level entered by the user
	;==========================================================
	sub al, 30h
	mov [difficulty], al
	;===========
	;ClearScreen
	;===========
	call ClearScreen
;================
;find word offset
;================
	call ResetRegisters
	mov al, [difficulty]
	mov bl, [randomNumber]
	mul bl
	cmp [difficulty], 4
	je diffIsFour
	cmp [difficulty], 5
	je diffIsFive
;===========
;diff is six
;===========
	add ax, offset SixLetterWords
	jmp SetWordOffset
diffIsFive:
	add ax, offset FiveLetterWords
	jmp SetWordOffset
diffIsFour:
	add ax, offset FourLetterWords
SetWordOffset:
	mov [WordOffset], ax ;var WordOffset now contains the random word's offset.
	
	
;==========
;turn start
;==========


NewTurn:
	;==============
	;Print the word
	;==============
	mov dx, offset theWord
	mov ah, 9
	int 21h
	call WordPrint
	;=========================================
	;print the letters the user already gussed
	;=========================================
	call PrintGussedLetters
	;========
	;draw man
	;========
	call DrawMan
	
;==========
;get letter
;==========

	jmp skipNotLetterMessage ;skips the massege for wrong input
NotLetter:
	mov dx, offset wrongInput;print message about invalid input.
	mov ah, 9
	int 21h
skipNotLetterMessage:
	mov dx, offset gusseLetterMessage;print message about small letter input.
	mov ah, 9
	int 21h
	;==========
	;get letter
	;==========
	mov ah, 1
	int 21h
	;============================================================================================
	;chack if user input is valid. If it isn't, will print a fitting message and get input again.
	;============================================================================================
	cmp al, 61h
	jb NotLetter
	cmp al, 7Ah
	ja NotLetter
	;============
	;clear screen
	;============
	call ClearScreen
	;================================
	;change letter status to 1 (true)
	;================================
	xor bx, bx
	mov bl, al
	sub bl, 97
	mov cl, 1
	mov [letterStatus+bx], cl
	;=======================================
	;chack if wrong (if letter isn't in word
	;=======================================
	xor ah, ah
	push ax
	call ChackIfWrong
;==================
;Chack if user lose
;==================
	cmp [wrongGusses], 9
	jne NotGameOver
	;=======
	;He Lose
	;=======
	mov ah, 9
	mov dx, offset YouLose
	int 21h
	jmp GameEnd
NotGameOver:
	;===============
	;he didn't lose.
	;===============
;=====================
;Chack if the user won
;=====================
	call ResetRegisters
	mov cl, [difficulty]
		ChackLetterStatus:
		;Chack there is a letter in the word with a "false" status. runs [difficulty] times or untill a "false" letter is found.
			mov bx, [WordOffset]
			mov si, [ds:bx+di]
			shl si, 8
			shr si, 8
			sub si, 97
			mov bx, offset letterStatus
			mov dl, 0
			cmp [ds:bx+si], dl
			je NoWin
			inc di
		loop ChackLetterStatus
	;=====================================
	;He won (no false letters were found). 
	;=====================================
	mov ah, 9
	mov dx, offset YouWin
	int 21h
	jmp GameEnd
NoWin:
	;=====================
	;jump to turn begining
	;=====================
	jmp NewTurn
GameEnd:
	;==============
	;print the word
	;==============
	mov ah, 9
	mov dx, offset wordWas
	int 21h
	call SetAllLetterStatusesToTrue
	call WordPrint
	;===================================
	;Ask user if they want to play again
	;===================================
	mov ah, 9
	mov dx, offset playAgain
	int 21h
	mov ah, 1
	int 21h
	cmp al, 'y'
	jne exit
	;==========================================
	;Start a new game (letter input wasn't 'y')
	;==========================================
	call ResetGameValues
	jmp newGame
exit:
	;================================================
	;Print "press any key to quit" and wait for input
	;================================================
	mov ah, 9
	mov dx, offset PressToQuit
	int 21h
	call WaitKey
	;===================
	;return to text mode
	;===================
	call ReturnToText
	;=================
	;Close the program
	;=================
	mov ax, 4c00h
	int 21h
END start


