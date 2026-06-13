[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl

push dx
call bios_println
mov dx, MSG_BOOT_DISK
call bios_print
pop dx
xor bx, bx
mov bl, dl
call bios_print
call bios_println

; setup the stack
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call bios_print
call bios_println

call load_kernel
call switch_prot_mode

jmp $

%include "./bios_print.s"
%include "./bios_printx.s"
%include "./disk_load.s"
%include "./gdt_setup.s"
%include "./32bit_print.s"
%include "./switch_protected_mode.s"

[bits 16]
load_kernel:
mov bx, MSG_LOAD_KERNEL
call bios_print

; load kernel from disk
mov bx, KERNEL_OFFSET
mov dh, 15 ; load first 15 sectors
mov dl, [BOOT_DRIVE]
call disk_load
ret

[bits 32]
BEGIN_PROT_MODE:
mov ebx, MSG_PROT_MODE
call print
call KERNEL_OFFSET
jmp $

; Global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "16-bit real mode",0
MSG_PROT_MODE db "Successfully switched to 32-bit protected mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0
MSG_BOOT_DISK db "Boot disk:",0

times 510-($-$$) db 0
dw 0xaa55
