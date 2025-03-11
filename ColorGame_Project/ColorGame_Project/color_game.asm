; color_game.asm

INCLUDE Irvine32.inc
.data
game1	 BYTE "WELCOME ", 0
game2	 BYTE "TO ",0
game3	 BYTE "THE ",0
game4	 BYTE "COLOR ",0
game5	 BYTE "GAME",0
game6	 BYTE "!",0
rules	 BYTE "Guess as many colors of the TEXT displayed before the timer runs out!", 0
border	 BYTE "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",0

.code
main PROC
; Setting base background
    mov    eax,lightMagenta + (gray * 16)
    call    SetTextColor
    call    Clrscr            ; clear the screen
    call    Crlf                ; new line

; Setting up intro screen
    mov	 edx, OFFSET border
    call	 WriteString
    call	 Crlf
    mov    eax,red + (gray * 16)
    call    SetTextColor
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
    call    Crlf
    mov	 eax, lightMagenta + (gray * 16)
    call	 SetTextColor
    mov	 edx, OFFSET border
    call	 WriteString
    call	 Crlf

; Return console window to default colors.
    mov    eax,lightGray + (black * 16)
    call    SetTextColor
    call    Clrscr
    exit
main ENDP
END main