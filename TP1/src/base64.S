#include<mips/regdef.h>
#include<sys/syscall.h>

.rdata
.align	2
.type	letters, @object
.size	letters, 65
letters:
	.byte 65
	.byte 66
	.byte 67
	.byte 68
	.byte 69
	.byte 70
	.byte 71
	.byte 72
	.byte 73
	.byte 74
	.byte 75
	.byte 76
	.byte 77
	.byte 78
	.byte 79
	.byte 80
	.byte 81
	.byte 82
	.byte 83
	.byte 84
	.byte 85
	.byte 86
	.byte 87
	.byte 88
	.byte 89
	.byte 90
	.byte 97
	.byte 98
	.byte 99
	.byte 100
	.byte 101
	.byte 102
	.byte 103
	.byte 104
	.byte 105
	.byte 106
	.byte 107
	.byte 108
	.byte 109
	.byte 110
	.byte 111
	.byte 112
	.byte 113
	.byte 114
	.byte 115
	.byte 116
	.byte 117
	.byte 118
	.byte 119
	.byte 120
	.byte 121
	.byte 122
	.byte 48
	.byte 49
	.byte 50
	.byte 51
	.byte 52
	.byte 53
	.byte 54
	.byte 55
	.byte 56
	.byte 57
	.byte 43
	.byte 47
	.byte 61
	
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


.align	2
.ent get_fill_char
.globl get_fill_char

get_fill_char:

	.frame $fp,8,ra			
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp,sp,8
	.cprestore 4
	sw	$fp,0(sp)
	move $fp,sp
	
	lb	t1,letters+64  
	
	lw $fp,0(sp)
	lw gp,4(sp)
	addu sp,sp,8
	move v0,t1  #cargo el igual en v0 para retornarlo
	j	ra
.end	get_fill_char


.align	2
.ent encode
.globl encode

encode:
	.frame $fp,8,ra			
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp,sp,8
	.cprestore 4
	sw	$fp,0(sp)
	move $fp,sp
	
	la	v0,letters
	addu v0,a0,v0
	lb	v0,0(v0) #letter en v0
	
	lw $fp,0(sp)
	lw gp,4(sp)
	addu sp,sp,8
	
	j	ra
.end encode


.align	2
.ent concantenate_binary_to_int
.globl concantenate_binary_to_int

concantenate_binary_to_int:
	.frame $fp,8,ra			
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp,sp,8
	.cprestore 4
	sw	$fp,0(sp)
	move $fp,sp
	
	li t0,0 # t0 = i
	li t1,0 # t1 = number
	li t2,4 # t2 = sizeof(int)
	
	while: 	beq t0,t2,finConcatenate
			li t3,3 # t3 = sizeof(int)-1
			subu t3,t3,t0 # t3 = sizeof(int)-1 - i
			sll t3,t3,3 # t3 = t3>>3 = t3*8 = t3*BYTE_SZ
			addu t4,t0,a0 #characters i
			lb t4,0(t4) 
			sll t4,t4,t3
			or t1,t1,t4
			addi t0,t0,1
			b while			
	
	finConcatenate: move v0,t1
					lw $fp,0(sp)
					lw gp,4(sp)
					addu sp,sp,8
	
					j	ra
.end concantenate_binary_to_int
	
