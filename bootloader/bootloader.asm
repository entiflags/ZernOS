org 0x7C00
use16

mov ah, 0Eh
mov bx, 03h
mov al, 'h'
int 10h
mov al, 'e'
int 10h
mov al, 'l'
int 10h
int 10h
mov al, 'o'
int 10h

pad:            times 510 - ($ - $$) db 0
boot_sign:      db 55h,0AAh
