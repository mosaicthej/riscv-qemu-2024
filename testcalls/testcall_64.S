.section .rodata
inputPrompt: .string "Enter a number: "
inputFormat: .string "%d"
outputPrompt: .string "Number plus 10 is %d\n"

.section .text
.globl main

# Function: inputNumber
inputNumber:
    addi sp, sp, -64       # Allocate space on stack
    sd ra, 56(sp)          # Save return address
    sd s0, 48(sp)          # Save frame pointer
    addi s0, sp, 64        # Set frame pointer

    la a0, inputPrompt     # Load address of input prompt
    call printf            # Call printf

    addi a1, s0, -20       # Address for storing input number
    la a0, inputFormat     # Load address of input format
    call scanf             # Call scanf

    ld a0, -20(s0)         # Load input number to a0

    ld ra, 56(sp)          # Restore return address
    ld s0, 48(sp)          # Restore frame pointer
    addi sp, sp, 64        # Deallocate stack space
    jr ra                  # Return

# Function: addTen
addTen:
    addi sp, sp, -64       # Allocate space on stack
    sd s0, 56(sp)          # Save frame pointer
    addi s0, sp, 64        # Set frame pointer

    sd a0, -20(s0)         # Store argument
    ld a0, -20(s0)         # Load argument
    addi a0, a0, 10        # Add 10 to a0

    ld s0, 56(sp)          # Restore frame pointer
    addi sp, sp, 64        # Deallocate stack space
    jr ra                  # Return

# Function: printNumber
printNumber:
    addi sp, sp, -64       # Allocate space on stack
    sd ra, 56(sp)          # Save return address
    sd s0, 48(sp)          # Save frame pointer
    addi s0, sp, 64        # Set frame pointer

    sd a0, -20(s0)         # Store argument
    ld a1, -20(s0)         # Load argument to a1
    la a0, outputPrompt    # Load address of output prompt
    call printf            # Call printf

    ld ra, 56(sp)          # Restore return address
    ld s0, 48(sp)          # Restore frame pointer
    addi sp, sp, 64        # Deallocate stack space
    jr ra                  # Return

# Main function
main:
    addi sp, sp, -64       # Allocate space on stack
    sd ra, 56(sp)          # Save return address
    sd s0, 48(sp)          # Save frame pointer
    addi s0, sp, 64        # Set frame pointer

    call inputNumber       # Call inputNumber
    call addTen            # Call addTen
    call printNumber       # Call printNumber

    li a0, 0               # Load 0 into a0

    ld ra, 56(sp)          # Restore return address
    ld s0, 48(sp)          # Restore frame pointer
    addi sp, sp, 64        # Deallocate stack space
    jr ra                  # Return
