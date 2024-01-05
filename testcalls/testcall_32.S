.section .rodata
inputPrompt: .string "Enter a number: "
inputFormat: .string "%d"
outputPrompt: .string "Number plus 10 is %d\n"

.section .text
.globl main

# Function: inputNumber
inputNumber:
    addi sp, sp, -32       # Allocate space on stack
    sw ra, 28(sp)          # Save return address
    sw s0, 24(sp)          # Save frame pointer
    addi s0, sp, 32        # Set frame pointer

    la a0, inputPrompt     # Load address of input prompt
    call printf            # Call printf

    addi a1, s0, -20       # Address for storing input number
    la a0, inputFormat     # Load address of input format
    call scanf             # Call scanf

    lw a0, -20(s0)         # Load input number to a0

    lw ra, 28(sp)          # Restore return address
    lw s0, 24(sp)          # Restore frame pointer
    addi sp, sp, 32        # Deallocate stack space
    jr ra                  # Return

# Function: addTen
#addTen:
# see addTen.S

# Function: printNumber
printNumber:
    addi sp, sp, -32       # Allocate space on stack
    sw ra, 28(sp)          # Save return address
    sw s0, 24(sp)          # Save frame pointer
    addi s0, sp, 32        # Set frame pointer

    sw a0, -20(s0)         # Store argument
    lw a1, -20(s0)         # Load argument to a1
    la a0, outputPrompt    # Load address of output prompt
    call printf            # Call printf

    lw ra, 28(sp)          # Restore return address
    lw s0, 24(sp)          # Restore frame pointer
    addi sp, sp, 32        # Deallocate stack space
    jr ra                  # Return

# Main function
main:
    addi sp, sp, -32       # Allocate space on stack
    sw ra, 28(sp)          # Save return address
    sw s0, 24(sp)          # Save frame pointer
    addi s0, sp, 32        # Set frame pointer

    call inputNumber       # Call inputNumber
    call addTen            # Call addTen
    call printNumber       # Call printNumber

    li a0, 0               # Load 0 into a0

    lw ra, 28(sp)          # Restore return address
    lw s0, 24(sp)          # Restore frame pointer
    addi sp, sp, 32        # Deallocate stack space
    jr ra                  # Return

