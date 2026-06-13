disk_load:
pusha
push dx ; input parameter expected in dx, pushed one extra time

mov ah, 0x02 ; operation read for int 0x13
mov al, dh ; sectors to read
mov cl, 0x02 ; 0x02 is the first available sector after the bootsector 0x01
mov ch, 0x00 ; cylinder number
mov dh, 0x00 ; head number
; dl contains drive number passed from BIOS 
; 0 = floppy1, 1 = floppy2, 0x80 = hdd1, 0x81 = hdd2

int 0x13
jc disk_load_error

pop dx
cmp al, dh ; al = number of sectors read
jne disk_sectors_read_error

popa
ret

disk_load_error:
mov bx, DISK_LOAD_ERR
call bios_println
call bios_print
call bios_println

mov dh, ah ; ah = error code, dl = drive that threw error
call bios_printx
jmp disk_loop

disk_sectors_read_error:
mov bx, SECTORS_ERROR
call bios_print

disk_loop:
jmp $

DISK_LOAD_ERR: db "Disk read error: ", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0

