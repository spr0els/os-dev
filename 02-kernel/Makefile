CC=i686-elf-gcc
LD=i686-elf-ld

kernel.bin: kernel.c
	$(CC) -ffreestanding -c $< -o kernel.o
	# 0x1000 as offset for local addresses
	$(LD) -o $@ -Ttext 0x1000 --oformat binary kernel.o

kernel-image.bin: bootsector.bin kernel.bin
	cat ../01-bootsector/bootsector.bin kernel.bin > kernel-image.bin

.PHONY: bootsector.bin
bootsector.bin:
	$(MAKE) -C ../01-bootsector $@

.PHONY: run
run: kernel-image.bin
	qemu-system-i386 -fda $< -boot a -serial stdio

.PHONY: clean
clean:
	rm -rf *.o *.bin

