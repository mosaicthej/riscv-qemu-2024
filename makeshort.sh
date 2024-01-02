#!/bin/bash

SOURCE_FILE=$1
OUTPUT_DIR=$2
BASE_NAME=$(basename "${SOURCE_FILE}" .c)

cat << EOF > Makefile
# Common variables
CC=riscv64-unknown-elf-gcc
SOURCE=${SOURCE_FILE}
OUTPUT_DIR=${OUTPUT_DIR}
BASE_NAME=${BASE_NAME}
GDBPORT=\$(shell expr \`id -u\` % 5000 + 25000)

# Architecture-specific flags
FLAGS32=-march=rv32i -mabi=ilp32
QEMU32=qemu-riscv32
FLAGS64=-march=rv64gc -mabi=lp64d
QEMU64=qemu-riscv64

# Define targets
TARGET_32 := \$(OUTPUT_DIR)/\$(BASE_NAME)_32
TARGET_64 := \$(OUTPUT_DIR)/\$(BASE_NAME)_64

# Display targets for debugging
\$(info All targets: \$(TARGET_32) \$(TARGET_64))

.PHONY: all clean gdb32 gdb64

# Default target
all: \$(TARGET_32) \$(TARGET_64)

# Rule for 32-bit target
\$(TARGET_32): \$(SOURCE)
	@mkdir -p \$(OUTPUT_DIR)
	\$(CC) -S -g \$(FLAGS32) \$< -o \$@.s
	\$(CC) -c -g \$(FLAGS32) \$@.s -o \$@.o
	\$(CC) \$(FLAGS32) \$@.o -o \$@
	\$(QEMU32) \$@

# Rule for 64-bit target
\$(TARGET_64): \$(SOURCE)
	@mkdir -p \$(OUTPUT_DIR)
	\$(CC) -S -g \$(FLAGS64) \$< -o \$@.s
	\$(CC) -c -g \$(FLAGS64) \$@.s -o \$@.o
	\$(CC) \$(FLAGS64) \$@.o -o \$@
	\$(QEMU64) \$@

# GDB rules
gdb32: \$(TARGET_32)
	@echo "Starting GDB server on port \$(GDBPORT) for 32-bit target..."
	\$(QEMU32) -g \$(GDBPORT) \$(TARGET_32) &
	@echo "Now run 'gdb \$(TARGET_32)' in another window and type 'target remote localhost:\$(GDBPORT)'"

gdb64: \$(TARGET_64)
	@echo "Starting GDB server on port \$(GDBPORT) for 64-bit target..."
	\$(QEMU64) -g \$(GDBPORT) \$(TARGET_64) &
	@echo "Now run 'gdb \$(TARGET_64)' in another window and type 'target remote localhost:\$(GDBPORT)'"

# Clean rule
clean:
	@rm -f \$(TARGET_32)*
	@rm -f \$(TARGET_64)*
EOF

