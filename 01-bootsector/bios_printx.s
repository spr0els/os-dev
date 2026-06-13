bios_printx:
pusha
mov cl, 4

bios_printx_step1:
mov ax, dx
ror dx, 4 ; shift 4 BIT right: 0x1234 -> 0x4123
and ax, 0x000f ; get last digit of ax
add ax, 0x30 ; convert number to char equivalent
cmp ax, 0x39 ; if ax is 0-9
jle bios_printx_step2
add ax, 7 ; if ax >= 0x3A -> add 7 to get to 0x41-0x46 (= A-F)

bios_printx_step2:
cmp cl, 0
jz bios_printx_ready
mov bx, HEX_STRING+1
add bl, cl
mov [bx], al
dec cl
jmp bios_printx_step1

bios_printx_ready:
mov bx, HEX_STRING
call bios_print
popa
ret

HEX_STRING:
db "0x0000",0
