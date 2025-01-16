%include 'functions.asm'

SECTION .data:
num1:   db  10
num2:   db  20
hello:  db "hello", 0h

SECTION .text:
global _start

_start:
    call    printNum1
    call    printHello
    call    printSum
    call    quit

printNum1:
    mov     eax, num1
    call    intPrintLn
    ret

printHello:
    mov     eax, hello
    call    strPrintLn
    ret

printSum:
    mov     eax, num1
    mov     ebx, num2
    add     eax, ebx
    call    intPrintLn
    ret

