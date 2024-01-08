.equ SYS_exit,      93
.equ SYS_printInt,  244
.equ SYS_readInt,   245
.equ SYS_printChar, 246
.equ SYS_readChar,  247
.equ SYS_printStr,  248
.equ SYS_readStr,   249

.section .rodata
input_str: 
    .string "Enter a number: "
.align 2
answer: .word 42
.align 2
output_str: 
    .string "\nYour number doubles becomes : "
test1:
    .asciz "this is welcome message 1"
test2:
    .asciz "answer to life the universe and everything is "
prompt:
  .string "enter your name: "
welcome:
  .string "hello "
newline: 
    .byte '\n'

.section .data
buffer: 
    .space 1024

.section .text
.global _start
_start:
    # print 'this is welcome message 1':
    la a0, test1
    li a7, SYS_printStr
    ecall

    # printChr '\n'
    li  a0, 10
    li  a7, SYS_printChar
    ecall

    # print 'enter your name: '
    la  a0, prompt
    li  a7, SYS_printStr
    ecall

    # get input name
    la  a0, buffer
    li  a1, 1024
    li  a7, SYS_readStr
    ecall

    # print 'hello '
    la  a0, welcome
    li  a7, SYS_printStr
    ecall

    # print name
    la  a0, buffer
    li  a7, SYS_printStr
    ecall

    # print new line
    li a0, 10
    li a7, SYS_printChar
    ecall

    # print 42: (via load immediate)
    li a0, 42
    li a7, SYS_printInt
    ecall

    # print 
    # 'answer to life the universe and everything is '
    la a0, test2
    li a7, SYS_printStr
    ecall

    # print 42: (via read from symbol)
    la a0, answer
    lw a0, 0(a0)
    li a7, SYS_printInt
    ecall

    # print newline
    li a0, 10
    li a7, SYS_printChar
    ecall

    # Print "Enter a number: "
    la a0, input_str      # Load address of input_str
    li a7, SYS_printStr   # printStr syscall number
    ecall

    # Read integer
    li a7, SYS_readInt    # readInt syscall number
    ecall
    mv t0, a0             # Store read integer in t0

    # Print "\nYour number doubles becomes : "
    la a0, output_str     # Load address of output_str
    li a7, SYS_printStr   # printStr syscall number
    ecall

    # Print input doubled
    add a0, t0, t0        # Doubles the int and save to a0
    li a7, SYS_printInt   # printInt syscall number
    ecall

    # Print newline (via load from byte)
    la a0, newline        # Load address of newline
    lb a0, 0(a0)
    li a7, SYS_printChar  # print new line as char
    ecall

    # Exit
    li a0, 0
    li a7, SYS_exit       # exit syscall number
    ecall

