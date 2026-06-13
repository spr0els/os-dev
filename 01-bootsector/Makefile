
bootsector.bin: bootsector.s
	nasm -f bin $< -o $@

.PHONY: run
run: bootsector.bin
	qemu-system-i386 -fda $< -boot a -serial stdio

.PHONY: clean
clean:
	rm bootsector.bin
