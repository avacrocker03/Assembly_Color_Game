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

    call  ReadChar

    cmp   al, 20h
    je    start_game

    jmp   wait_start

start_game:
; Starting game

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
    mov    startTime, eax

    ; Initialize random number
    call Randomize

    jmp    show_words
    
    show_words:
    ; Displaying colors

       mov    edx, OFFSET return
       call   WriteString

       ; Random color
       mov    eax, 8
       call   RandomRange
       mov    ebx, eax

       ; Getting color from array
       mov    eax, [colorDisplay + ebx*4]
       mov    edx, gray
       shl    edx, 4
       add    eax, edx
       call   SetTextColor

       ; Saving current color text for later comparison
       mov    eax, [colorText + ebx*4]
       mov    currColor, eax


       ; Random Text
       mov   eax, 8
       call   RandomRange
       mov    ebx, eax

       ; Getting color text from array
       mov    eax, [colorText + ebx*4]
       mov    edx, eax
       mov    currWord, eax
       call   WriteString

       ; Getting user input
       mov   eax, white + (gray * 16)
       call  SetTextColor
       mov   edx, OFFSET guessText
       call  WriteString

       mov   edx, OFFSET userGuess
       mov   ecx, 20
       call  ReadString

       ; COMPARING STRINGS SECTION
       ;loading strings
       mov esi, OFFSET currColor  ; Point to first string
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

       ; TODO: have program pause and take user input for guess (ps. set breakpoint to line 199 to have prog continuously run and not have to step)
       ;       compare currColor to the userGuess (i believe you have to compare byte by byte lmk if u want help on this)
       ;       make two loops, right and wrong, jump to whichever based off guess
       ;       add score 1 to score if right
       ;       display score once timer runs out
       ;       can also display time if you want


       ; Timer
       call  GetMseconds
       sub   eax, startTime
       cmp   eax, 30000 ; set shorter for testing purposes, change to 60000 for 1 min

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
    mov edx, OFFSET score
    call     WriteDec
    call     Crlf
    exit

main ENDP
END main


