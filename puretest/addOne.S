.section .data
buffer: .space 64          # Allocate 64 bytes for the buffer

.section .text
.global _start

_start:
    # Read from STDIN
    li a7, 63             # syscall number for read
    li a0, 0              # file descriptor 0 (STDIN)
    la a1, buffer         # pointer to buffer
    li a2, 64             # number of bytes to read
    ecall                 # make the syscall

    # Store the number of bytes read in t0
    mv t0, a0

    # Modify each character in the buffer
    la a1, buffer         # Load address of buffer into a1
modify_loop:
    lbu a2, 0(a1)         # Load byte from buffer
    beq a2, zero, end_modify # If byte is 0, end of string
    addi a2, a2, 1        # Add 1 to the byte
    sb a2, 0(a1)          # Store the modified byte back into the buffer
    addi a1, a1, 1        # Move to the next byte
    bnez a2, modify_loop  # If not zero, keep looping

end_modify:
    # Write to STDOUT
    li a7, 64             # syscall number for write
    li a0, 1              # file descriptor 1 (STDOUT)
    la a1, buffer         # pointer to buffer
    mv a2, t0             # number of bytes to write
    ecall                 # make the syscall

    # Exit
    li a7, 93             # syscall number for exit
    li a0, 0              # exit status
    ecall                 # make the syscall

