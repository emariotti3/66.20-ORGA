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

.align	2
.ent issymbol
.globl issymbol

issymbol:
	.frame $fp, 8, ra			
	.set noreorder
	.cpload	t9
	.set reorder
	subu sp, sp, 8
	.cprestore 4
	sw	$fp, 0(sp)
	move $fp, sp

	li t0, 64 								#t0 = FILL_CHAR_POS
	li t1, 62 								#t1 = SYMBOL_POS = i
	

	ciclo: 	beq t0, t1, finIsSymbol 		#primer condicion
			la t2, letters  				#dire de letters en t2
			add t2, t2, t1  				#le sumo i
			lb t2, 0(t2) 					#cargo el byte en t2+1
			beqz t2, finIsSymbol 			#segunda condicion de corte
			bne a0, t2, vueltaWhile 		#si letters i != c -> vuelta a while
			move a1, t1 					# a1 = *index = i
			li v0, 1 						# 1 = true
			b retorno
			
	vueltaWhile: addi t1,t1,1 #i++
				 b ciclo
	
	finIsSymbol: li v0,0
	retorno:	lw $fp,0(sp)
				lw gp,4(sp)
				addu sp,sp,8
	
				j	ra
.end issymbol

ENC_T_a1_OFF = 52
ENC_T_a0_OFF = 48
ENC_T_SF_SZ = 48
ENC_T_RA_OFF = 40
ENC_T_FP_OFF = 36
ENC_T_GP_OFF = 32
ENC_T_STATE_OFF = 28
ENC_T_READL_OFF = 24
ENC_T_QTY_READ_OFF = 20
SUCCESS = 0
READ_LETTERS_SZ = 4
DECODED_GROUP_SZ = 3
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

memset_read_letters:
	addiu a0, $fp, ENC_T_READL_OFF			#Regs[t0] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[t0].
	move a1, zero							#Muevo el caracter de relleno '\0' a Regs[a1].
	li a2, READ_LETTERS_SZ 					#Cargo la cantidad READ_LETTERS_SZ en Regs[a2]. Esta es la cantidad de bytes que tiene que inicializar memset.
	la	t9,	memset 							#Llamado a memset
	jal	ra,	t9								

read_letters:
	lw a0, ENC_T_a0_OFF($fp) 				#Regs[a0] <- infd
	addiu a1, $fp, ENC_T_READL_OFF			#Regs[a1] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[a1].
	li a2, DECODED_GROUP_SZ 

	li	v0, SYS_read 						#Read file   
	syscall

	sw v0, ENC_T_QTY_READ_OFF($fp)			#Guardo la cantidad de bytes leidos en la variable qty_read en memoria. FALTA CONTROLAR a3 para ver si hay error.

while_encode:	
	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, end_encode_text				#If(state != SUCCESS): Goto end_encode_text

	lw t0, ENC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	blez t0, end_encode_text    			#If(qty_read <= 0): Goto end_encode_text

	lw t1, ENC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, ENC_T_a1_OFF($fp)				#Regs[t2] <- outfd


	move a3, t0								#Regs[a3] <- qty_read
	addiu a2, $fp, ENC_T_READL_OFF			#Regs[a2] <- read_letters
	move a1, t2								#Regs[a1] <- outfd
	move a0, t1 							#Regs[a0] <- infd

	la t9, encode 							#Llamado a subrutina 'encode'
	jal encode

	sw v0, ENC_T_STATE_OFF($fp) 			#Guardo el resultado de decode como 'state' en memoria.
	lw s0, ENC_T_STATE_OFF($fp)				#Regs[s0] <- state

	b memset_read_letters

end_encode_text:
	lw v0, ENC_T_STATE_OFF($fp)				#Regs[v0] <- state

	lw ra, ENC_T_RA_OFF(sp)					#Restauro el ra(return address).
	lw gp, ENC_T_GP_OFF(sp)					#Restauro el gp(global pointer).
	lw $fp, ENC_T_FP_OFF(sp)				#Restauro el $fp(file pointer).
	addiu sp, sp, ENC_T_SF_SZ

	jr ra
.end encode_text

DEC_T_a1_OFF = 52
DEC_T_a0_OFF = 48
DEC_T_SF_SZ = 48
DEC_T_RA_OFF = 40
DEC_T_FP_OFF = 36
DEC_T_GP_OFF = 32
DEC_T_STATE_OFF = 28
DEC_T_READL_OFF = 24
DEC_T_QTY_READ_OFF = 20
SUCCESS = 0
ENCODED_GROUP_SZ = 4
FILL_CHAR_POS = 64
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

memset_read_letters:
	addiu a0, $fp, DEC_T_READL_OFF			#Regs[t0] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[t0].
	move a1, zero							#Muevo el caracter de relleno(0) a Regs[a1].
	li a2, ENCODED_GROUP_SZ 		
	addiu a2, a2, 1 						#Cargo la cantidad ENCODED_GROUP_SZ + 1 en Regs[a2]. Esta es la cantidad de bytes que tiene que inicializar memset.
	la	t9,	memset 							#Llamado a memset
	jal	ra,	t9				

read_letters:
	lw a0, DEC_T_a0_OFF($fp) 				#Regs[a0] <- infd
	addiu a1, $fp, DEC_T_READL_OFF			#Regs[a1] <- read_letters. Cargo la direccion inicial del array 'read_letters' en Regs[a1].
	li a2, ENCODED_GROUP_SZ

	li	v0, SYS_read 						#Read file   
	syscall

	sw v0, DEC_T_QTY_READ_OFF($fp)			#Guardo la cantidad de bytes leidos en la variable qty_read en memoria. FALTA CONTROLAR a3 para ver si hay error.

while_decode:	
	seq t1, s0, SUCCESS 					#If(state == SUCCESS): Regs[t0] <- 1 else: Regs[t0] <- 0.
	bnez t1, write_extra_chars				#If(state != SUCCESS: Goto write_extra_chars

	lw t0, DEC_T_QTY_READ_OFF($fp)			#Regs[t0] <- qty_read
	blez t0, end_decode_text    			#If(qty_read <= 0): Goto end_encode_text

	lw t1, DEC_T_a0_OFF($fp)				#Regs[t1] <- infd
	lw t2, DEC_T_a1_OFF($fp)				#Regs[t2] <- outfd

	move a3, t0								#Regs[a3] <- qty_read
	addiu a2, $fp, DEC_T_READL_OFF			#Regs[a2] <- read_letters
	move a1, t2								#Regs[a1] <- outfd
	move a0, t1 							#Regs[a0] <- infd

	la t9, encode 							#Llamado a subrutina 'encode'
	jal encode

	sw v0, DEC_T_STATE_OFF($fp) 			#Guardo el resultado de decode como 'state' en memoria.
	lw s0, DEC_T_STATE_OFF($fp)				#Regs[s0] <- state

	b memset_read_letters

end_decode_text:
	lw v0, DEC_T_STATE_OFF($fp)				#Regs[v0] <- state

	lw ra, DEC_T_RA_OFF(sp)					#Restauro el ra(return address).
	lw gp, DEC_T_GP_OFF(sp)					#Restauro el gp(global pointer).
	lw $fp, DEC_T_FP_OFF(sp)				#Restauro el $fp(file pointer).
	addiu sp, sp, DEC_T_SF_SZ

	jr ra
.end decode_text

DECODE_a3_OFF = 60
DECODE_a2_OFF = 56
DECODE_a1_OFF = 52
DECODE_a0_OFF = 48
DECODE_SF_SZ = 48

DECODE_s0_OFF = 52
DECODE_s1_OFF = 48
DECODE_s2_OFF = 44
DECODE_RA_OFF = 40
DECODE_FP_OFF = 36
DECODE_GP_OFF = 32
DECODE_BUFF_OFF = 28
DECODE_INDEXES_OFF = 24
DECODE_LEN_OFF = 20
DECODE_i_OFF = 16

DELTA_UPP = 65
DELTA_LOW = 71
DELTA_NUM = 4
ENCODED_GROUP_SZ = 4
INVALID_CHARACTER = 1
MIN_VAL_UPP = 65
MAX_VAL_UPP = 90
MIN_VAL_LOW = 97
MAX_VAL_LOW = 122
MIN_VAL_DIGIT = 48
MAX_VAL_DIGIT = 57
DMASK_1 = 0x30
DMASK_2 = 0xf
DMASK_3 = 0x3c
DMASK_4 = 0x3

    .align  2
    .globl  decode
    .ent    decode
decode:
    .frame  $fp, DECODE_SF_SZ, ra
    .set    noreorder
    .cpload t9
    .set    reorder
    subu    $sp, $sp, DECODE_SF_SZ
    .cprestore DECODE_GP_OFF                #Guardo el gp(global pointer) en el stack.
    sw ra, DECODE_RA_OFF(sp)                #Guardo el ra(return address) en el stack.
    sw $fp, DECODE_FP_OFF(sp)               #Guardo el $fp(file pointer) en el stack.

    move $fp, sp                            #Muevo el frame pointer a la base del stack.

    sw a0, DECODE_a0_OFF($fp)               #Guardo los argumentos (int infd, int outfd, int state, unsigned char *letters) en el ABA de la callee.
    sw a1, DECODE_a1_OFF($fp)
    sw a2, DECODE_a2_OFF($fp)
    sw a3, DECODE_a3_OFF($fp)

    sw s0, DECODE_S0_OFF($fp)				#Guardo los registros s0, s1 y s2.
    sw s1, DECODE_S1_OFF($fp)
#    sw s2, DECODE_S2_OFF($fp)

    li s0, zero 							#Regs[s0](i) <- 0.
    sw s0, DECODE_i_OFF($fp) 				#Inicializo la variable i en memoria.

	li s1, DECODED_GROUP_SZ 				#Regs[s1](len) <- DECODED_GROUP_SZ.
	sw s1, DECODE_LEN_OFF($fp) 				#Inicializo la variable len(Regs[s1]) en memoria.

for_decode:
	lw t0, DECODE_a3_OFF($fp) 				#Regs[t0] <- count
    bge s0, t0, write               		#If(i >= count): Goto write.

    sw t1, DECODE_a2_OFF($fp) 				#Regs[t1] <- read_letters 
    addu t1, t1, s0                         #Regs[t1] <- read_letters + i.
    lbu t2, t1                              #Regs[t2] <- read_letters[i].

if_fill_char:
	la t3, letters
	addiu t3, t3, FILL_CHAR_POS 			#Regs[t3] <- letters + FILL_CHAR_POS
	lbu t4, t3 								#Regs[t4] <- '='.
    addiu t5, $fp, DECODE_INDEXES_OFF       #Regs[t5] <- indexes
    addu t5, t5, s0                         #Regs[t5] <- indexes + i

    bne t2, t4, if_is_upper                 #If(read_letters[i] != '='): Goto if_is_upper.
    subu s1, s1, 1                          #len--
    sb zero, t5                             #indexes[i] = 0.
    b end_for

if_is_upper:
    blt t2, MIN_VAL_UPP, if_is_lower        #Si read_letters[i] es menor que el minimo valor de las letras mayusculas: Goto if_is_lower.
    bgt t2, MIN_VAL_UPP, if_is_lower        #Si read_letters[i] es mayor que el máximo valor de las letras mayusculas: Goto if_is_lower.    
    subiu t6, t2, DELTA_UPP                 #Regs[t6] <- read_letters[i] - DELTA_UPP

    sb t6, t5                               #indexes[i] <- Regs[t6] (read_letters[i] - DELTA_UPP).
    b end_for

if_is_lower:
    blt t2, MIN_VAL_LOW, if_is_digit        #Si read_letters[i] es menor que el minimo valor de las letras minúsculas: Goto if_is_digit.
    bgt t2, MIN_VAL_LOW, if_is_digit        #Si read_letters[i] es mayor que el máximo valor de las letras minúsculas: Goto if_is_digit.    
    subiu t6, t2, DELTA_LOW                 #Regs[t6] <- read_letters[i] - DELTA_LOW

    sb t6, t5                               #indexes[i] <- Regs[t6] (read_letters[i] - DELTA_LOW).
    b end_for

if_is_digit:
    blt t2, MIN_VAL_DIGIT, if_not_is_sym    #Si read_letters[i] es menor que el minimo valor de las dígitos: Goto if_not_is_sym.
    bgt t2, MIN_VAL_DIGIT, if_not_is_sym    #Si read_letters[i] es mayor que el máximo valor de las dígitos: Goto if_not_is_sym.    
    subiu t6, t2, DELTA_NUM                 #Regs[t6] <- read_letters[i] - DELTA_NUM
 
    sb t6, t5                               #indexes[i] <- Regs[t6] (read_letters[i] - DELTA_NUM).
    b end_for

if_not_is_sym:
    move a0, t1 	            			#Regs[a0] <- read_letters + i.
    move a1, t5 		                    #Regs[a1] <- indexes + i.

    la t9, issymbol                         #Llamado a la subrutina 'issymbol'.
    jalr t9
    beqz v0, end_decode_error               #If(v0 == 0) (es decir, issymbol(read_letters +i, indexes + i) = False): Goto end_decode_error.
    
end_for:
    addiu s0, s0, 1                         #Regs[s0] <- i + 1
    lw s0, DECODE_i_OFF($fp)                #Actualizo la variable i en el stack.
    b for_decode

write:
    addiu t0, $fp, DECODE_INDEXES_OFF       #Regs[t0] <- indexes.
    addiu t1, $fp, DECODE_BUFF_OFF 			#Regs[t1] <- buff.	

	lbu t2, t0 								#Regs[t2] <- indexes[0].
	sll t2, t2, 2 							#Regs[t2] <- indexes[0] << 2.

	addiu t3, t0, 1							#Regs[t3] <- indexes + 1.
	lbu t3, t3 								#Regs[t3] <- indexes[1].
	li t4, DMASK_1 							#Regs[t4] <- 0x30
	and t4, t3, t4 							#Regs[t4] <- indexes[1] and 0x30.						
	srl t4, t4, 4 							#Regs[t4] <- (indexes[1] and 0x30) >> 4.						

	or t5, t2, t4 							#Regs[t5] <-  (indexes[0] << 2) | ((indexes[1] and 0x30) >> 4).						
	sb t5, t1 								#buff[0] <- Regs[t5]


    li t2, DMASK_2 							#Regs[t2] <- DMASK_2.
    and t3, t3, t2							#Regs[t3] <- indexes[1] and DMASK_2. (Regs[t3] contiene indexes[1]).
    sll t3, t3, 4 							#Regs[t3] <- (indexes[1] & DMASK_2) << 4).
	addiu t4, t4, 2 						#Regs[t4] <- indexes + 2.
	lbu t4, t4 								#Regs[t4] <- indexes[2].
	li t5, DMASK_3 							#Regs[t5] <- DMASK_3.
	and t5, t4, t5 							#Regs[t5] <- indexes[2] & DMASK_3.
	srl t5, t5, 2 							#Regs[t5] <- (indexes[2] & DMASK_3)>>2.
	or t6, t4, t5 							#Regs[t6] <- (indexes[1] & DMASK_2) << 4) or ((indexes[2] & DMASK_3)>>2).

    addiu t1, t1, 1 			 			#Regs[t1] <- buff + 1.
	sb t6, t1                               #buff[1] <- (indexes[1] & DMASK_2) << 4) or ((indexes[2] & DMASK_3)>>2).
	
	li t2, DMASK_4 							#Regs[t2] <- DMASK_4
	and t3, t4, t2 							#Regs[t3] <- indexes[2] and DMASK_4. (Regs[t4] contiene indexes[2]).
	sll t3, t3, 6 							#Regs[t3] <- (indexes[2] and DMASK_4) << 6.
	
	addiu t5, t0, 3 						#Regs[t5] <- indexes + 3
	lbu t5, t5 								#Regs[t5] <- indexes[3]
	or t6, t3, t5 							#Regs[t6] <- ((indexes[2] and DMASK_4) << 6) or indexes[3].

    addiu t1, t1, 1 			 			#Regs[t1] <- buff + 2.
    sb t6, t1 								#buff[2] <- ((indexes[2] and DMASK_4) << 6) or indexes[3].

	lw a0, DEC_T_a1_OFF($fp) 				#Regs[a0] <- outfd.
	addiu a1, $fp, DEC_T_BUFF_OFF			#Regs[a1] <- buff. Cargo la direccion inicial del array 'buff' en Regs[a1].
	move a2, s1 							#Regs[a2] <- Regs[s1] (len).

	li	v0, SYS_write 						#Write file.   
	syscall

	bnez a3, SUCCESS, end_decode 			#Si hubo error de escritura, Goto end_decode. El error esta cargado en v0.
	li v0, SUCCESS 							#Si no, cargo SUCCESS en v0.
	b end_decode

end_decode_error:
    li v0, INVALID_CHARACTER                #Devuelvo un error porque se encontro un caracter invalido durante la decodificacion.

end_decode:
    lw s0, DECODE_S0_OFF($fp)               #Restauro el valor de Regs[s0].
    lw s1, DECODE_S1_OFF($fp)               #Restauro el valor de Regs[s1].
#    lw s2, DECODE_S2_OFF($fp)               #Restauro el valor de Regs[s2].

    lw ra, DECODE_RA_OFF(sp)                #Restauro el ra(return address).
    lw gp, DECODE_GP_OFF(sp)                #Restauro el gp(global pointer).
    lw $fp, DECODE_FP_OFF(sp)               #Restauro el $fp(file pointer).
    addiu sp, sp, DECODE_SF_SZ

    jr ra
    .end decode


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

.align 2
.globl	encode
.ent	encode
encode:
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
	li.d $f0, 6 					#(l.d $f0, E1)	#Load FP double (E1 debe ser la constante GROUP_SZ).
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

	
	la	t0, letters
	addiu t0, t0, FILL_CHAR_POS 
	lbu t1, t0 							#Regs[t0] <- '='
	lw	a0, ENCODED_CHARS_OFF($fp)		#Guardo el puntero 'encoded_chars' en a0: Regs[a0] <- Mem[encoded_chars].
	move	a1, t0						#Guardo el caracter '=' (obtenido de llamar a 'get_fill_char') en Regs[a1].
	lw	a2,	MAX_GROUP_QTY_OFF($fp)		#Cargo la variable 'max_group_qty' a Regs[a2].
	la	t9,	memset 						#Llamado a memset
	jal	ra,	t9				


#ACA INSERTAR concatenate_byte_to_binary:
#    for(int i = 0; i < sizeof(int); ++i){
#        read_bytes = read_bytes | (read_letters[i] << (sizeof(int) -1 -i)*BYTE_SZ);
#    }
						
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
.end	encode
