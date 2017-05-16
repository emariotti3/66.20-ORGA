DECODE_a5_OFF = 68
DECODE_a4_OFF = 64
DECODE_a3_OFF = 60
DECODE_a2_OFF = 56
DECODE_a1_OFF = 52
DECODE_a0_OFF = 48

#--Stack:
DECODE_SF_SZ = 64
DECODE_S2_OFF = 60
DECODE_S1_OFF = 56
DECODE_S0_OFF = 52
DECODE_RA_OFF = 48
DECODE_FP_OFF = 44
DECODE_GP_OFF = 40
DECODE_INDEXES_OFF = 32
DECODE_PADD_OFF = 28
DECODE_i_OFF = 24
DECODE_T_OUT_a4_OFF = 16
DECODE_T_OUT_a3_OFF = 12
DECODE_T_OUT_a2_OFF = 8
DECODE_T_OUT_a1_OFF = 4
DECODE_T_OUT_a0_OFF = 0
#--Fin Stack

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

    sw a0, DECODE_a0_OFF($fp)                #Guardo los argumentos (int infd, int outfd, int state, unsigned char *letters) en el ABA de la callee.
    sw a1, DECODE_a1_OFF($fp)
    sw a2, DECODE_a2_OFF($fp)
    sw a3, DECODE_a3_OFF($fp)

    sw s0, DECODE_S0_OFF($fp)               #Guardo el valor actual de Regs[s0] en el stack porque voy a usar el registro.
    sw s1, DECODE_S1_OFF($fp)               #Guardo el valor actual de Regs[s1] en el stack porque voy a usar el registro.
    sw s2, DECODE_S2_OFF($fp)               #Guardo el valor actual de Regs[s2] en el stack porque voy a usar el registro.
memset_indexes:
    addiu a0, $fp, DECODE_INDEXES_OFF       #Regs[t0] <- indexes. Cargo la direccion inicial del array 'indexes' en Regs[t0].
    move a1, zero                           #Muevo el caracter de relleno '\0' a Regs[a1].
    li a2, ENCODED_GROUP_SZ                 #Cargo la cantidad ENCODED_GROUP_SZ+1 en Regs[a2]. Esta es la cantidad de bytes que tiene que inicializar memset.
    addiu a2, a2, 1
    la  t9, memset                          #Llamado a memset
    jal ra, t9              

    sw zero, DECODE_PADD_OFF($fp)           #Inicializo 'padding' a 0 en memoria.
    lw s0, DECODE_PADD_OFF($fp)             #Regs[s0] <- padding.
    sw zero, DECODE_i_OFF($fp)              #Inicializo 'i' a 0 en memoria.
    lw s1, DECODE_i_OFF($fp)                #Regs[s1] <- i.

for_decode:
    lw t0, DECODE_a5_OFF($fp)               #Regs[t0] <- count.
    bge s1, t0, end_decode_ok               #If(i >= count): Goto end_decode_ok.

    addiu t1, $fp, DECODE_a3_OFF            #Regs[t1] <- letters
    addu t1, s1, t1                         #Regs[t1] <- letters + i.
    lbu s2, t1                              #Regs[s2] <- letters[i].

if_fill_char:
    lbu t3, DECODE_a4_OFF($fp)              #Regs[t3] <- fill_character.
    bne s2, t3, if_is_upper                 #If(letters[i] != fill_character): Goto if_is_upper.
    addiu s0, s0, 1                         #padding++
    addiu t4, $fp, DECODE_INDEXES_OFF       #Regs[t4] <- indexes
    addu t4, s1, t4                         #Regs[t4] <- indexes + i
    sb zero, t4                             #indexes[i] = 0.
    b end_for

if_is_upper:
    blt s2, MIN_VAL_UPP, if_is_lower        #Si letters[i] es menor que el minimo valor de las letras mayusculas: Goto if_is_lower.
    bgt s2, MIN_VAL_UPP, if_is_lower        #Si letters[i] es mayor que el máximo valor de las letras mayusculas: Goto if_is_lower.    
    subiu t0, s2, DELTA_UPP                 #Regs[t0] <- letters[i] - DELTA_UPP
    addiu t1, $fp, DECODE_INDEXES_OFF       #Regs[t1] <- indexes.    
    addiu t1, s1, a1                        #Regs[t1] <- indexes + i.
    sb t0, t1                               #indexes[i] <- Regs[t0] (letters[i] - DELTA_UPP).
    b end_for

if_is_lower:
    blt s2, MIN_VAL_LOW, if_is_digit        #Si letters[i] es menor que el minimo valor de las letras minúsculas: Goto if_is_digit.
    bgt s2, MIN_VAL_LOW, if_is_digit        #Si letters[i] es mayor que el máximo valor de las letras minúsculas: Goto if_is_digit.    
    subiu t0, s2, DELTA_LOW                 #Regs[t0] <- letters[i] - DELTA_LOW
    addiu t1, $fp, DECODE_INDEXES_OFF       #Regs[t1] <- indexes.    
    addiu t1, s1, a1                        #Regs[t1] <- indexes + i.
    sb t0, t1                               #indexes[i] <- Regs[t0] (letters[i] - DELTA_LOW).
    b end_for

if_is_digit:
    blt s2, MIN_VAL_DIGIT, if_not_is_sym    #Si letters[i] es menor que el minimo valor de las dígitos: Goto if_not_is_sym.
    bgt s2, MIN_VAL_DIGIT, if_not_is_sym    #Si letters[i] es mayor que el máximo valor de las dígitos: Goto if_not_is_sym.    
    subiu t0, s2, DELTA_NUM                 #Regs[t0] <- letters[i] - DELTA_NUM
    addiu t1, $fp, DECODE_INDEXES_OFF       #Regs[t1] <- indexes.    
    addiu t1, s1, a1                        #Regs[t1] <- indexes + i.
    sb t0, t1                               #indexes[i] <- Regs[t0] (letters[i] - DELTA_NUM).
    b end_for

if_not_is_sym:
    addiu a0, $fp, DECODE_a3_OFF            #Regs[a0] <- letters.
    addiu a0, s1, a0                        #Regs[a0] <- letters + 1.
    addiu a1, $fp, DECODE_INDEXES_OFF       #Regs[a1] <- indexes.    
    addiu a1, s1, a1                        #Regs[a1] <- indexes + i.

    la t9, issymbol                         #Llamado a la subrutina 'issymbol'.
    jalr t9
    beqz v0, end_decode_error               #If(v0 == 0) (es decir, issymbol(letters +i, indexes + i) = False): Goto end_decode_error.
    
end_for:
    addiu s1, s1, 1                         #Regs[s1] <- i + 1
    lw s1, DECODE_i_OFF($fp)                #Actualizo la variable i en el stack.
    b for_decode

end_decode_ok:
    sw s0, DECODE_T_OUT_a4_OFF($fp)         #Cargo el 5to parametro('padding') de 'decode_to_output_file' en el stack.
    addiu a3, $fp, DECODE_INDEXES_OFF       #Regs[a3] <- indexes
    lw a2, DECODE_a2_OFF($fp)               #Regs[a2] <- state. ESTO HAY QUE SACARLO PORQUE NO SIRVE PARA NADA.
    lw a1, DECODE_a1_OFF($fp)               #Regs[a1] <- outfd
    lw a0, DECODE_a0_OFF($fp)               #Regs[a0] <- infd

    la t9, decode_to_output_file            #Llamado a subrutina 'decode_to_output_file'. El valor de retorno no lo modifico.
    jalr t9

    b end_decode

end_decode_error:
    li v0, INVALID_CHARACTER                #Devuelvo un error porque se encontro un caracter invalido durante la decodificacion.

end_decode:
    lw s0, DECODE_S0_OFF($fp)               #Restauro el valor de Regs[s0].
    lw s1, DECODE_S1_OFF($fp)               #Restauro el valor de Regs[s1].
    lw s2, DECODE_S2_OFF($fp)               #Restauro el valor de Regs[s2].

    lw ra, DECODE_RA_OFF(sp)                 #Restauro el ra(return address).
    lw gp, DECODE_GP_OFF(sp)                 #Restauro el gp(global pointer).
    lw $fp, DECODE_FP_OFF(sp)                #Restauro el $fp(file pointer).
    addiu sp, sp, DECODE_SF_SZ

    jr ra
    .end decode