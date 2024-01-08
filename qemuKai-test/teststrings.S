.section .rodata
str1:
  .string "message 1\n"
prompt:
  .string "enter your name: "
welcome:
  .string "hello "
emsg:
  .string "end of message\n"

chr1: .byte 'a'
chr2: .byte 'b'
nl:   .byte '\n'

.section .data
buffer:
  .space 1024

.section .text
.global _start
_start:
  # print msg1
  la  a0, str1
  li  a7, 248
  ecall

  # print two chars and newline on printChar
  la  a0, chr1
  lb  a0, 0(a0)
  li  a7, 246
  ecall
  
  la  a0, chr2
  lb  a0, 0(a0)
  li  a7, 246
  ecall

  li  a0, 10
  li  a7, 246
  ecall

  # print prompt
  la  a0, prompt
  li  a7, 248
  ecall

  # get input name
  la  a0, buffer
  li  a1, 1024
  li  a7, 249
  ecall

  # print welcome
  la  a0, welcome
  li  a7, 248
  ecall

  # print name
  la  a0, buffer
  li  a7, 248
  ecall

  # print prompt
  la  a0, prompt
  li  a7, 248
  ecall

  # get input name
  la  a0, buffer
  li  a1, 1024
  li  a7, 249
  ecall

  # print welcome
  la  a0, welcome
  li  a7, 248
  ecall

  # print name
  la  a0, buffer
  li  a7, 248
  ecall

  # check again by print end msg.
  la  a0, emsg
  li  a7, 248
  ecall

  # exit
  li  a7, 93
  li  a0, 0
  ecall

