gdt_start:
gdt_null: ; necessary null descriptor of GDT
dd 0x0
dd 0x0

; gdt for code segment
gdt_code:
; base = 0x0, limit = 0xfffff
dw 0xffff ; limit (bits 0-15)
dw 0x0 ; base (bits 0-15)
db 0x0 ; base (bits 16-23)
; flags
; descriptor type 1, privilege 00, present 1, code 1, conforming 0, readable 1, accessed 0
db 10011010b
; granularity 1, 32-bit default 1, 64-bit seg 0, AVL 0, limit 1111 (bits 16-19)
db 11001111b
db 0x0 ; base (bits 24-31)

; gdt for data segment
gdt_data:
dw 0xffff
dw 0x0
db 0x0
; code flag = 0; second to last bit: readable flag for code segment is writable flag for data segment; read access is always allowed
db 10010010b 
db 11001111b
db 0x0

gdt_end:

gdt_descriptor:
dw gdt_end - gdt_start - 1 ; size is always true size - 1
dd gdt_start ; set start address

; offset constants for later use
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
