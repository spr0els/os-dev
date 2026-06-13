bios_print:
pusha
mov ah, 0x0e ; tty mode

bios_print_start:
mov al, [bx]
cmp al, 0
je bios_print_done

int 0x10
inc bx
jmp bios_print_start

bios_print_done:
popa
ret

bios_println:
pusha

mov ah, 0x0e
mov al, 0x0a
int 0x10
mov al, 0x0d
int 0x10

popa
ret
