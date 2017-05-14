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
	
.text
.align	2

BASE64_SF_SIZE = 48
BASE64_RA = 40
BASE64_FP = 36
BASE64_GP = 32

BASE64_a3_OFF = 60
BASE64_a2_OFF = 56
BASE64_a1_OFF = 52
BASE64_a0_OFF = 48

STRUCT_ENCDEC_SZ = 16	#Tamano en bytes del struct EncDec_t + padding
BASE64_STRUCT_OFF = 16	#Direccion de inicio del struct en el stack

base64_encode:
	.frame	$fp, BASE64_SF_SIZE, ra 	#El stack frame tiene un tamano igual a BASE64_SF_SIZE
	.set noreorder
	.cpload	t9
	.set reorder
	subu $sp,$sp, BASE64_SF_SIZE

	.cprestore BASE64_GP				#Guardo el gp(global pointer) actual
	sw $fp, BASE64_FP($sp)				#Guardo el $fp(frame pointer) actual
	sw ra, BASE64_RA($sp)				#Guardo el ra(return address) actual.

	move $fp, $sp						#Muevo el $fp a la base del stack frame.

	sw a0, BASE64_a0_OFF($fp)			#Guardo los argumentos en el ABA de la callee.
	sw a1, BASE64_a1_OFF($fp)
	sw a2, BASE64_a2_OFF($fp)
	sw a3, BASE64_a3_OFF($fp)

	addiu a0, $fp, BASE64_STRUCT_OFF	#Regs[a0] <-- Direccion de inicio de variable EncDec_t encdec.
	lw a1, BASE64_a0_OFF($fp)			#Regs[a1] <-- infd.
	lw a2, BASE64_a1_OFF($fp)			#Regs[a2] <-- outfd.

	la t9, init_encdec
	jalr t9								#Llamo a la funcion init_encdec

	addiu a0, $fp, BASE6_STRUCT_OFF	#Regs[a0] <-- Direccion de inicio de variable EncDec_t encdec.
	la t9, encode_text
	jalr t9								#Llamo a la funcion encode_text

	lw gp, BASE6_GP($sp)				#Restauro el gp(global pointer).
	lw ra, BASE6_RA($sp)				#Restauro el ra(return address).
	lw $fp, BASE6_FP($sp)				#Restauro el $fp(frame pointer).
	addiu $sp, $sp, BASE6_SF_SIZE 		#Restauro el $sp(stack pointer).

	jr ra 								#Retorno. 
	.end	base64_encode
	.size	base64_encode, .-base64_encode

base64_decode:
	.frame	$fp, BASE64_SF_SIZE, ra 	#El stack frame tiene un tamano igual a BASE64_SF_SIZE
	.set noreorder
	.cpload	t9
	.set reorder
	subu $sp,$sp, BASE64_SF_SIZE

	.cprestore BASE64_GP				#Guardo el gp(global pointer) actual
	sw $fp, BASE64_FP($sp)				#Guardo el $fp(frame pointer) actual
	sw ra, BASE64_RA($sp)				#Guardo el ra(return address) actual.

	move $fp, $sp						#Muevo el $fp a la base del stack frame.

	sw a0, BASE64_a0_OFF($fp)			#Guardo los argumentos en el ABA de la callee.
	sw a1, BASE64_a1_OFF($fp)
	sw a2, BASE64_a2_OFF($fp)
	sw a3, BASE64_a3_OFF($fp)

	addiu a0, $fp, BASE64_STRUCT_OFF	#Regs[a0] <-- Direccion de inicio de variable EncDec_t encdec.
	lw a1, BASE64_a0_OFF($fp)			#Regs[a1] <-- infd.
	lw a2, BASE64_a1_OFF($fp)			#Regs[a2] <-- outfd.

	la t9, init_encdec
	jalr t9								#Llamo a la funcion init_encdec

	addiu a0, $fp, BASE6_STRUCT_OFF		#Regs[a0] <-- Direccion de inicio de variable EncDec_t encdec.
	la t9, decode_text
	jalr t9								#Llamo a la funcion decode_text

	lw gp, BASE6_GP($sp)				#Restauro el gp(global pointer).
	lw ra, BASE6_RA($sp)				#Restauro el ra(return address).
	lw $fp, BASE6_FP($sp)				#Restauro el $fp(frame pointer).
	addiu $sp, $sp, BASE6_SF_SIZE 		#Restauro el $sp(stack pointer).

	jr ra 								#Retorno. 
	.end	base64_decode
	.size	base64_decode, .-base64_decode



