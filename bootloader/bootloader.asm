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

; stack end: 0x500
; sp, bp: 0x600

.start:
    cli
    cld
    xor ax, ax
    mov ss, ax
    mov es, ax
    mov sp, 600h
    mov bp, 600h
    push cs
    pop ds

.check_disk:
	mov byte [boot_drive], dl
	cmp dl, byte 080h
	jl .not_hdd
.is_hdd:
;AH		41h = function number for extensions check[8]
;DL  	drive index (e.g. 1st HDD = 80h)
;BX		55AAh	
	mov ah, byte 41h
	mov bx, word 55AAh
	int 13h
;CF 	Set On Not Present, Clear If Present
;BX		55AAh
;CX		bit1: Device Access using the packet structure
	jc .not_lba
	cmp bx, 0AA55h
	jne .not_lba
	test cl, byte 1	; and cmp
	jnz .lba_ok
	
.not_lba:	
	mov si, lba_not_found
	jmp panicfunc
.not_hdd:
	mov si, not_hdd
	jmp panicfunc

.lba_ok:



forever:
    jmp forever
    
;usage
; mov si, STR_ADDR
; jmp panicfunc
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

; variables
boot_drive			db 0

; error messages
panic_prefix:		db "BOOT PANIC: ",0
lba_not_found:      db "Hard drive doesnt support LBA packet struct",0
not_hdd:            db "Not a valid harddrive",0

; padding and boot signature
pad:            	db 510 - ($ - $$) dup 0
boot_sign:      	db 55h,0AAh
