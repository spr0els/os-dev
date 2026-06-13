[bits 16]
switch_prot_mode:
cli ; disable interrupts
lgdt [gdt_descriptor] ; load gdt descriptor
mov eax, cr0
or eax, 0x1
mov cr0, eax
jmp CODE_SEG:init_prot_mode

[bits 32]
init_prot_mode:
mov ax, DATA_SEG ; update segment registers
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

mov ebp, 0x90000 ; set stack to free space
mov esp, ebp
call BEGIN_PROT_MODE
