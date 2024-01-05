#	.file	"testcalls.c"
#	.option nopic
#	.attribute arch, "rv32i2p1"
#	.attribute unaligned_access, 0
#	.attribute stack_align, 16
#	.text
	.section	.rodata
	.align	2
.LC0:
	.string	"Enter a number: "
	.align	2
.LC1:
	.string	"%d"
	.text
	.align	2
	.globl	inputNumber
	.type	inputNumber, @function
inputNumber:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	printf
	addi	a5,s0,-20
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	scanf
	lw	a5,-20(s0)
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	inputNumber, .-inputNumber
	.align	2
	.globl	addTen
	.type	addTen, @function
addTen:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	addi	a5,a5,10
	mv	a0,a5
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	addTen, .-addTen
	.section	.rodata
	.align	2
.LC2:
	.string	"Number plus 10 is %d\n"
	.text
	.align	2
	.globl	printNumber
	.type	printNumber, @function
printNumber:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a1,-20(s0)
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	printf
	nop
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printNumber, .-printNumber
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	call	inputNumber
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	addTen
	sw	a0,-20(s0)
	lw	a0,-20(s0)
	call	printNumber
	li	a5,0
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.ident	"GCC: (g2ee5e430018) 12.2.0"
