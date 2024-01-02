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

.PHONY: all clean

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

# Clean rule
clean:
	@rm -f \$(TARGET_32)*
	@rm -f \$(TARGET_64)*
EOF

