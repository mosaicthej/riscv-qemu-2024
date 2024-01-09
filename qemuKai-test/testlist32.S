.equ SYS_exit,      93
.equ SYS_printInt,  244
.equ SYS_readInt,   245
.equ SYS_printChar, 246
.equ SYS_readChar,  247
.equ SYS_printStr,  248
.equ SYS_readStr,   249

.section .rodata
input_str:  .string "Enter numbers, stop at 0:\n"
sum_str:    .string "Sum of the numbers: "
newline:    .string "\n"

.section .data
# .align 2
# .section .data

# .local list1
# list1:  .space 1024

# .local list2
# list2:  .space 1024

# .local sum1
# sum1:   .word 0

# .local sum2
# sum2:   .word 0


	.text
	.local	list1
	.comm	list1,1024,4
	.local	list2
	.comm	list2,1024,4
	.local	count1
	.comm	count1,4,4
	.local	count2
	.comm	count2,4,4
	.local	sum1
	.comm	sum1,4,4
	.local	sum2
	.comm	sum2,4,4


.section .text
.global _start
_start:
  # Print input prompt
  li a7, SYS_printStr
  la a0, input_str
  ecall

  # Read numbers for list1
  la a0, list1 # read_numbers(&list1)
  call read_numbers
  la a0, list1
  call calculate_sum
  la t0, sum1   # t0 should be addr of sum1
  sw a0, 0(t0)  # store it  
  # Print sum of list1
  li a7, SYS_printStr
  la a0, sum_str
  ecall
  li a7, SYS_printInt
  la a0, sum1
  lw a0, 0(a0)
  ecall
  li a7, SYS_printStr
  la a0, newline
  ecall

  # Print input prompt again
  li a7, SYS_printStr
  la a0, input_str
  ecall

  # Read numbers for list2
  call read_numbers
  la a0, list2
  call calculate_sum # a0 will be holding the sum
  la t0, sum2   # t0 <- &sum2
  sw a0, 0(t0)


  # Print sum of list2
  li a7, SYS_printStr
  la a0, sum_str
  ecall
  li a7, SYS_printInt
  lw a0, sum2
  ecall

  # Exit
  li a7, SYS_exit
  li a0, 0
  ecall


# Read numbers until 0 is entered and store them in a list
# @param a0: Address of the list
read_numbers:
    mv a1, a0            # Copy address of the list into a1
                         # a1 will hold the current position in the list
    li t0, 0             # Clear t0, will be used as a counter/index

    read_loop:
        li a7, SYS_readInt   # Prepare to read an integer
        ecall                # Read integer into a0
        beqz a0, end_read    # If input is 0, end reading
        sw a0, 0(a1)         # Store the read integer at the current position in the list
        addi a1, a1, 4       # Move to the next position in the list
        addi t0, t0, 1       # Increment the counter
        j read_loop          # Repeat the loop
    end_read:
        sw zero, 0(a1)       # Store 0 as the last element to mark the end of the list
        ret

# Calculate sum of numbers in a list
# @param a0: Address of the list
calculate_sum:
    mv a1, a0            # Copy address of the list into a1
                         # a1 will hold the current position in the list
    li a0, 0             # Clear a0, will be used to store the sum
sum_loop:
    lw t0, 0(a1)         # Load the current list element into t0
    beqz t0, end_sum     # If element is 0, end summation
    add a0, a0, t0       # Add the current element to the sum
    addi a1, a1, 4       # Move to the next element in the list
    j sum_loop           # Repeat the loop
end_sum:
    ret
