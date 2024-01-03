.section .text
.globl addTen
# Function: addTen
addTen:
    addi sp, sp, -32       # Allocate space on stack
    sw s0, 28(sp)          # Save frame pointer
    addi s0, sp, 32        # Set frame pointer

    sw a0, -20(s0)         # Store argument
    lw a0, -20(s0)         # Load argument
    addi a0, a0, 10        # Add 10 to a0

    lw s0, 28(sp)          # Restore frame pointer
    addi sp, sp, 32        # Deallocate stack space
    jr ra                  # Return


