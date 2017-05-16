ENC_T_a1_OFF = 64
ENC_T_a0_OFF = 60
#--Stack:
ENC_T_SF_SZ = 60
ENC_T_RA_OFF = 52
ENC_T_FP_OFF = 48
ENC_T_GP_OFF = 44
ENC_T_STATE_OFF = 40
ENC_T_FILL_C_OFF = 36
ENC_T_READL_OFF = 28
ENC_T_QTY_READ_OFF = 24
ENCODE_a5_OFF = 20 
ENCODE_a4_OFF = 16 
ENCODE_a3_OFF = 12 
ENCODE_a2_OFF = 8 
ENCODE_a1_OFF = 4 
ENCODE_a0_OFF = 0
#--Fin Stack:
SUCCESS = 0
READ_LETTERS_SZ = 4
DECODED_GROUP_SZ = 4
.align	2
.ent encode_text
.globl encode_text
encode_text:
	.frame $fp, ENC_T_SF_SZ, ra
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp, sp, ENC_T_SF_SZ				#Creo el stack frame.
	.cprestore ENC_T_GP_OFF					#Guardo el gp(global pointer) en el stack.
	sw ra, ENC_T_RA_OFF(sp)					#Guardo el ra(return address) en el stack.
	sw $fp, ENC_T_FP_OFF(sp)				#Guardo el $fp(file pointer) en el stack.

	move $fp, sp							#Muevo el frame pointer a la base del stack.

	sw a0, ENC_T_a0_OFF($fp)				#Guardo los argumentos (int infd, int outfd) en el ABA de la callee.
	sw a1, ENC_T_a1_OFF($fp)

	sw SUCCESS, ENC_T_STATE_OFF($fp)		#Inicializo int state = SUCCESS en memoria.
	lw s0, ENC_T_STATE_OFF($fp)				#Regs[s0] <- state.

	lbu zero, ENC_T_FILL_C_OFF($fp)			#Cargo el caracter de relleno Regs[v0].
	move s1, v0								#Muevo el caracter de relleno('\0') a Regs[s1].

memset_read_letters:
	addiu a0, $fp, ENC_T_READL_OFF			#Regs[t0] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[t0].
	move a1, s1								#Muevo el caracter de relleno '=' de Regs[s1] a Regs[a1].
	li a2, READ_LETTERS_SZ 					#Cargo la cantidad READ_LETTERS_SZ en Regs[a2]. Esta es la cantidad de bytes que tiene que inicializar memset.
	la	t9,	memset 							#Llamado a memset
	jal	ra,	t9				

read_letters_enc:
	lw a0, ENC_T_a0_OFF($fp) 				#Regs[a0] <- infd
	addiu a1, $fp, ENC_T_READL_OFF			#Regs[a1] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[a1].
	li a2, DECODED_GROUP_SZ

	li	v0, SYS_read 						#Read file   
	syscall

	sw v0, ENC_T_QTY_READ_OFF($fp)			#Guardo la cantidad de bytes leidos en la variable qty_read en memoria. FALTA CONTROLAR a3 para ver si hay error.

while_encode:	
	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, write_extra_chars				#If(state != SUCCESS: Goto write_extra_chars

	lw t0, ENC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	seq t1, t0, DECODED_GROUP_SZ			#If(qty_read == DECODED_GROUP_SZ): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, write_extra_chars				#If(qty_read != DECODED_GROUP_SZ): Goto write_extra_chars

	lw t1, ENC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, ENC_T_a1_OFF($fp)				#Regs[t2] <- outfd

	li t0, DECODED_GROUP_SZ
	sw t0, ENCODE_a5_OFF($fp)				#Cargo en el stack el argumento 5 (DECODED_GROUP_SZ)
	sw s1, ENCODE_a4_OFF($fp)				#para llamar a la funcion 'decode'. Cargo el resto de los argumentos 
	addiu a3, $fp, ENC_T_READL_OFF			#(infd, outfd, read_letters y fill_character) en a0, a1, a2 y a3.
	move a2, s0								#Regs[a2] <- state. ESTO HAY QUE VOLARLO, NO SIRVE DE NADA PASAR state POR PARAMETRO.
	move a1, t2								#Regs[a1] <- outfd
	move a0, t1 							#Regs[a0] <- infd

	la t9, encode_text_to_output
	jal encode_text_to_output

	sw v0, ENC_T_STATE_OFF($fp) 			#Guardo el resultado de decode como 'state' en memoria.
	lw s0, ENC_T_STATE_OFF($fp)				#Regs[s0] <- state

	b memset_read_letters

write_extra_chars:
	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, end_encode_text				#If(state != SUCCESS): Goto end_encode_text.

	lw t0, ENC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	blez t0, end_encode_text				#If(qty_read <= 0): Goto end_encode_text

	lw t1, ENC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, ENC_T_a1_OFF($fp)				#Regs[t2] <- outfd

	sw t0, ENCODE_a5_OFF($fp)				#Cargo en el stack el argumento 5 (group_qty)
	sw s1, ENCODE_a4_OFF($fp)				#para llamar a la funcion 'decode'. Cargo el resto de los argumentos 
	addiu a3, $fp, ENC_T_READL_OFF			#(infd, outfd, read_letters y fill_character) en a0, a1, a2 y a3.
	move a2, s0								#Regs[a2] <- state. ESTO HAY QUE VOLARLO, NO SIRVE DE NADA PASAR state POR PARAMETRO.
	move a1, t2								#Regs[a1] <- outfd.
	move a0, t1 							#Regs[a0] <- infd.

	la t9, decode
	jal decode

end_encode_text:
	lw ra, ENC_T_RA_OFF(sp)					#Restauro el ra(return address).
	lw gp, ENC_T_GP_OFF(sp)					#Restauro el gp(global pointer).
	lw $fp, ENC_T_FP_OFF(sp)				#Restauro el $fp(file pointer).
	addiu sp, sp, ENC_T_SF_SZ

	jr ra
.end encode_text
