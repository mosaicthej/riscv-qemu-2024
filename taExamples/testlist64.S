.equ SYS_exit,      93
.equ SYS_printInt,  244
.equ SYS_readInt,   245
.equ SYS_printChar, 246
.equ SYS_readChar,  247
.equ SYS_printStr,  248
.equ SYS_readStr,   249

.section .rodata # we not modify this section
input_str:  .string "Enter numbers, stop at 0:\n"
sum_str:    .string "Sum of the numbers: "
newline:    .string "\n"

.section .data
.align 3 # 2^3 = 8

# emits `list1` to symbol table. 
# it's okay to not have this line.
# but gdb would be sad if you ask him about list1.
# because it won't find it.

.local list1 
list1:  .space 1024

.local list2
list2:  .space 1024

.local sum1
sum1:   .dword 0 # use .dword for 64 bit ver.

.local sum2
sum2:   .dword 0

# `.local` directive emits the label to symbol table

# `.comm` or `.common` directive emits the object to bss section instead
# of being part of elf file

# I've seen the compiler put it in bss instead of `.data`, but then linker
# needs to do things to figure out where is the bss at.

#	.local	list1 
#	.comm	list1,1024,8 # 1024 bytes, 8 bytes alignment 
#	.local	list2
#	.comm	list2,1024,8
#	.local	count1
#	.comm	count1,4,8
#	.local	count2
#	.comm	count2,4,8
#	.local	sum1
#	.comm	sum1,4,8
#	.local	sum2
#	.comm	sum2,4,8


.section .text
.global _start # use _start instead of main, as we don't have libc and crt0
# needs to emit this to global symbol table (this is must) so things can find it.
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
  sd a0, 0(t0)  # store it  
  # Print sum of list1
  li a7, SYS_printStr
  la a0, sum_str
  ecall
  li a7, SYS_printInt
  la a0, sum1
  ld a0, 0(a0)
  ecall
  li a7, SYS_printStr
  la a0, newline
  ecall

  # Print input prompt again
  li a7, SYS_printStr
  la a0, input_str
  ecall

  # Read numbers for list2
  la a0, list2
  call read_numbers
  la a0, list2
  call calculate_sum # a0 will be holding the sum
  # this is same as `jal` or `call ra calculate_sum`
  # `ra` is default. You can change it to other registers.

  la t0, sum2   # t0 <- &sum2
  sd a0, 0(t0)


  # Print sum of list2
  li a7, SYS_printStr
  la a0, sum_str
  ecall
  li a7, SYS_printInt
  ld a0, sum2
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
        sd a0, 0(a1)         # Store the read integer at the current position in the list
        addi a1, a1, 8       # Move to the next position in the list
        addi t0, t0, 1       # Increment the counter
        j read_loop          # Repeat the loop
    end_read:
        sd zero, 0(a1)       # Store 0 as the last element to mark the end of the list
        ret   # equivalent to `jr ra`

# Calculate sum of numbers in a list
# @param a0: Address of the list
calculate_sum:
    mv a1, a0            # Copy address of the list into a1
                         # a1 will hold the current position in the list
    li a0, 0             # Clear a0, will be used to store the sum
sum_loop:
    ld t0, 0(a1)         # Load the current list element into t0
    beqz t0, end_sum     # If element is 0, end summation
    add a0, a0, t0       # Add the current element to the sum
    addi a1, a1, 8       # Move to the next element in the list
    j sum_loop           # Repeat the loop
end_sum:
    ret

