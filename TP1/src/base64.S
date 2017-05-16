#include<mips/regdef.h>
#include<sys/syscall.h>

ENC_OUT_SF_SZ = 96
ENC_OUT_RA = 92
ENC_OUT_FP = 88
ENC_OUT_GP = 84
ENC_OUT_a4_OFF = 112
ENC_OUT_a3_OFF = 108
ENC_OUT_a2_OFF = 104
ENC_OUT_a1_OFF = 100
ENC_OUT_a0_OFF = 96

SHIFT_COUNT = 40
INDEX_OFF = 36
READ_BYTES_OFF = 32
GROUP_QTY_OFF = 28
MAX_GROUP_QTY_OFF = 24
ENCODED_CHARS_OFF = 52
STACK_PTR_OFF = 48
J_OFF = 44

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


.align 2
.globl	encode_text_to_output
.ent	encode_text_to_output
encode_text_to_output:
	.frame	$fp, ENC_OUT_SF_SZ, ra
	.set	noreorder
	.cpload	t9
	.set	reorder
	subu	sp,sp, ENC_OUT_SF_SZ
	.cprestore 16

	sw	ra, ENC_OUT_RA(sp)			#Guardo el ra(return address) actual.
	sw	$fp, ENC_OUT_FP(sp)			#Guardo el $fp(frame pointer) actual.
	sw	gp, ENC_OUT_GP(sp)			#Guardo el gp(global pointer) actual.
	sw	s0, 80(sp)					#Guardo el valor actual de s0 porque voy a usar este resgistro.

	move $fp, sp 					#Muevo el stack frame pointer a la base del stack.

	sw	a0, ENC_OUT_a0_OFF($fp)		#Guardo los parametros recibidos (int infd, int outfd, int state, 
	sw	a1, ENC_OUT_a1_OFF($fp)		#unsigned char *read_letters) en el ABA de la callee.
	sw	a2, ENC_OUT_a2_OFF($fp)
	sw	a3, ENC_OUT_a3_OFF($fp)

	sw	sp, STACK_PTR_OFF($fp)		#Guardo el valor actual del stack pointer.
	li	v0, 4		 				#Regs[v0] <- (DECODED_GROUP_SZ * BYTE_SZ) / GROUP_SZ (Esta operacion da 4).
	sw	v0, MAX_GROUP_QTY_OFF($fp) 	#Guardo el resultado de (DECODED_GROUP_SZ * BYTE_SZ) / GROUP_SZ en 'max_group_qty' en memoria.

	lw	v0, ENC_OUT_a4_OFF($fp)		#Cargo el 5to argumento en v0. Regs[v0] <- tot_read
	sll	v0, v0, 3					#Regs[v0] <- tot_read * BYTE_SZ(8) 

	mtc1	v0, $f0 				#Mover el contenido de Regs[v0]= (tot_read * BYTE_SZ) a registro de punto flotante en Coprocesador1.
	cvt.d.w	$f2,$f0 				#Convertir el contenido de Regs[f0] de Word a Double y guardar el resultado en Regs[f2].
	li.d $f0, 6 				#(l.d $f0, E1)	#Load FP double (E1 debe ser la constante GROUP_SZ).
	div.d	$f0,$f2,$f0 			#Regs[f0] <- (double)((tot_read * BYTE_SZ) / GROUP_SZ).
	mov.d	$f12,$f0 				#Mover el resultado cargado en Regs[f0] a registro de doble precision Regs[f12].
	la	t9, ceil 					#Cargo la direccion de 'ceil' en Regs[t9].
	jal	ra, t9 						#Llamo a la funcion 'ceil'.

	trunc.w.d $f0,$f0,v0 			#Regs[f0] <- (int)Regs[v0] (Casteo el resultado de 'ceil' y lo guardo en $f0).
	s.s	$f0, GROUP_QTY_OFF($fp)		#Guardo el resultado de la operacion en una variable en memoria('group_qty'). 

	sw	zero, READ_BYTES_OFF($fp) 	#Inicializo read_bytes = 0 en memoria.
	sw	zero, INDEX_OFF($fp)		#Inicializo index = 0 en memoria.
	sw	zero, SHIFT_COUNT($fp)		#Inicializo shift_count = 0 en memoria, con doble precision.


	lw	v0, MAX_GROUP_QTY_OFF($fp)		#Regs[v0] <- max_group_qty
	addiu	v0, v0, 1 			 		#Regs[v0] <- max_group_qty + 1
	addiu	v0, v0, 7 			 		#Regs[v0] <- max_group_qty + 1 + 7

	srl	v0, v0, 3  	#Elimino los ultimos 3 bits de 'max_group_qty' para que quede un multiplo de 8:
					
	sll	v0, v0, 3 	#Armo el espacio para el vector 'encoded_chars' en la base del stack: 

	subu	sp,	sp,	v0
	addu	v1, sp, 16 	#Subo 2 posiciones el sp:


	sw	v1, ENCODED_CHARS_OFF($fp)		#Guardo el puntero 'encoded_chars' en memoria: Regs[v1] -> Mem[encoded_chars]

	
	la	t9, get_fill_char				#Aca se traduce 2): Llamado a subrutina 'get_fill_char'
	jal	ra, t9
	lw	a0, ENCODED_CHARS_OFF($fp)		#Guardo el puntero 'encoded_chars' en a0: Regs[a0] <- Mem[encoded_chars].
	move	a1, v0						#Guardo el caracter '=' (obtenido de llamar a 'get_fill_char') en Regs[a1].
	lw	a2,	MAX_GROUP_QTY_OFF($fp)		#Cargo la variable 'max_group_qty' a Regs[a2].
	la	t9,	memset 						#Llamado a memset
	jal	ra,	t9				

	lw	a0,	ENC_OUT_a3_OFF($fp)			#Cargo el argumento 4 recibido (unsigned char *read_letters) a Regs[a0]
	la	t9,	concantenate_binary_to_int	#Llamado a subrutina 'concatenate_binary_to_int'
	jal	ra,	t9							
	sw	v0,	READ_BYTES_OFF($fp)			#Cargo la variable 'read_bytes' guardada en v0 (obtenida de llamar a 'concantenate_binary_to_int') en memoria.
	sw	zero,	J_OFF($fp)				#Inicializo j = 0 en memoria.
ENCODE_GROUP:
	lw	v0, J_OFF($fp)					#Regs[v0] <- j
	lw	v1, GROUP_QTY_OFF($fp)			#Regs[v1] <- group_qty
	slt	v0, v0, v1						#Si (j < group_qty): Regs[V0] = 1; else: Regs[0] = 0
	bne	v0, zero, FIND_INDEX			#Si Regs[v0] != 0 (o sea si j < group_qty), ir a FIND_INDEX
	b	WRITE
FIND_INDEX:
	lw	v1, MAX_GROUP_QTY_OFF($fp)		#Regs[v1] <- max_group_qty
	lw	v0, J_OFF($fp)					#Regs[v0] <- j
	subu	v0, v1, v0 					#Regs[v0] <- max_group_qty - j
	addu	v0, v0, -1 					#Regs[v0] <- max_group_qty - j - 1
	mtc1	v0, $f0						#Mover el contenido de Regs[v0](=max_group_qty-j-1) a registro de punto flotante en Coprocesador1.
	cvt.d.w	$f2, $f0 					#Convertir el contenido de Regs[f0] de Word a Double y guardar el resultado en Regs[f2].
	li.d $f0, 6 		#			#Cargo el inmediato GROUP_SZ en Reg[f0] de doble precision.
	mul.d	$f2,$f2,$f0					#Regs[f2] <- (max_group_qty-j-1)*GROUP_SZ
	li.d	$f0, 8 				#Cargo el inmediato BYTE_SZ en Reg[f0] de doble precision.
	add.d	$f2,$f2,$f0 				#Regs[f2] <- (max_group_qty-j-1)*GROUP_SZ + BYTE_SZ
	s.d	$f2, 56($fp)					#Guardo el resultado de la operacion (ahora guardado en Regs[f2]) en memoria, con doble precision.
	li.d	$f0, 63 					#Cargo MASK en Regs[f0] de doble precision.
	s.d	$f0, 72($fp)					#Guardo MASK en memoria.
	l.d	$f2, 56($fp)					#Regs[f2] <- (max_group_qty-j-1)*GROUP_SZ + BYTE_SZ

	l.d	$f0, 72($fp)
	c.le.d	$f0,$f2 					#If (Regs[f0](MASK) <= Regs[f2]): goto J4
	bc1t	J4
	l.d	$f0,56($fp)
	trunc.w.d $f0,$f0,v0
	s.s	$f0,64($fp)
	b	J5
J4:
	l.d	$f2,56($fp)
	l.d	$f4,72($fp)
	sub.d	$f0,$f2,$f4
	li	v0,-2147483648			# 0xffffffff80000000
	trunc.w.d $f2,$f0,a0
	s.s	$f2,64($fp)
	lw	v1,64($fp)
	or	v1,v1,v0
	sw	v1,64($fp)
J5:
	lw	a0,64($fp)
	sw	a0,40($fp)
	lw	v1,32($fp)
	lw	v0,40($fp)
	sra	v0,v1,v0
	andi	v0,v0,0x3f
	sw	v0,36($fp)
	lw	v0, J_OFF($fp)
	lw	a1,52($fp)
	addu	s0,a1,v0
	lw	a0,36($fp)
	la	t9,encode
	jal	ra,t9
	sb	v0,0(s0)
	lw	v0, J_OFF($fp)
	addu	v0,v0,1
	sw	v0, J_OFF($fp)
	b	ENCODE_GROUP
WRITE:
	lw	v0, ENC_OUT_a2_OFF($fp)		#Regs[v0] <- state
	bne	v0, zero, END 				#If(state != SUCCESS): goto END
	lw	a0, ENC_OUT_a1_OFF($fp)		#Regs[a0] <- outfd
	lw	a1, ENCODED_CHARS_OFF($fp)  #Regs[a1] <- encoded_chars
	lw	a2, MAX_GROUP_QTY_OFF($fp)  #Regs[a2] <- max_group_qty

	li	v0, SYS_write # write file   
	syscall

	sw	v0, 44($fp)					#Verifico si write me devolvio error(-1).
	lw	v1, 44($fp)
	li	v0,-1			
	bne	v1,v0,END 					#Si no hubo error, goto END.
	la	t9,__errno					#Si hubo error, devuelvo el codigo de error en v0
	jal	ra,t9
	lw	v0,0(v0)
	sw	v0, ENC_OUT_a2_OFF($fp) 	#y guardo el codigo de error en state: Regs[v0] -> Mem[state].

END:
	lw	v0, ENC_OUT_a2_OFF($fp) 	
	lw	sp, STACK_PTR_OFF($fp)		#Restauro el stack pointer
	move sp,$fp
	lw	ra, ENC_OUT_RA(sp)			#Restauro el ra(return address).
	lw	$fp, ENC_OUT_FP(sp)			#Restauro el $fp(frame pointer).
	lw	s0, 80(sp)
	addu	sp, sp, ENC_OUT_SF_SZ
	j	ra
.end	encode_text_to_output
