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

.PHONY: all clean qemu32 qemu64 gdb32 gdb64
# qemus gdbs are phony because they are not actual file

all: $(TARGET_32) $(TARGET_64)

$(TARGET_32): testcall_32.S addTen.S
	@mkdir -p $(OUTDIR)
	$(CrAS) -g $(ARCH32) testcall_32.S -o $(OUTDIR)/testcall_32.o
	$(CrAS) -g $(ARCH32) addTen.S -o $(OUTDIR)/addTen_32.o 
	# same assembly code, but elf format would still differ...
	$(CrCC) -g $(ARCH32) $(OUTDIR)/testcall_32.o $(OUTDIR)/addTen_32.o \
		-o $(TARGET_32)

$(TARGET_64): testcall_64.S addTen.S
	@mkdir -p $(OUTDIR)
	$(CrAS) -g $(ARCH64) testcall_64.S -o $(OUTDIR)/testcall_64.o
	$(CrAS) -g $(ARCH64) addTen.S -o $(OUTDIR)/addTen_64.o
	$(CrCC) -g $(ARCH64) $(OUTDIR)/testcall_64.o $(OUTDIR)/addTen_64.o \
		-o $(TARGET_64)

# can just type `make qemu32` `make qemu64` to run the program...
# this is like xv6 way... but I guess Dwight won't like this...
qemu32: $(TARGET_32)
	@echo "Starting $(QEMU32)..."
	$(QEMU32) $(TARGET_32)

qemu64: $(TARGET_64)
	@echo "Starting $(QEMU64)..."
	$(QEMU64) $(TARGET_64)

# GDBs
gdb32:
	@echo "Starting GDB server on port $(GDBPORT) for 32-bit target..."
	@echo "please run `gdb $(TARGET_32)` on another terminal,"
	@echo "once started, type `target remote localhost:$(GDBPORT)`"
	$(QEMU32) -g $(GDBPORT) $(TARGET_32)

gdb64: $(TARGET_64)
	@echo "Starting GDB server on port $(GDBPORT) for 64-bit target..."
	@echo "please run `gdb $(TARGET_64)` on another terminal,"
	@echo "once started, type `target remote localhost:$(GDBPORT)`"
	$(QEMU64) -g $(GDBPORT) $(TARGET_64)

# clean
clean:
	rm -f $(TARGET_32)*
	rm -f $(TARGET_64)*

