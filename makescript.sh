#!/bin/bash

SOURCE_FILE=$1
OUTPUT_DIR=$2
BASE_NAME=$(basename "${SOURCE_FILE}" .c) # Extracts the base name correctly

cat << EOF > Makefile
# Set variables
BASE_NAME=${BASE_NAME}
MARCH32=rv32i
ABI32=ilp32
QEMU32=qemu-riscv32
MARCH64=rv64gc
ABI64=lp64d
QEMU64=qemu-riscv64

# Define targets
TARGET_32 := ${OUTPUT_DIR}/\${BASE_NAME}_32
TARGET_64 := ${OUTPUT_DIR}/\${BASE_NAME}_64

# Display targets for debugging
\$(info All targets: \${TARGET_32} \${TARGET_64})

.PHONY: all clean

# Default target
all: \${TARGET_32} \${TARGET_64}

# Build rules
\${TARGET_32}: ${SOURCE_FILE}
	@mkdir -p ${OUTPUT_DIR}
	riscv64-unknown-elf-gcc -S -march=\${MARCH32} -mabi=\${ABI32} \$< -o \$@.s
	riscv64-unknown-elf-gcc -c -march=\${MARCH32} -mabi=\${ABI32} \$@.s -o \$@.o
	riscv64-unknown-elf-gcc -march=\${MARCH32} -mabi=\${ABI32} \$@.o -o \$@
	\${QEMU32} \$@

\${TARGET_64}: ${SOURCE_FILE}
	@mkdir -p ${OUTPUT_DIR}
	riscv64-unknown-elf-gcc -S -march=\${MARCH64} -mabi=\${ABI64} \$< -o \$@.s
	riscv64-unknown-elf-gcc -c -march=\${MARCH64} -mabi=\${ABI64} \$@.s -o \$@.o
	riscv64-unknown-elf-gcc -march=\${MARCH64} -mabi=\${ABI64} \$@.o -o \$@
	\${QEMU64} \$@

# Clean rule
clean:
	@rm -f ${OUTPUT_DIR}/\${BASE_NAME}_32*
	@rm -f ${OUTPUT_DIR}/\${BASE_NAME}_64*
EOF

