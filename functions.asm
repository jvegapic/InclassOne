
;------------------------
;   void(str)
strPrint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    strLen

    mov     edx, eax
    pop     eax

    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h

    pop     ebx
    pop     ecx
    pop     eax
    ret

;------------------------
;   void(str)
strPrintLn:
    call    strPrint

    push    eax
    mov     eax, 0Ah
    push    eax

    mov     eax, esp
    call    strPrint
    pop     eax
    pop     eax
    ret

;------------------------
;   int(str)
strLen:
    push    ebx
    mov     ebx, eax

    .nextChar:
        cmp     byte[eax], 0
        jz      .finish
        inc     eax
        jmp     .nextChar

    .finish:
        sub     eax, ebx
        pop     ebx
        ret

;------------------------
;   void()
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret

;------------------------
; void(int)
; Integer printing function (itoa)
intPrint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end
 
    .divideLoop:
        inc     ecx             ; count each byte to print - number of characters
        mov     edx, 0          ; empty edx
        mov     esi, 10         ; mov 10 into esi
        idiv    esi             ; divide eax by esi
        add     edx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
        push    edx             ; push edx (string representation of an intger) onto the stack
        cmp     eax, 0          ; can the integer be divided anymore?
        jnz     .divideLoop     ; jump if not zero to the label divideLoop
    
    .printLoop:
        dec     ecx             ; count down each byte that we put on the stack
        mov     eax, esp        ; mov the stack pointer into eax for printing
        call    strPrint        ; call our string print function
        pop     eax             ; remove last character from the stack to move esp forward
        cmp     ecx, 0          ; have we printed all bytes we pushed onto the stack?
        jnz     .printLoop      ; jump is not zero to the label printLoop
    
        pop     esi             ; restore esi from the value we pushed onto the stack at the start
        pop     edx             ; restore edx from the value we pushed onto the stack at the start
        pop     ecx             ; restore ecx from the value we pushed onto the stack at the start
        pop     eax             ; restore eax from the value we pushed onto the stack at the start
        ret

;------------------------
;   void(int)
intPrintLn:
    call    intPrint

    push    eax
    mov     eax, 0Ah
    push    eax

    mov     eax, esp
    call    strPrint
    pop     eax
    pop     eax
    ret