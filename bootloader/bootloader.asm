org 0x7C00
use16

hello:          db "Hello, boot world!",0

pad:            db 510 - ($ - $$) dup 0
boot_sign:      db 55h,0AAh