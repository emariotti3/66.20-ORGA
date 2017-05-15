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
	

.align	2
.ent issymbol
.globl issymbol

issymbol:
	.frame $fp,8,ra			
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp,sp,8
	.cprestore 4
	sw	$fp,0(sp)
	move $fp,sp

	li t0,64 # t0 = FILL_CHAR_POS
	li t1,62 # t1 = SYMBOL_POS = i
	

	ciclo: 	beq t0,t1,finIsSymbol #primer condicion
			la t2,letters  #dire de letters en t2
			add t2,t2,t1  #le sumo i
			lb t2,0(t2) #cargo el byte en t2+1
			beqz t2,finIsSymbol #segunda condicion de corte
			bne a0,t2,vueltaWhile #si letters i != c -> vuelta a while
			move a1,t1 # a1 = *index = i
			li v0,1 # 1 = true
			b retorno
			
	vueltaWhile: addi t1,t1,1 #i++
				 b ciclo
	
	finIsSymbol: li v0,0
	retorno:	lw $fp,0(sp)
				lw gp,4(sp)
				addu sp,sp,8
	
				j	ra
.end issymbol

.align 2
.globl	decode_to_output_file
.ent	decode_to_output_file
decode_to_output_file:
	.frame $fp,56,ra
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp,sp,56
	.cprestore 16
	sw	ra,48(sp)
	sw	$fp,44(sp)
	sw	gp,40(sp)
	move	$fp,sp
	sw	a0,56($fp)
	sw	a1,60($fp)
	sw	a2,64($fp)
	sw	a3,68($fp)
	addu	a0,$fp,24
	move	a1,zero
	li	a2,4
	la	t9,memset
	jal	ra,t9
	lw	v0,68($fp)
	lb	v0,0(v0)
	sll	v1,v0,2
	lw	v0,68($fp)
	addu	v0,v0,1
	lbu	v0,0(v0)
	andi	v0,v0,0x30
	sra	v0,v0,4
	or	v0,v1,v0
	sb	v0,24($fp)
	lw	v0,68($fp)
	addu	v0,v0,1
	lbu	v0,0(v0)
	andi	v0,v0,0xf
	sll	v1,v0,4
	lw	v0,68($fp)
	addu	v0,v0,2
	lbu	v0,0(v0)
	andi	v0,v0,0x3c
	sra	v0,v0,2
	or	v0,v1,v0
	sb	v0,25($fp)
	lw	v0,68($fp)
	addu	v0,v0,2
	lbu	v0,0(v0)
	andi	v0,v0,0x3
	sll	v1,v0,6
	lw	v0,68($fp)
	addu	v0,v0,3
	lbu	v0,0(v0)
	or	v0,v1,v0
	sb	v0,26($fp)
	li	v1,3			
	lw	v0,72($fp)
	subu	v0,v1,v0
	sw	v0,32($fp)
	lw	v0,64($fp)
	bne	v0,zero,jump
		
	li	v0, SYS_write # write file
	lw	a0, 60($fp)   # a0: me guardé el outfd
	addu a1, $fp, 24 
	lw	a2, 32($fp)    
	syscall
	
	sw	v0,36($fp)
	lw	v1,36($fp)
	li	v0,-1			
	bne	v1,v0,jump
	la	t9,__errno
	jal	ra,t9
	lw	v0,0(v0)
	sw	v0,64($fp)
jump:
	lw	v0,64($fp)
	move	sp,$fp
	lw	ra,48(sp)
	lw	$fp,44(sp)
	addu	sp,sp,56
	j	ra
.end	decode_to_output_file
