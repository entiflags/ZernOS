org 0x7C00
use16

macro print msg {
if ~ msg eq si
	push si
	mov si, msg
end if
	call printfunc
if ~ msg eq si
	pop si
end if
}

mov si, hello
call panicfunc

forever:
    jmp forever
    
;usage
; mov si, STR_ADDR
; call panicfunc
panicfunc:
	print panic_prefix
	print si
	xor ax, ax
	int 16h
	; the first instr 0xFFFF00
	jmp far 0FFFFh:0

;usage
; mov si, STR_ADDR
; call printfunc
printfunc:
    lodsb                   ; loads [si] into al then (since DF = 0) si++
    or al, al               ; if al == 0
    jz .printfunc_end
    mov ah, byte 0Eh        ; setup the INT10,E interrupt
    mov bx, word 03h
    int 10h                 ; call the interrupt
    jmp printfunc
.printfunc_end:
    ret

panic_prefix:	db "BOOT PANIC: ",0
hello:          db "Hello, boot world!",0

pad:            db 510 - ($ - $$) dup 0
boot_sign:      db 55h,0AAh
