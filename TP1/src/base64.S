#include<mips/regdef.h>
#include<sys/syscall.h>

.data
str:  .asciiz "Hola\n"

.text
.abicalls
.ent saludar
.globl saludar

saludar: .frame $fp,16,ra
		.set noreorder
		.cpload t9
		.set reorder
		
		subu sp,sp,16
		sw $fp,0(sp)
		sw ra,8(sp)
		.cprestore 4
		
		
		li v0,SYS_write
		li a0,1 #stdout
		la a1,str
		li a2,5
        syscall
        
		addi v0,zero,8
		lw $fp,0(sp)
		lw gp,4(sp)
		lw ra,8(sp)
		addu sp,sp,16
		jr ra
		
.end saludar

.rdata
.align	2
.type	letters, @object
.size	letters, 65
letters:
	.byte 'A', .byte 'B', .byte 'C', .byte 'D', .byte 'E', .byte 'F', .byte 'G', .byte 'H', .byte 'I', .byte 'J', .byte 'K',
	.byte 'L', .byte 'M', .byte 'N', .byte 'O', .byte 'P', .byte 'Q', .byte 'R', .byte 'S', .byte 'T', .byte 'U', .byte 'V',
	.byte 'W', .byte 'X', .byte 'Y', .byte 'Z', .byte 'a', .byte 'b', .byte 'c', .byte 'd', .byte 'e', .byte 'f', .byte 'g',
	.byte 'h', .byte 'i', .byte 'j', .byte 'k', .byte 'l', .byte 'm', .byte 'n', .byte 'o', .byte 'p', .byte 'q', .byte 'r',
	.byte 's', .byte 't', .byte 'u', .byte 'v', .byte 'w', .byte 'x', .byte 'y', .byte 'z', .byte '0', .byte '1', .byte '2',
	.byte '3', .byte '4', .byte '5', .byte '6', .byte '7', .byte '8', .byte '9', .byte '+', .byte '/', .byte '='
.text
.align	2
