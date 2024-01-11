PREF=riscv64-unknown-elf-
AS=as
LD=ld

FLAGS32=-march=rv32i -mabi=ilp32
FLAGS64=-march=rv64gc -mabi=lp64d

LDFLAGS32=-m elf32lriscv --no-relax
LDFLAGS64=-m elf64lriscv --no-relax

QEMU32=/opt/qemu215/bin/qemu-riscv32
QEMU64=/opt/qemu215/bin/qemu-riscv64

.PHONY: all qemu32 qemu64 clean gdb32 gdb64

binaries=testnewcalls_32 teststrings_32 testlists_32 testlistsnola_32 testlistsgcc_32


all: $(binaries)

testlistsgcc_32: testlistsgcc_32.o # need libc functions, so use gcc's linker
	$(PREF)gcc -march=rv32i -mabi=ilp32 -o $@ $<
testlistsgcc_32.o: testlistgcc32.s
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<
testlistgcc32.s: testlist.c
	$(PREF)gcc -march=rv32i -mabi=ilp32 -S -o $@ $<

testlistsnola_32: testlistsnola_32.o
	$(PREF)$(LD) $(LDFLAGS32) -o $@ $<
testlistsnola_32.o: testlistmanual32.S
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<

testlists_32: testlists_32.o
	$(PREF)$(LD) $(LDFLAGS32) -o $@ $<
testlists_32.o: testlist32.S
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<

testnewcalls_32: testnewcalls_32.o
	$(PREF)$(LD) $(LDFLAGS32) -o $@ $<

testnewcalls_64: testnewcalls_64.o
	$(PREF)$(LD) $(LDFLAGS64) -o $@ $<

testnewcalls_32.o: testnewcalls32.S
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<

testnewcalls_64.o: testnewcalls64.S
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<


teststrings_32: teststrings_32.o
	$(PREF)$(LD) $(LDFLAGS32) -o $@ $<

teststrings_32.o: teststrings.S
	$(PREF)$(AS) $(FLAGS32) -g -o $@ $<

clean:
	rm -f	$(binaries) *.o *.s

qemu32: testnewcalls_32
	$(QEMU32) testnewcalls_32

gdb32: testnewcalls_32
	$(QEMU32) -g 1234 testnewcalls32
