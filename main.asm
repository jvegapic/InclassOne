%include 'functions.asm'

SECTION .data:
num1:   db  10
num2:   db  20
goodbye:  db "goodbye", 0h
phrase: db "What an awesome day!", 0h

SECTION .text:
global _start

_start:
    call    printNum1
    call    printGoodbye
    call    printPhrase
    call    printMult
    call    quit

printNum1:
    mov     eax, num1
    call    intPrintLn
    ret

printHello:
    mov     eax, "he"
    call    strPrint
    mov     eax, "llo"
    call    strPrintLn
    ret

printPhrase:
    move    phrase
    call    strPrintLn
    mov     eax, "World!"
    call    strPrintLn 
    ret

printMult:
    mov     eax, num1
    mov     ebx, num2
    mult    ebx
    call    intPrintLn
    ret

