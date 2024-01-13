#!/usr/bin/sh
# define the path to the qemu binary
QEMUPATH=/student/cmpt215/qemu215/bin/
QEMU32=$QEMUPATH/qemu-riscv32
QEMU64=$QEMUPATH/qemu-riscv64

# define the path to the riscv tools
RISCVTOOLPATH=/usr/local/riscvmulti/bin
TOOLCHAIN=$RISCVTOOLPATH/riscv64-unknown-elf-

# figure out the student's port for GDB,
# by take the user id and mod 5000 and add 25000
GDBPORT=`expr \`id -u\` % 5000 + 25000`

# find binary to run (first argument)
if [ -f $1 ]; then
    BINARY=$1
else
    echo "ERROR: $1 is not a file"
    exit 1
fi

# if --64 is specified, run the 64-bit version
# by default, run the 32 bit version
# if has --gdb, run with gdb

if [ "$2" = "--64" ]; then
    if [ "$3" = "--gdb" ]; then
        echo "Running $BINARY with gdb on port $GDBPORT"
        echo "on another terminal, run: $TOOLCHAIN-gdb $BINARY"
        echo "then in gdb, type: target remote localhost:$GDBPORT"
        $QEMU64 -g $GDBPORT $BINARY
    else
        $QEMU64 $BINARY
    fi
elif [ "$2" = "--gdb" ]; then
    echo "Running $BINARY with gdb on port $GDBPORT"
    echo "on another terminal, run: $TOOLCHAIN-gdb $BINARY"
    echo "then in gdb, type: target remote localhost:$GDBPORT"
    if [ "$3" = "--64" ]; then
        $QEMU64 -g $GDBPORT $BINARY
    else
        $QEMU32 -g $GDBPORT $BINARY
    fi
else
    $QEMU32 $BINARY
fi

# Path: taExamples/runQemu.sh
