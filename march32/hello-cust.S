.section 	.rodata
.align 	2

str: 	
.string 	"Hello, World!"

.text
.align 	2
.globl 	main
#.type	main, @function

main:
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	addi	s0, sp, 16
	la	a0, str
	call	puts
	li	a5, 0
	mv	a0, a5
	lw	ra, 12(sp)
	lw	s0, 8(sp)
	addi	sp, sp, 16
	jr	ra
