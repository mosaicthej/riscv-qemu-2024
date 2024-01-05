CC=gcc
AS=as

RISCV_PREFIX=riscv64-unknown-elf-

CrCC=$(RISCV_PREFIX)$(CC)
CrAS=$(RISCV_PREFIX)$(AS)

GDBPORT=$(shell expr `id -u` % 5000 + 25000)

OUTDIR=testcalls_out

ARCH32=-march=rv32i -mabi=ilp32
ARCH64=-march=rv64gc -mabi=lp64d
QEMU32=qemu-riscv32
QEMU64=qemu-riscv64

TARGET_32 = $(OUTDIR)/testcall_32
TARGET_64 = $(OUTDIR)/testcall_64

$(info All targets: $(TARGET_64) $(TARGET_32))

.PHONY: all clean gdb32 gdb64

all: $(TARGET_32) #$(TARGET_64)

$(TARGET_32): testcall_32.S addTen.S
	@mkdir -p $(OUTDIR)
	$(CrAS) -g $(ARCH32) testcall_32.S -o testcall_32.o
	$(CrAS) -g $(ARCH32) addTen.S -o addTen_32.o 
	# same assembly code, but elf format would still differ...
	$(CrCC) -g $(ARCH32) testcall_32.o addTen_32.o -o $(TARGET_32)

$(TARGET_64): testcall_64.S addTen.S
	@mkdir -p $(OUTDIR)
	$(CrAS) -g $(ARCH64) testcall_64.S -o testcall_64.o
	$(CrAS) -g $(ARCH64) addTen.S -o addTen_64.o
	$(CrCC) -g $(ARCH64) testcall_64.o addTen_64.o -o $(TARGET_64)

