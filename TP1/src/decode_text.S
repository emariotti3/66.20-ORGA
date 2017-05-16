DEC_T_a1_OFF = 64
DEC_T_a0_OFF = 60

DEC_T_SF_SZ = 60
DEC_T_RA_OFF = 52
DEC_T_FP_OFF = 48
DEC_T_GP_OFF = 44
DEC_T_STATE_OFF = 40
DEC_T_FILL_C_OFF = 36
DEC_T_READL_OFF = 28
DEC_T_QTY_READ_OFF = 24

DECODE_a5_OFF = 20 
DECODE_a4_OFF = 16 
DECODE_a3_OFF = 12 
DECODE_a2_OFF = 8 
DECODE_a1_OFF = 4 
DECODE_a0_OFF = 0

SUCCESS = 0
ENCODED_GROUP_SZ = 4
.align	2
.ent decode_text
.globl decode_text
decode_text:
	.frame $fp, DEC_T_SF_SZ, ra
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp, sp, DEC_T_SF_SZ				#Creo el stack frame.
	.cprestore DEC_T_GP_OFF					#Guardo el gp(global pointer) en el stack.
	sw ra, DEC_T_RA_OFF(sp)					#Guardo el ra(return address) en el stack.
	sw $fp, DEC_T_FP_OFF(sp)				#Guardo el $fp(file pointer) en el stack.

	move $fp, sp							#Muevo el frame pointer a la base del stack.

	sw a0, DEC_T_a0_OFF($fp)				#Guardo los argumentos (int infd, int outfd) en el ABA de la callee.
	sw a1, DEC_T_a1_OFF($fp)

	sw SUCCESS, DEC_T_STATE_OFF($fp)		#Inicializo int state = SUCCESS en memoria.
	lw s0, DEC_T_STATE_OFF($fp)				#Regs[s0] <- state.

	jal get_fill_char						#Llamo a la subrutina 'get_fill_char'.
	lbu v0, DEC_T_FILL_C_OFF($fp)			#Cargo el caracter de relleno Regs[v0].
	move s1, v0								#Muevo el caracter de relleno('=') a Regs[s1].

memset_read_letters:
	addiu a0, $fp, DEC_T_READL_OFF			#Regs[t0] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[t0].
	move a1, s1								#Muevo el caracter de relleno '=' de Regs[s1] a Regs[a1].
	li a2, ENCODED_GROUP_SZ 		
	addiu a2, a2, 1 						#Cargo la cantidad ENCODED_GROUP_SZ + 1 en Regs[a2]. Esta es la cantidad de bytes que tiene que inicializar memset.
	la	t9,	memset 							#Llamado a memset
	jal	ra,	t9				

read_letters_enc:
	lw a0, DEC_T_a0_OFF($fp) 				#Regs[a0] <- infd
	addiu a1, $fp, DEC_T_READL_OFF			#Regs[a1] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[a1].
	li a2, ENCODED_GROUP_SZ

	li	v0, SYS_read 						#Read file   
	syscall

	sw v0, DEC_T_QTY_READ_OFF($fp)			#Guardo la cantidad de bytes leidos en la variable qty_read en memoria. FALTA CONTROLAR a3 para ver si hay error.

while_encode:	
	lw t0, DEC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	seq t1, t0, ENCODED_GROUP_SZ			#If(qty_read == ENCODED_GROUP_SZ): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, write_extra_chars				#If(qty_read != ENCODED_GROUP_SZ): Goto write_extra_chars

	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, write_extra_chars				#If(state != SUCCESS: Goto write_extra_chars

	lw t1, DEC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, DEC_T_a1_OFF($fp)				#Regs[t2] <- outfd

	li t0, ENCODED_GROUP_SZ
	sw t0, DECODE_a5_OFF($fp)				#Cargo en el stack el argumento 5 (ENCODED_GROUP_SZ)
	sw s1, DECODE_a4_OFF($fp)				#para llamar a la funcion 'decode'. Cargo el resto de los argumentos 
	addiu a3, $fp, DEC_T_READL_OFF			#(infd, outfd, read_letters y fill_character) en a0, a1, a2 y a3.
	move a2, s0								#Regs[a2] <- state. ESTO HAY QUE VOLARLO, NO SIRVE DE NADA PASAR state POR PARAMETRO.
	move a1, t2								#Regs[a1] <- outfd
	move a0, t1 							#Regs[a0] <- infd

	la t9, decode
	jal decode

	sw v0, DEC_T_STATE_OFF($fp) 			#Guardo el resultado de decode como 'state' en memoria.
	lw s0, DEC_T_STATE_OFF($fp)				#Regs[s0] <- state

	b memset_read_letters

write_extra_chars:
	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, end_decode_text				#If(state != SUCCESS): Goto end_decode_text.

	lw t0, DEC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	blez t0, end_decode_text				#If(qty_read <= 0): Goto end_decode_text

	lw t1, DEC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, DEC_T_a1_OFF($fp)				#Regs[t2] <- outfd

	sw t0, DECODE_a5_OFF($fp)				#Cargo en el stack el argumento 5 (group_qty)
	sw s1, DECODE_a4_OFF($fp)				#para llamar a la funcion 'decode'. Cargo el resto de los argumentos 
	addiu a3, $fp, DEC_T_READL_OFF			#(infd, outfd, read_letters y fill_character) en a0, a1, a2 y a3.
	move a2, s0								#Regs[a2] <- state. ESTO HAY QUE VOLARLO, NO SIRVE DE NADA PASAR state POR PARAMETRO.
	move a1, t2								#Regs[a1] <- outfd.
	move a0, t1 							#Regs[a0] <- infd.

	la t9, decode
	jal decode

end_decode_text:
	lw ra, DEC_T_RA_OFF(sp)					#Restauro el ra(return address).
	lw gp, DEC_T_GP_OFF(sp)					#Restauro el gp(global pointer).
	lw $fp, DEC_T_FP_OFF(sp)				#Restauro el $fp(file pointer).
	addiu sp, sp, DEC_T_SF_SZ

	jr ra
.end decode_text
