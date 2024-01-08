PREF=riscv64-unknown-elf-
AS=as
LD=ld

FLAGS32=-march=rv32i -mabi=ilp32
FLAGS64=-march=rv64gc -mabi=lp64d

LDFLAGS32=-m elf32lriscv
LDFLAGS64=-m elf64lriscv

QEMU32=/opt/qemu215/bin/qemu-riscv32
QEMU64=/opt/qemu215/bin/qemu-riscv64

.PHONY: all qemu32 qemu64 clean gdb32 gdb64

all: testnewcalls_32 teststrings_32

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
	rm -f	testnewcalls_32 testnewcalls_64 teststrings_32 *.o

qemu32: testnewcalls_32
	$(QEMU32) testnewcalls_32

gdb32: testnewcalls_32
	$(QEMU32) -g 1234 testnewcalls32
