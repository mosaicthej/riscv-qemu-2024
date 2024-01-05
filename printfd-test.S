#	.file	"printfd-test.c"
#	.option nopic
#	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
#	.attribute unaligned_access, 0
#	.attribute stack_align, 16
#	.text
	.section	.rodata
	.align	3
#.LC0:
fmt:
	.string	"Answer %d %d %d %d %d             %d %d %d %d %d            %d %d %d %d %d\n"
.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-40
	sd	ra,36(sp)
	sd	s0,32(sp)
	addi	s0,sp,80
	li	a5,15
	sd	a5,56(sp)
	li	a5,14
	sd	a5,48(sp)
	li	a5,13
	sd	a5,40(sp)
	li	a5,12
	sd	a5,32(sp)
	li	a5,11
	sd	a5,24(sp)
	li	a5,10
	sd	a5,16(sp)
	li	a5,9
	sd	a5,8(sp)
	li	a5,8
	sd	a5,0(sp)
	li	a7,7
	li	a6,6
	li	a5,5
	li	a4,4
	li	a3,3
	li	a2,2
	li	a1,1
	la 	a0, str 
	call	printf
	li	a5,0
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
#	.size	main, .-main
#	.ident	"GCC: () 12.2.0"
