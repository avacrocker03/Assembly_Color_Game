; color_game.asm
; Authors: Ava Crocker & Maxwell Caiazza

INCLUDE Irvine32.inc
.data
startTime  DWORD 0
currTime   DWORD 0
currWord   DWORD 0
currColor  DWORD 0
game1	 BYTE "WELCOME ", 0
game2	 BYTE "TO ",0
game3	 BYTE "THE ",0
game4	 BYTE "COLOR ",0
game5	 BYTE "GAME",0
game6	 BYTE "!",0
gameover   BYTE "GAME OVER!", 0
guessText  BYTE "        Guess: ", 0
userGuess  BYTE 20 DUP(" "), 0
rules	 BYTE "Guess the COLOR of the text before the timer runs out! Press SPACE to start playing...", 0
border	 BYTE "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",0
start      BYTE "STARTING GAME...", 0
space      BYTE " ",0
return     BYTE 13, 0
redText    BYTE "RED", 0
yellowText BYTE "YELLOW", 0
greenText  BYTE "GREEN", 0
blueText   BYTE "BLUE", 0
purpleText BYTE "PURPLE", 0
blackText  BYTE "BLACK", 0
whiteText  BYTE "WHITE", 0
grayText   BYTE "GRAY", 0
colorText  DWORD OFFSET redText, OFFSET yellowText, OFFSET greenText, OFFSET blueText, OFFSET purpleText, OFFSET blackText, OFFSET whiteText, OFFSET grayText
colorDisplay  DWORD red, yellow, green, blue, magenta, black, white, lightGray

score      DWORD 0
scoreStr   BYTE  "Score: ", 0

.code
main PROC
; Setting base background
    mov     eax,lightMagenta + (gray * 16)
    call    SetTextColor
    call    Clrscr            ; clear the screen
    call    Crlf                ; new line

; Setting up intro screen
    mov	 edx, OFFSET border
    call	 WriteString
    call	 Crlf
    mov    eax,red + (gray * 16)
    call   SetTextColor
    mov    edx,OFFSET game1
    call   WriteString
    mov	 eax, lightRed + (gray * 16)
    call	 SetTextColor
    mov    edx,OFFSET game2
    call   WriteString
    mov	 eax, yellow + (gray * 16)
    call	 SetTextColor
    mov    edx,OFFSET game3
    call   WriteString
    mov	 eax, green + (gray * 16)
    call	 SetTextColor
    mov    edx,OFFSET game4
    call   WriteString
    mov	 eax, blue + (gray * 16)
    call	 SetTextColor
    mov    edx,OFFSET game5
    call   WriteString
    mov	 eax, magenta + (gray * 16)
    call	 SetTextColor
    mov    edx,OFFSET game6
    call   WriteString
    call	 Crlf
    mov	 eax, lightCyan + (gray * 16)
    call	 SetTextColor
    mov	 edx, OFFSET rules
    call	 WriteString
    call   Crlf
    mov	 eax, lightMagenta + (gray * 16)
    call	 SetTextColor
    mov	 edx, OFFSET border
    call	 WriteString
    call	 Crlf
    jmp    wait_start

wait_start:
; Checking if user inputs space to start game

    call  ReadChar   ; reading user input

    cmp   al, 20h   ; checking if space
    je    start_game

    jmp   wait_start   ; loops until user hits space

start_game:
; Starting game

    ; Displaying start game text
    mov    edx, OFFSET space
    call   WriteString
    call	 Crlf
    mov	 eax, white + (gray * 16)
    call	 SetTextColor
    mov	 edx, OFFSET start
    call	 WriteString
    call	 Crlf
    mov    edx, OFFSET space
    call   WriteString
    call	 Crlf

    ; Starting 1 min timer
    call   GetMseconds
    mov    startTime, eax   ; saving inital time

    ; Initialize random number
    call Randomize

    jmp    show_words
    
    show_words:
    ; Displaying colors

       ; Random color
       mov    eax, 8   ; allowing generation of 0-7
       call   RandomRange
       mov    ebx, eax   ; loading random number

       ; Getting color from array
       mov    eax, [colorDisplay + ebx*4]   ; loading random color
       mov    edx, gray  ; loading background color gray
       shl    edx, 4   ; computing (gray * 16)
       add    eax, edx  ; computing color + (gray * 16)
       call   SetTextColor

       ; Saving current color text for later comparison
       mov    eax, [colorText + ebx*4]  ; loading same random index into colorText
       mov    currColor, eax   ; saving text as current color


       ; Random Text
       mov   eax, 8  ; allowing generation of 0-7
       call   RandomRange
       mov    ebx, eax  ; loading random number

       ; Getting color text from array
       mov    edx, [colorText + ebx*4]   ; loading random color text
       call   WriteString

       ; Getting user input
       mov   eax, white + (gray * 16)
       call  SetTextColor
       mov   edx, OFFSET guessText   ; writing guess text prompt
       call  WriteString

       mov   edx, OFFSET userGuess   ; loading userGuess
       mov   ecx, 20    ; max of 20 chars for input
       call  ReadString    ; reading input

       ; COMPARING STRINGS SECTION
       ;loading strings
       mov esi, [currColor]  ; Point to first string
       mov edi, OFFSET userGuess  ; Point to second string
       
       ;looping through strings
       compare_loop:
            mov al, [esi]  ; Load currColor
            mov bl, [edi]  ; Load from userGuess
            cmp al, bl
            jne not_equal  ; not equal -- jumps out of loop here
    
            cmp al, 0      ; Check for null terminator
            je strings_match ; If null terminator reached, strings match
    
            inc esi        ; Move to next in currColor
            inc edi        ; userGuess
            jmp compare_loop  ;normal loop proc

        strings_match:
            add score, 1  ; Increment score
            jmp not_equal

        not_equal: ;not equal -- jumps past inc

       ; Timer
       call  GetMseconds ; getting ms
       sub   eax, startTime ; subtracting to get elapsed time
       cmp   eax, 30000 ; 30 second timer

       jl    show_words
    jmp   game_over

game_over:
; Displaying game over & exiting program
    mov    edx, OFFSET space
    call   WriteString
    call	 Crlf
    mov    edx, OFFSET space
    call   WriteString
    call	 Crlf
    mov	 eax, white + (gray * 16)
    call	 SetTextColor
    mov	 edx, OFFSET gameover
    call	 WriteString
    call	 Crlf
        

    mov edx, OFFSET scoreStr
    call     WriteString
    mov eax, score
    call     WriteDec
    call     Crlf
    exit

main ENDP
END main


