[bits 32] ; enter 32-bit protected mode

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print:
pusha
mov edx, VIDEO_MEMORY

print_string_loop:

mov al, [ebx]
mov ah, WHITE_ON_BLACK

cmp al, 0
je print_string_done

mov [edx], ax
inc ebx
add edx, 2

jmp print_string_loop

print_string_done:
popa
ret
