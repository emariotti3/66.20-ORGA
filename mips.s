	.section .mdebug.abi32
	.previous
	.abicalls
	.file 1 "main.c"
	.section	.debug_abbrev,"",@progbits
$Ldebug_abbrev0:
	.section	.debug_info,"",@progbits
$Ldebug_info0:
	.section	.debug_line,"",@progbits
$Ldebug_line0:
	.text
$Ltext0:
	.file 2 "/usr/include/mips/int_types.h"
	.file 3 "/usr/include/sys/ansi.h"
	.file 4 "/usr/include/mips/ansi.h"
	.file 5 "/usr/include/stdio.h"
	.file 6 "/usr/include/mips/types.h"
	.file 7 "/usr/include/sys/types.h"
	.file 8 "/usr/include/sys/endian.h"
	.file 9 "/usr/include/pthread_types.h"
	.file 10 "/usr/include/stdlib.h"
	.rdata
	.align	2
	.type	b64_table, @object
	.size	b64_table, 64
b64_table:
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.byte	71
	.byte	72
	.byte	73
	.byte	74
	.byte	75
	.byte	76
	.byte	77
	.byte	78
	.byte	79
	.byte	80
	.byte	81
	.byte	82
	.byte	83
	.byte	84
	.byte	85
	.byte	86
	.byte	87
	.byte	88
	.byte	89
	.byte	90
	.byte	97
	.byte	98
	.byte	99
	.byte	100
	.byte	101
	.byte	102
	.byte	103
	.byte	104
	.byte	105
	.byte	106
	.byte	107
	.byte	108
	.byte	109
	.byte	110
	.byte	111
	.byte	112
	.byte	113
	.byte	114
	.byte	115
	.byte	116
	.byte	117
	.byte	118
	.byte	119
	.byte	120
	.byte	121
	.byte	122
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	43
	.byte	47
	.align	2
$LC0:
	.ascii	"\n"
	.ascii	"Organizacion de Computadoras - TP0\n\000"
	.align	2
$LC1:
	.ascii	"\n"
	.ascii	"Encoder/Decoder Base64 - v0.1 \n\n\000"
	.align	2
$LC2:
	.ascii	"Group Members:\n\000"
	.align	2
$LC3:
	.ascii	"Gonzalez Perez, Ailen\t\tPadron: 97043\n\000"
	.align	2
$LC4:
	.ascii	"Mariotti, Maria Eugenia\t\tPadron: 96260\n\000"
	.align	2
$LC5:
	.ascii	"Ra\303\261a, Cristian Ezequiel\t\tPadron: 95457\n"
	.ascii	" \n\000"
	.text
	.align	2
	.globl	show_version
$LFB29:
	.loc 1 21 0
	.ent	show_version
show_version:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
$LCFI0:
	sw	$31,32($sp)
$LCFI1:
	sw	$fp,28($sp)
$LCFI2:
	sw	$28,24($sp)
$LCFI3:
	move	$fp,$sp
$LCFI4:
	.loc 1 23 0
	la	$4,$LC0
	la	$25,printf
	jal	$31,$25
	.loc 1 24 0
	la	$4,$LC1
	la	$25,printf
	jal	$31,$25
	.loc 1 25 0
	la	$4,$LC2
	la	$25,printf
	jal	$31,$25
	.loc 1 26 0
	la	$4,$LC3
	la	$25,printf
	jal	$31,$25
	.loc 1 27 0
	la	$4,$LC4
	la	$25,printf
	jal	$31,$25
	.loc 1 28 0
	la	$4,$LC5
	la	$25,printf
	jal	$31,$25
	.loc 1 30 0
	move	$2,$0
	.loc 1 32 0
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	show_version
$LFE29:
	.size	show_version, .-show_version
	.rdata
	.align	2
$LC6:
	.ascii	"Usage:\n\000"
	.align	2
$LC7:
	.ascii	"  tp0 -h\n\000"
	.align	2
$LC8:
	.ascii	"  tp0 -V\n\000"
	.align	2
$LC9:
	.ascii	"  tp0 [options]\n\n\000"
	.align	2
$LC10:
	.ascii	"Options:\n\000"
	.align	2
$LC11:
	.ascii	"  -V, --version\t\tPrint version and quit.\n\000"
	.align	2
$LC12:
	.ascii	"  -h, --help\t\tPrint this information and quit.\n\000"
	.align	2
$LC13:
	.ascii	"  -i, --input\t\tLocation of the input file.\n\000"
	.align	2
$LC14:
	.ascii	"  -o, --output\t\tLocation of the output file.\n\000"
	.align	2
$LC15:
	.ascii	"  -a, --action\t\tProgram action: encode (default) or de"
	.ascii	"code.\n\n\000"
	.align	2
$LC16:
	.ascii	"Examples:\n\000"
	.align	2
$LC17:
	.ascii	"  tp0 -a encode -i ~/input -o ~/output\n\000"
	.align	2
$LC18:
	.ascii	"  tp0 -a decode\n\n\000"
	.text
	.align	2
	.globl	show_help
$LFB31:
	.loc 1 34 0
	.ent	show_help
show_help:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
$LCFI5:
	sw	$31,32($sp)
$LCFI6:
	sw	$fp,28($sp)
$LCFI7:
	sw	$28,24($sp)
$LCFI8:
	move	$fp,$sp
$LCFI9:
	.loc 1 36 0
	la	$4,$LC6
	la	$25,printf
	jal	$31,$25
	.loc 1 37 0
	la	$4,$LC7
	la	$25,printf
	jal	$31,$25
	.loc 1 38 0
	la	$4,$LC8
	la	$25,printf
	jal	$31,$25
	.loc 1 39 0
	la	$4,$LC9
	la	$25,printf
	jal	$31,$25
	.loc 1 40 0
	la	$4,$LC10
	la	$25,printf
	jal	$31,$25
	.loc 1 41 0
	la	$4,$LC11
	la	$25,printf
	jal	$31,$25
	.loc 1 42 0
	la	$4,$LC12
	la	$25,printf
	jal	$31,$25
	.loc 1 43 0
	la	$4,$LC13
	la	$25,printf
	jal	$31,$25
	.loc 1 44 0
	la	$4,$LC14
	la	$25,printf
	jal	$31,$25
	.loc 1 45 0
	la	$4,$LC15
	la	$25,printf
	jal	$31,$25
	.loc 1 46 0
	la	$4,$LC16
	la	$25,printf
	jal	$31,$25
	.loc 1 47 0
	la	$4,$LC17
	la	$25,printf
	jal	$31,$25
	.loc 1 48 0
	la	$4,$LC18
	la	$25,printf
	jal	$31,$25
	.loc 1 50 0
	move	$2,$0
	.loc 1 52 0
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	show_help
$LFE31:
	.size	show_help, .-show_help
	.rdata
	.align	2
$LC19:
	.ascii	"memory alloc fails\000"
	.align	2
$LC20:
	.ascii	"entire read fails\000"
	.text
	.align	2
	.globl	reader
$LFB33:
	.loc 1 54 0
	.ent	reader
reader:
	.frame	$fp,56,$31		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
$LCFI10:
	sw	$31,48($sp)
$LCFI11:
	sw	$fp,44($sp)
$LCFI12:
	sw	$28,40($sp)
$LCFI13:
	move	$fp,$sp
$LCFI14:
	sw	$4,56($fp)
	.loc 1 60 0
$LBB2:
	lw	$4,56($fp)
	move	$5,$0
	li	$6,2			# 0x2
	la	$25,fseek
	jal	$31,$25
	.loc 1 61 0
	lw	$4,56($fp)
	la	$25,ftell
	jal	$31,$25
	sw	$2,24($fp)
	.loc 1 62 0
	lw	$4,56($fp)
	la	$25,rewind
	jal	$31,$25
	.loc 1 65 0
	lw	$2,24($fp)
	addu	$2,$2,1
	li	$4,1			# 0x1
	move	$5,$2
	la	$25,calloc
	jal	$31,$25
	sw	$2,28($fp)
	.loc 1 66 0
	lw	$2,28($fp)
	bne	$2,$0,$L20
	lw	$4,56($fp)
	la	$25,fclose
	jal	$31,$25
	la	$4,$LC19
	la	$5,__sF+176
	la	$25,fputs
	jal	$31,$25
	li	$4,1			# 0x1
	la	$25,exit
	jal	$31,$25
$L20:
	.loc 1 69 0
	lw	$4,28($fp)
	lw	$5,24($fp)
	li	$6,1			# 0x1
	lw	$7,56($fp)
	la	$25,fread
	jal	$31,$25
	move	$3,$2
	li	$2,1			# 0x1
	beq	$3,$2,$L21
	.loc 1 70 0
	lw	$4,56($fp)
	la	$25,fclose
	jal	$31,$25
	lw	$4,28($fp)
	la	$25,free
	jal	$31,$25
	la	$4,$LC20
	la	$5,__sF+176
	la	$25,fputs
	jal	$31,$25
	li	$4,1			# 0x1
	la	$25,exit
	jal	$31,$25
$L21:
	.loc 1 72 0
$LBB3:
	sw	$0,32($fp)
$L22:
	lw	$4,28($fp)
	la	$25,strlen
	jal	$31,$25
	lw	$3,32($fp)
	sltu	$2,$3,$2
	bne	$2,$0,$L25
	b	$L23
$L25:
	.loc 1 73 0
	lw	$3,28($fp)
	lw	$2,32($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	li	$2,10			# 0xa
	bne	$3,$2,$L24
	.loc 1 74 0
$LBB4:
	lw	$2,32($fp)
	sw	$2,36($fp)
$L27:
	lw	$4,28($fp)
	la	$25,strlen
	jal	$31,$25
	lw	$3,36($fp)
	sltu	$2,$3,$2
	bne	$2,$0,$L30
	b	$L24
$L30:
	.loc 1 75 0
	lw	$3,28($fp)
	lw	$2,36($fp)
	addu	$4,$3,$2
	lw	$3,28($fp)
	lw	$2,36($fp)
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	sb	$2,0($4)
	.loc 1 74 0
	lw	$2,36($fp)
	addu	$2,$2,1
	sw	$2,36($fp)
	b	$L27
	.loc 1 72 0
$L24:
$LBE4:
	lw	$2,32($fp)
	addu	$2,$2,1
	sw	$2,32($fp)
	b	$L22
$L23:
	.loc 1 79 0
$LBE3:
	lw	$2,28($fp)
	.loc 1 81 0
	move	$sp,$fp
	lw	$31,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$31
$LBE2:
	.end	reader
$LFE33:
	.size	reader, .-reader
	.align	2
	.globl	b64_decode
$LFB35:
	.loc 1 84 0
	.ent	b64_decode
b64_decode:
	.frame	$fp,88,$31		# vars= 48, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,88
	.cprestore 16
$LCFI15:
	sw	$31,80($sp)
$LCFI16:
	sw	$fp,76($sp)
$LCFI17:
	sw	$28,72($sp)
$LCFI18:
	move	$fp,$sp
$LCFI19:
	sw	$4,88($fp)
	sw	$5,92($fp)
	.loc 1 85 0
$LBB5:
	sw	$0,24($fp)
	.loc 1 86 0
	sw	$0,28($fp)
	.loc 1 87 0
	sw	$0,32($fp)
	.loc 1 89 0
	sw	$0,36($fp)
	.loc 1 90 0
	sw	$0,40($fp)
	.loc 1 95 0
	move	$4,$0
	la	$25,malloc
	jal	$31,$25
	sw	$2,40($fp)
	.loc 1 96 0
	lw	$2,40($fp)
	bne	$2,$0,$L33
	sw	$0,64($fp)
	b	$L31
	.loc 1 99 0
$L33:
	lw	$2,92($fp)
	addu	$2,$2,-1
	move	$3,$2
	sw	$3,92($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L35
	b	$L34
$L35:
	.loc 1 102 0
	lw	$3,88($fp)
	lw	$2,28($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	li	$2,61			# 0x3d
	beq	$3,$2,$L34
	lw	$3,88($fp)
	lw	$2,28($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	lw	$2,_ctype_
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	andi	$2,$2,0x7
	bne	$2,$0,$L36
	lw	$3,88($fp)
	lw	$2,28($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	li	$2,43			# 0x2b
	beq	$3,$2,$L36
	lw	$3,88($fp)
	lw	$2,28($fp)
	addu	$2,$3,$2
	lb	$3,0($2)
	li	$2,47			# 0x2f
	bne	$3,$2,$L34
$L36:
	.loc 1 108 0
	lw	$5,24($fp)
	move	$3,$5
	addu	$2,$fp,24
	addu	$2,$3,$2
	addu	$7,$2,32
	addu	$6,$fp,28
	lw	$3,0($6)
	move	$4,$3
	lw	$2,88($fp)
	addu	$2,$4,$2
	lbu	$2,0($2)
	sb	$2,0($7)
	addu	$3,$3,1
	sw	$3,0($6)
	addu	$5,$5,1
	sw	$5,24($fp)
	.loc 1 111 0
	lw	$3,24($fp)
	li	$2,4			# 0x4
	bne	$3,$2,$L33
	.loc 1 113 0
	sw	$0,24($fp)
$L39:
	lw	$2,24($fp)
	slt	$2,$2,4
	bne	$2,$0,$L42
	b	$L40
$L42:
	.loc 1 116 0
	sw	$0,32($fp)
$L43:
	lw	$2,32($fp)
	slt	$2,$2,64
	bne	$2,$0,$L46
	b	$L41
$L46:
	.loc 1 117 0
	addu	$3,$fp,56
	lw	$2,24($fp)
	addu	$2,$3,$2
	lbu	$4,0($2)
	lw	$3,32($fp)
	la	$2,b64_table
	addu	$2,$3,$2
	lb	$2,0($2)
	bne	$4,$2,$L45
	.loc 1 118 0
	addu	$3,$fp,56
	lw	$2,24($fp)
	addu	$3,$3,$2
	lbu	$2,32($fp)
	sb	$2,0($3)
	.loc 1 119 0
	b	$L41
	.loc 1 116 0
$L45:
	lw	$2,32($fp)
	addu	$2,$2,1
	sw	$2,32($fp)
	b	$L43
	.loc 1 113 0
$L41:
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	b	$L39
$L40:
	.loc 1 130 0
	lbu	$2,56($fp)
	sll	$3,$2,2
	lbu	$2,57($fp)
	andi	$2,$2,0x30
	sra	$2,$2,4
	addu	$2,$3,$2
	sb	$2,48($fp)
	.loc 1 131 0
	lbu	$2,57($fp)
	andi	$2,$2,0xf
	sll	$3,$2,4
	lbu	$2,58($fp)
	andi	$2,$2,0x3c
	sra	$2,$2,2
	addu	$2,$3,$2
	sb	$2,49($fp)
	.loc 1 132 0
	lbu	$2,58($fp)
	andi	$2,$2,0x3
	sll	$2,$2,6
	move	$3,$2
	lbu	$2,59($fp)
	addu	$2,$3,$2
	sb	$2,50($fp)
	.loc 1 135 0
	lw	$2,36($fp)
	addu	$2,$2,3
	lw	$4,40($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,40($fp)
	.loc 1 136 0
	sw	$0,24($fp)
$L48:
	lw	$2,24($fp)
	slt	$2,$2,3
	bne	$2,$0,$L51
	b	$L49
$L51:
	.loc 1 137 0
	addu	$6,$fp,36
	lw	$3,0($6)
	move	$4,$3
	lw	$2,40($fp)
	addu	$5,$4,$2
	addu	$4,$fp,48
	lw	$2,24($fp)
	addu	$2,$4,$2
	lbu	$2,0($2)
	sb	$2,0($5)
	addu	$3,$3,1
	sw	$3,0($6)
	.loc 1 136 0
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	b	$L48
$L49:
	.loc 1 141 0
	sw	$0,24($fp)
	b	$L33
$L34:
	.loc 1 146 0
	lw	$2,24($fp)
	blez	$2,$L52
	.loc 1 148 0
	lw	$2,24($fp)
	sw	$2,28($fp)
$L53:
	lw	$2,28($fp)
	slt	$2,$2,4
	bne	$2,$0,$L56
	b	$L54
$L56:
	.loc 1 149 0
	addu	$3,$fp,56
	lw	$2,28($fp)
	addu	$2,$3,$2
	sb	$0,0($2)
	.loc 1 148 0
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L53
$L54:
	.loc 1 153 0
	sw	$0,28($fp)
$L57:
	lw	$2,28($fp)
	slt	$2,$2,4
	bne	$2,$0,$L60
	b	$L58
$L60:
	.loc 1 154 0
	sw	$0,32($fp)
$L61:
	lw	$2,32($fp)
	slt	$2,$2,64
	bne	$2,$0,$L64
	b	$L59
$L64:
	.loc 1 155 0
	addu	$3,$fp,56
	lw	$2,28($fp)
	addu	$2,$3,$2
	lbu	$4,0($2)
	lw	$3,32($fp)
	la	$2,b64_table
	addu	$2,$3,$2
	lb	$2,0($2)
	bne	$4,$2,$L63
	.loc 1 156 0
	addu	$3,$fp,56
	lw	$2,28($fp)
	addu	$3,$3,$2
	lbu	$2,32($fp)
	sb	$2,0($3)
	.loc 1 157 0
	b	$L59
	.loc 1 154 0
$L63:
	lw	$2,32($fp)
	addu	$2,$2,1
	sw	$2,32($fp)
	b	$L61
	.loc 1 153 0
$L59:
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L57
$L58:
	.loc 1 163 0
	lbu	$2,56($fp)
	sll	$3,$2,2
	lbu	$2,57($fp)
	andi	$2,$2,0x30
	sra	$2,$2,4
	addu	$2,$3,$2
	sb	$2,48($fp)
	.loc 1 164 0
	lbu	$2,57($fp)
	andi	$2,$2,0xf
	sll	$3,$2,4
	lbu	$2,58($fp)
	andi	$2,$2,0x3c
	sra	$2,$2,2
	addu	$2,$3,$2
	sb	$2,49($fp)
	.loc 1 165 0
	lbu	$2,58($fp)
	andi	$2,$2,0x3
	sll	$2,$2,6
	move	$3,$2
	lbu	$2,59($fp)
	addu	$2,$3,$2
	sb	$2,50($fp)
	.loc 1 168 0
	lw	$3,36($fp)
	lw	$2,24($fp)
	addu	$2,$3,$2
	addu	$2,$2,-1
	lw	$4,40($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,40($fp)
	.loc 1 169 0
	sw	$0,28($fp)
$L66:
	lw	$2,24($fp)
	addu	$3,$2,-1
	lw	$2,28($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L69
	b	$L52
$L69:
	.loc 1 170 0
	addu	$6,$fp,36
	lw	$3,0($6)
	move	$4,$3
	lw	$2,40($fp)
	addu	$5,$4,$2
	addu	$4,$fp,48
	lw	$2,28($fp)
	addu	$2,$4,$2
	lbu	$2,0($2)
	sb	$2,0($5)
	addu	$3,$3,1
	sw	$3,0($6)
	.loc 1 169 0
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L66
$L52:
	.loc 1 175 0
	lw	$2,36($fp)
	addu	$2,$2,1
	lw	$4,40($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,40($fp)
	.loc 1 176 0
	lw	$3,40($fp)
	lw	$2,36($fp)
	addu	$2,$3,$2
	sb	$0,0($2)
	.loc 1 178 0
	lw	$2,40($fp)
	sw	$2,64($fp)
	.loc 1 179 0
$L31:
$LBE5:
	lw	$2,64($fp)
	move	$sp,$fp
	lw	$31,80($sp)
	lw	$fp,76($sp)
	addu	$sp,$sp,88
	j	$31
	.end	b64_decode
$LFE35:
	.size	b64_decode, .-b64_decode
	.align	2
	.globl	b64_encode
$LFB37:
	.loc 1 181 0
	.ent	b64_encode
b64_encode:
	.frame	$fp,80,$31		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
$LCFI20:
	sw	$31,72($sp)
$LCFI21:
	sw	$fp,68($sp)
$LCFI22:
	sw	$28,64($sp)
$LCFI23:
	move	$fp,$sp
$LCFI24:
	sw	$4,80($fp)
	sw	$5,84($fp)
	.loc 1 182 0
$LBB6:
	sw	$0,24($fp)
	.loc 1 183 0
	sw	$0,28($fp)
	.loc 1 184 0
	sw	$0,32($fp)
	.loc 1 185 0
	sw	$0,36($fp)
	.loc 1 189 0
	move	$4,$0
	la	$25,malloc
	jal	$31,$25
	sw	$2,32($fp)
	.loc 1 190 0
	lw	$2,32($fp)
	bne	$2,$0,$L72
	sw	$0,56($fp)
	b	$L70
	.loc 1 193 0
$L72:
	lw	$2,84($fp)
	addu	$2,$2,-1
	move	$3,$2
	sw	$3,84($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L74
	b	$L73
$L74:
	.loc 1 194 0
	lw	$4,24($fp)
	move	$3,$4
	addu	$2,$fp,24
	addu	$2,$3,$2
	addu	$5,$2,24
	lw	$2,80($fp)
	move	$3,$2
	lbu	$3,0($3)
	sb	$3,0($5)
	addu	$2,$2,1
	sw	$2,80($fp)
	addu	$4,$4,1
	sw	$4,24($fp)
	.loc 1 197 0
	lw	$3,24($fp)
	li	$2,3			# 0x3
	bne	$3,$2,$L72
	.loc 1 198 0
	lbu	$2,48($fp)
	andi	$2,$2,0xfc
	sra	$2,$2,2
	sb	$2,40($fp)
	.loc 1 199 0
	lbu	$2,48($fp)
	andi	$2,$2,0x3
	sll	$3,$2,4
	lbu	$2,49($fp)
	andi	$2,$2,0xf0
	sra	$2,$2,4
	addu	$2,$3,$2
	sb	$2,41($fp)
	.loc 1 200 0
	lbu	$2,49($fp)
	andi	$2,$2,0xf
	sll	$3,$2,2
	lbu	$2,50($fp)
	andi	$2,$2,0xc0
	sra	$2,$2,6
	addu	$2,$3,$2
	sb	$2,42($fp)
	.loc 1 201 0
	lbu	$2,50($fp)
	andi	$2,$2,0x3f
	sb	$2,43($fp)
	.loc 1 203 0
	lw	$2,36($fp)
	addu	$2,$2,4
	lw	$4,32($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,32($fp)
	.loc 1 204 0
	sw	$0,24($fp)
$L76:
	lw	$2,24($fp)
	slt	$2,$2,4
	bne	$2,$0,$L79
	b	$L77
$L79:
	.loc 1 205 0
	addu	$6,$fp,36
	lw	$4,0($6)
	move	$3,$4
	lw	$2,32($fp)
	addu	$5,$3,$2
	addu	$3,$fp,40
	lw	$2,24($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	lbu	$2,b64_table($2)
	sb	$2,0($5)
	addu	$4,$4,1
	sw	$4,0($6)
	.loc 1 204 0
	lw	$2,24($fp)
	addu	$2,$2,1
	sw	$2,24($fp)
	b	$L76
$L77:
	.loc 1 208 0
	sw	$0,24($fp)
	b	$L72
$L73:
	.loc 1 213 0
	lw	$2,24($fp)
	blez	$2,$L80
	.loc 1 214 0
	lw	$2,24($fp)
	sw	$2,28($fp)
$L81:
	lw	$2,28($fp)
	slt	$2,$2,3
	bne	$2,$0,$L84
	b	$L82
$L84:
	.loc 1 215 0
	addu	$3,$fp,48
	lw	$2,28($fp)
	addu	$2,$3,$2
	sb	$0,0($2)
	.loc 1 214 0
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L81
$L82:
	.loc 1 218 0
	lbu	$2,48($fp)
	andi	$2,$2,0xfc
	sra	$2,$2,2
	sb	$2,40($fp)
	.loc 1 219 0
	lbu	$2,48($fp)
	andi	$2,$2,0x3
	sll	$3,$2,4
	lbu	$2,49($fp)
	andi	$2,$2,0xf0
	sra	$2,$2,4
	addu	$2,$3,$2
	sb	$2,41($fp)
	.loc 1 220 0
	lbu	$2,49($fp)
	andi	$2,$2,0xf
	sll	$3,$2,2
	lbu	$2,50($fp)
	andi	$2,$2,0xc0
	sra	$2,$2,6
	addu	$2,$3,$2
	sb	$2,42($fp)
	.loc 1 221 0
	lbu	$2,50($fp)
	andi	$2,$2,0x3f
	sb	$2,43($fp)
	.loc 1 223 0
	sw	$0,28($fp)
$L85:
	lw	$2,24($fp)
	addu	$3,$2,1
	lw	$2,28($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L88
	b	$L89
$L88:
	.loc 1 224 0
	lw	$2,36($fp)
	addu	$2,$2,1
	lw	$4,32($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,32($fp)
	.loc 1 225 0
	addu	$6,$fp,36
	lw	$4,0($6)
	move	$3,$4
	lw	$2,32($fp)
	addu	$5,$3,$2
	addu	$3,$fp,40
	lw	$2,28($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	lbu	$2,b64_table($2)
	sb	$2,0($5)
	addu	$4,$4,1
	sw	$4,0($6)
	.loc 1 223 0
	lw	$2,28($fp)
	addu	$2,$2,1
	sw	$2,28($fp)
	b	$L85
	.loc 1 229 0
$L89:
	lw	$2,24($fp)
	move	$3,$2
	addu	$2,$2,1
	sw	$2,24($fp)
	slt	$2,$3,3
	bne	$2,$0,$L91
	b	$L80
$L91:
	.loc 1 230 0
	lw	$2,36($fp)
	addu	$2,$2,1
	lw	$4,32($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,32($fp)
	.loc 1 231 0
	addu	$5,$fp,36
	lw	$3,0($5)
	move	$4,$3
	lw	$2,32($fp)
	addu	$4,$4,$2
	li	$2,61			# 0x3d
	sb	$2,0($4)
	addu	$3,$3,1
	sw	$3,0($5)
	b	$L89
$L80:
	.loc 1 236 0
	lw	$2,36($fp)
	addu	$2,$2,1
	lw	$4,32($fp)
	move	$5,$2
	la	$25,realloc
	jal	$31,$25
	sw	$2,32($fp)
	.loc 1 237 0
	lw	$3,32($fp)
	lw	$2,36($fp)
	addu	$2,$3,$2
	sb	$0,0($2)
	.loc 1 239 0
	lw	$2,32($fp)
	sw	$2,56($fp)
	.loc 1 240 0
$L70:
$LBE6:
	lw	$2,56($fp)
	move	$sp,$fp
	lw	$31,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$31
	.end	b64_encode
$LFE37:
	.size	b64_encode, .-b64_encode
	.rdata
	.align	2
$LC21:
	.ascii	"encode\000"
	.align	2
$LC22:
	.ascii	"-h\000"
	.align	2
$LC23:
	.ascii	"--help\000"
	.align	2
$LC24:
	.ascii	"-V\000"
	.align	2
$LC25:
	.ascii	"--version\000"
	.align	2
$LC26:
	.ascii	"-i\000"
	.align	2
$LC27:
	.ascii	"--input\000"
	.align	2
$LC28:
	.ascii	"rb+\000"
	.align	2
$LC29:
	.ascii	"Error de apertura de archivo de entrada. No se puede con"
	.ascii	"tinuar.\n\000"
	.align	2
$LC30:
	.ascii	"-o\000"
	.align	2
$LC31:
	.ascii	"--output\000"
	.align	2
$LC32:
	.ascii	"wb+\000"
	.align	2
$LC33:
	.ascii	"Error de apertura de archivo de salida. No se puede cont"
	.ascii	"inuar.\n\000"
	.align	2
$LC34:
	.ascii	"-a\000"
	.align	2
$LC35:
	.ascii	"--action\000"
	.align	2
$LC36:
	.ascii	"decode\000"
	.align	2
$LC37:
	.ascii	"%s no es una opci\303\263n v\303\241lida.\n\000"
	.align	2
$LC38:
	.ascii	"\n"
	.ascii	"El resultado del %s es: %s \n\n\000"
	.align	2
$LC39:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	main
$LFB39:
	.loc 1 242 0
	.ent	main
main:
	.frame	$fp,72,$31		# vars= 32, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 16
$LCFI25:
	sw	$31,64($sp)
$LCFI26:
	sw	$fp,60($sp)
$LCFI27:
	sw	$28,56($sp)
$LCFI28:
	move	$fp,$sp
$LCFI29:
	sw	$4,72($fp)
	sw	$5,76($fp)
	.loc 1 244 0
$LBB7:
	la	$2,__sF
	sw	$2,24($fp)
	.loc 1 245 0
	la	$2,__sF+88
	sw	$2,28($fp)
	.loc 1 246 0
	la	$2,$LC21
	sw	$2,32($fp)
	.loc 1 247 0
	sb	$0,36($fp)
	.loc 1 248 0
	sb	$0,37($fp)
	.loc 1 250 0
$LBB8:
	li	$2,1			# 0x1
	sw	$2,40($fp)
$L93:
	lw	$2,40($fp)
	lw	$3,72($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L96
	b	$L94
$L96:
	.loc 1 251 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC22
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L98
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC23
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L97
$L98:
	.loc 1 252 0
	la	$25,show_help
	jal	$31,$25
	.loc 1 253 0
	li	$2,1			# 0x1
	sb	$2,37($fp)
	.loc 1 254 0
	b	$L94
$L97:
	.loc 1 257 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC24
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L100
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC25
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L99
$L100:
	.loc 1 258 0
	la	$25,show_version
	jal	$31,$25
	.loc 1 259 0
	li	$2,1			# 0x1
	sb	$2,36($fp)
	.loc 1 260 0
	b	$L94
$L99:
	.loc 1 263 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC26
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L102
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC27
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L101
$L102:
	.loc 1 264 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC28
	la	$25,fopen
	jal	$31,$25
	sw	$2,24($fp)
	.loc 1 265 0
	lw	$2,24($fp)
	bne	$2,$0,$L103
	.loc 1 266 0
	la	$4,$LC29
	la	$25,printf
	jal	$31,$25
	.loc 1 267 0
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,48($fp)
	b	$L92
$L103:
	.loc 1 269 0
	lw	$2,40($fp)
	addu	$2,$2,1
	sw	$2,40($fp)
$L101:
	.loc 1 272 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC30
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L105
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC31
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L104
$L105:
	.loc 1 273 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	addu	$2,$2,4
	lw	$4,0($2)
	la	$5,$LC32
	la	$25,fopen
	jal	$31,$25
	sw	$2,28($fp)
	.loc 1 274 0
	lw	$2,28($fp)
	bne	$2,$0,$L106
	.loc 1 275 0
	la	$4,$LC33
	la	$25,printf
	jal	$31,$25
	.loc 1 276 0
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,48($fp)
	b	$L92
$L106:
	.loc 1 278 0
	lw	$2,40($fp)
	addu	$2,$2,1
	sw	$2,40($fp)
$L104:
	.loc 1 281 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC34
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L108
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	la	$4,$LC35
	lw	$5,0($2)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L95
$L108:
	.loc 1 282 0
	lw	$2,40($fp)
	sll	$3,$2,2
	lw	$2,76($fp)
	addu	$2,$3,$2
	addu	$2,$2,4
	lw	$2,0($2)
	sw	$2,32($fp)
	.loc 1 283 0
	la	$4,$LC36
	lw	$5,32($fp)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L109
	la	$4,$LC21
	lw	$5,32($fp)
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L109
	.loc 1 284 0
	la	$4,$LC37
	lw	$5,32($fp)
	la	$25,printf
	jal	$31,$25
	.loc 1 285 0
	li	$2,-1			# 0xffffffffffffffff
	sw	$2,48($fp)
	b	$L92
$L109:
	.loc 1 287 0
	lw	$2,40($fp)
	addu	$2,$2,1
	sw	$2,40($fp)
	.loc 1 250 0
$L95:
	lw	$2,40($fp)
	addu	$2,$2,1
	sw	$2,40($fp)
	b	$L93
$L94:
	.loc 1 291 0
$LBE8:
	lbu	$2,36($fp)
	bne	$2,$0,$L111
	lbu	$2,37($fp)
	bne	$2,$0,$L111
	b	$L110
$L111:
	.loc 1 292 0
	lw	$3,24($fp)
	la	$2,__sF
	beq	$3,$2,$L112
	.loc 1 293 0
	lw	$4,24($fp)
	la	$25,fclose
	jal	$31,$25
$L112:
	.loc 1 294 0
	lw	$3,28($fp)
	la	$2,__sF+88
	beq	$3,$2,$L113
	.loc 1 295 0
	lw	$4,28($fp)
	la	$25,fclose
	jal	$31,$25
$L113:
	.loc 1 296 0
	sw	$0,48($fp)
	b	$L92
$L110:
	.loc 1 301 0
	lw	$3,24($fp)
	la	$2,__sF
	bne	$3,$2,$L114
	.loc 1 302 0
	lw	$4,40($fp)
	la	$25,gets
	jal	$31,$25
	b	$L115
$L114:
	.loc 1 304 0
	lw	$4,24($fp)
	la	$25,reader
	jal	$31,$25
	sw	$2,40($fp)
$L115:
	.loc 1 308 0
	la	$4,$LC36
	lw	$5,32($fp)
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L116
	.loc 1 309 0
	lw	$4,40($fp)
	la	$25,strlen
	jal	$31,$25
	lw	$4,40($fp)
	move	$5,$2
	la	$25,b64_decode
	jal	$31,$25
	sw	$2,44($fp)
	b	$L117
$L116:
	.loc 1 313 0
	lw	$4,40($fp)
	la	$25,strlen
	jal	$31,$25
	lw	$4,40($fp)
	move	$5,$2
	la	$25,b64_encode
	jal	$31,$25
	sw	$2,44($fp)
$L117:
	.loc 1 316 0
	lw	$3,28($fp)
	la	$2,__sF+88
	bne	$3,$2,$L118
	.loc 1 317 0
	la	$4,$LC38
	lw	$5,32($fp)
	lw	$6,44($fp)
	la	$25,printf
	jal	$31,$25
	b	$L119
$L118:
	.loc 1 320 0
	lw	$4,28($fp)
	la	$5,$LC39
	lw	$6,44($fp)
	la	$25,fprintf
	jal	$31,$25
	.loc 1 321 0
	lw	$4,28($fp)
	la	$25,fclose
	jal	$31,$25
$L119:
	.loc 1 324 0
	lw	$3,24($fp)
	la	$2,__sF
	beq	$3,$2,$L120
	.loc 1 325 0
	lw	$4,24($fp)
	la	$25,fclose
	jal	$31,$25
$L120:
	.loc 1 329 0
	sw	$0,48($fp)
	.loc 1 330 0
$L92:
$LBE7:
	lw	$2,48($fp)
	move	$sp,$fp
	lw	$31,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$31
	.end	main
$LFE39:
	.size	main, .-main
	.file 11 "/usr/include/ctype.h"
	.section	.debug_frame,"",@progbits
$Lframe0:
	.4byte	$LECIE0-$LSCIE0
$LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.ascii	"\000"
	.uleb128 0x1
	.sleb128 4
	.byte	0x40
	.byte	0xc
	.uleb128 0x1d
	.uleb128 0x0
	.align	2
$LECIE0:
$LSFDE0:
	.4byte	$LEFDE0-$LASFDE0
$LASFDE0:
	.4byte	$Lframe0
	.4byte	$LFB29
	.4byte	$LFE29-$LFB29
	.byte	0x4
	.4byte	$LCFI0-$LFB29
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	$LCFI3-$LCFI0
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI4-$LCFI3
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x28
	.align	2
$LEFDE0:
$LSFDE2:
	.4byte	$LEFDE2-$LASFDE2
$LASFDE2:
	.4byte	$Lframe0
	.4byte	$LFB31
	.4byte	$LFE31-$LFB31
	.byte	0x4
	.4byte	$LCFI5-$LFB31
	.byte	0xe
	.uleb128 0x28
	.byte	0x4
	.4byte	$LCFI8-$LCFI5
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI9-$LCFI8
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x28
	.align	2
$LEFDE2:
$LSFDE4:
	.4byte	$LEFDE4-$LASFDE4
$LASFDE4:
	.4byte	$Lframe0
	.4byte	$LFB33
	.4byte	$LFE33-$LFB33
	.byte	0x4
	.4byte	$LCFI10-$LFB33
	.byte	0xe
	.uleb128 0x38
	.byte	0x4
	.4byte	$LCFI13-$LCFI10
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI14-$LCFI13
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x38
	.align	2
$LEFDE4:
$LSFDE6:
	.4byte	$LEFDE6-$LASFDE6
$LASFDE6:
	.4byte	$Lframe0
	.4byte	$LFB35
	.4byte	$LFE35-$LFB35
	.byte	0x4
	.4byte	$LCFI15-$LFB35
	.byte	0xe
	.uleb128 0x58
	.byte	0x4
	.4byte	$LCFI18-$LCFI15
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI19-$LCFI18
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x58
	.align	2
$LEFDE6:
$LSFDE8:
	.4byte	$LEFDE8-$LASFDE8
$LASFDE8:
	.4byte	$Lframe0
	.4byte	$LFB37
	.4byte	$LFE37-$LFB37
	.byte	0x4
	.4byte	$LCFI20-$LFB37
	.byte	0xe
	.uleb128 0x50
	.byte	0x4
	.4byte	$LCFI23-$LCFI20
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI24-$LCFI23
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x50
	.align	2
$LEFDE8:
$LSFDE10:
	.4byte	$LEFDE10-$LASFDE10
$LASFDE10:
	.4byte	$Lframe0
	.4byte	$LFB39
	.4byte	$LFE39-$LFB39
	.byte	0x4
	.4byte	$LCFI25-$LFB39
	.byte	0xe
	.uleb128 0x48
	.byte	0x4
	.4byte	$LCFI28-$LCFI25
	.byte	0x11
	.uleb128 0x1c
	.sleb128 -4
	.byte	0x11
	.uleb128 0x1e
	.sleb128 -3
	.byte	0x11
	.uleb128 0x40
	.sleb128 -2
	.byte	0x4
	.4byte	$LCFI29-$LCFI28
	.byte	0xc
	.uleb128 0x1e
	.uleb128 0x48
	.align	2
$LEFDE10:
	.align	0
	.text
$Letext0:
	.section	.debug_info
	.4byte	0xe7c
	.2byte	0x2
	.4byte	$Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	$Ldebug_line0
	.4byte	$Letext0
	.4byte	$Ltext0
	.4byte	$LC266
	.4byte	$LC267
	.4byte	$LC268
	.byte	0x1
	.uleb128 0x2
	.4byte	$LC40
	.byte	0x2
	.byte	0x30
	.4byte	0x30
	.uleb128 0x3
	.4byte	$LC42
	.byte	0x1
	.byte	0x6
	.uleb128 0x2
	.4byte	$LC41
	.byte	0x2
	.byte	0x31
	.4byte	0x42
	.uleb128 0x3
	.4byte	$LC43
	.byte	0x1
	.byte	0x8
	.uleb128 0x2
	.4byte	$LC44
	.byte	0x2
	.byte	0x32
	.4byte	0x54
	.uleb128 0x3
	.4byte	$LC45
	.byte	0x2
	.byte	0x5
	.uleb128 0x2
	.4byte	$LC46
	.byte	0x2
	.byte	0x33
	.4byte	0x66
	.uleb128 0x3
	.4byte	$LC47
	.byte	0x2
	.byte	0x7
	.uleb128 0x2
	.4byte	$LC48
	.byte	0x2
	.byte	0x34
	.4byte	0x78
	.uleb128 0x4
	.ascii	"int\000"
	.byte	0x4
	.byte	0x5
	.uleb128 0x2
	.4byte	$LC49
	.byte	0x2
	.byte	0x35
	.4byte	0x8a
	.uleb128 0x3
	.4byte	$LC50
	.byte	0x4
	.byte	0x7
	.uleb128 0x2
	.4byte	$LC51
	.byte	0x2
	.byte	0x3e
	.4byte	0x9c
	.uleb128 0x3
	.4byte	$LC52
	.byte	0x8
	.byte	0x5
	.uleb128 0x2
	.4byte	$LC53
	.byte	0x2
	.byte	0x40
	.4byte	0xae
	.uleb128 0x3
	.4byte	$LC54
	.byte	0x8
	.byte	0x7
	.uleb128 0x2
	.4byte	$LC55
	.byte	0x2
	.byte	0x4b
	.4byte	0x78
	.uleb128 0x2
	.4byte	$LC56
	.byte	0x2
	.byte	0x4c
	.4byte	0x8a
	.uleb128 0x2
	.4byte	$LC57
	.byte	0x3
	.byte	0x2c
	.4byte	0xd6
	.uleb128 0x5
	.byte	0x4
	.4byte	0xdc
	.uleb128 0x3
	.4byte	$LC58
	.byte	0x1
	.byte	0x6
	.uleb128 0x2
	.4byte	$LC59
	.byte	0x3
	.byte	0x2d
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC60
	.byte	0x3
	.byte	0x2e
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC61
	.byte	0x3
	.byte	0x2f
	.4byte	0x5b
	.uleb128 0x2
	.4byte	$LC62
	.byte	0x3
	.byte	0x30
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC63
	.byte	0x3
	.byte	0x31
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC64
	.byte	0x3
	.byte	0x32
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC65
	.byte	0x3
	.byte	0x33
	.4byte	0x37
	.uleb128 0x2
	.4byte	$LC66
	.byte	0x3
	.byte	0x34
	.4byte	0x8a
	.uleb128 0x2
	.4byte	$LC67
	.byte	0x3
	.byte	0x35
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC68
	.byte	0x3
	.byte	0x36
	.4byte	0xa3
	.uleb128 0x2
	.4byte	$LC69
	.byte	0x3
	.byte	0x37
	.4byte	0xa3
	.uleb128 0x6
	.4byte	0x17b
	.byte	0x80
	.byte	0x4
	.byte	0x65
	.uleb128 0x7
	.4byte	$LC70
	.byte	0x4
	.byte	0x63
	.4byte	0x17b
	.uleb128 0x7
	.4byte	$LC71
	.byte	0x4
	.byte	0x64
	.4byte	0x91
	.byte	0x0
	.uleb128 0x8
	.4byte	0x18b
	.4byte	0xdc
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x7f
	.byte	0x0
	.uleb128 0x3
	.4byte	$LC50
	.byte	0x4
	.byte	0x7
	.uleb128 0x2
	.4byte	$LC72
	.byte	0x4
	.byte	0x65
	.4byte	0x15c
	.uleb128 0x2
	.4byte	$LC73
	.byte	0x5
	.byte	0x2e
	.4byte	0x8a
	.uleb128 0xa
	.4byte	0x1c3
	.4byte	$LC76
	.byte	0x8
	.byte	0x5
	.byte	0x3c
	.uleb128 0xb
	.4byte	$LC74
	.byte	0x5
	.byte	0x3d
	.4byte	0x10f
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC75
	.byte	0x5
	.byte	0x3e
	.4byte	0x1a8
	.uleb128 0xa
	.4byte	0x1f7
	.4byte	$LC77
	.byte	0x8
	.byte	0x5
	.byte	0x4a
	.uleb128 0xb
	.4byte	$LC78
	.byte	0x5
	.byte	0x4b
	.4byte	0x1f7
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC79
	.byte	0x5
	.byte	0x4c
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x42
	.uleb128 0xa
	.4byte	0x31f
	.4byte	$LC80
	.byte	0x58
	.byte	0x5
	.byte	0x69
	.uleb128 0xc
	.ascii	"_p\000"
	.byte	0x5
	.byte	0x6a
	.4byte	0x1f7
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xc
	.ascii	"_r\000"
	.byte	0x5
	.byte	0x6b
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xc
	.ascii	"_w\000"
	.byte	0x5
	.byte	0x6c
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.uleb128 0xb
	.4byte	$LC81
	.byte	0x5
	.byte	0x6d
	.4byte	0x54
	.byte	0x2
	.byte	0x10
	.uleb128 0xc
	.uleb128 0xb
	.4byte	$LC82
	.byte	0x5
	.byte	0x6e
	.4byte	0x54
	.byte	0x2
	.byte	0x10
	.uleb128 0xe
	.uleb128 0xc
	.ascii	"_bf\000"
	.byte	0x5
	.byte	0x6f
	.4byte	0x1ce
	.byte	0x2
	.byte	0x10
	.uleb128 0x10
	.uleb128 0xb
	.4byte	$LC83
	.byte	0x5
	.byte	0x70
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x18
	.uleb128 0xb
	.4byte	$LC84
	.byte	0x5
	.byte	0x73
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x1c
	.uleb128 0xb
	.4byte	$LC85
	.byte	0x5
	.byte	0x74
	.4byte	0x331
	.byte	0x2
	.byte	0x10
	.uleb128 0x20
	.uleb128 0xb
	.4byte	$LC86
	.byte	0x5
	.byte	0x75
	.4byte	0x351
	.byte	0x2
	.byte	0x10
	.uleb128 0x24
	.uleb128 0xb
	.4byte	$LC87
	.byte	0x5
	.byte	0x76
	.4byte	0x371
	.byte	0x2
	.byte	0x10
	.uleb128 0x28
	.uleb128 0xb
	.4byte	$LC88
	.byte	0x5
	.byte	0x77
	.4byte	0x39c
	.byte	0x2
	.byte	0x10
	.uleb128 0x2c
	.uleb128 0xb
	.4byte	$LC89
	.byte	0x5
	.byte	0x7a
	.4byte	0x1ce
	.byte	0x2
	.byte	0x10
	.uleb128 0x30
	.uleb128 0xc
	.ascii	"_up\000"
	.byte	0x5
	.byte	0x7d
	.4byte	0x1f7
	.byte	0x2
	.byte	0x10
	.uleb128 0x38
	.uleb128 0xc
	.ascii	"_ur\000"
	.byte	0x5
	.byte	0x7e
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x3c
	.uleb128 0xb
	.4byte	$LC90
	.byte	0x5
	.byte	0x81
	.4byte	0x3a2
	.byte	0x2
	.byte	0x10
	.uleb128 0x40
	.uleb128 0xb
	.4byte	$LC91
	.byte	0x5
	.byte	0x82
	.4byte	0x3b2
	.byte	0x2
	.byte	0x10
	.uleb128 0x43
	.uleb128 0xc
	.ascii	"_lb\000"
	.byte	0x5
	.byte	0x85
	.4byte	0x1ce
	.byte	0x2
	.byte	0x10
	.uleb128 0x44
	.uleb128 0xb
	.4byte	$LC92
	.byte	0x5
	.byte	0x88
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x4c
	.uleb128 0xb
	.4byte	$LC93
	.byte	0x5
	.byte	0x89
	.4byte	0x1c3
	.byte	0x2
	.byte	0x10
	.uleb128 0x50
	.byte	0x0
	.uleb128 0xd
	.byte	0x4
	.uleb128 0xe
	.4byte	0x331
	.byte	0x1
	.4byte	0x78
	.uleb128 0xf
	.4byte	0x31f
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x321
	.uleb128 0xe
	.4byte	0x351
	.byte	0x1
	.4byte	0x78
	.uleb128 0xf
	.4byte	0x31f
	.uleb128 0xf
	.4byte	0xd6
	.uleb128 0xf
	.4byte	0x78
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x337
	.uleb128 0xe
	.4byte	0x371
	.byte	0x1
	.4byte	0x1c3
	.uleb128 0xf
	.4byte	0x31f
	.uleb128 0xf
	.4byte	0x1c3
	.uleb128 0xf
	.4byte	0x78
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x357
	.uleb128 0xe
	.4byte	0x391
	.byte	0x1
	.4byte	0x78
	.uleb128 0xf
	.4byte	0x31f
	.uleb128 0xf
	.4byte	0x391
	.uleb128 0xf
	.4byte	0x78
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x397
	.uleb128 0x10
	.4byte	0xdc
	.uleb128 0x5
	.byte	0x4
	.4byte	0x377
	.uleb128 0x8
	.4byte	0x3b2
	.4byte	0x42
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x2
	.byte	0x0
	.uleb128 0x8
	.4byte	0x3c2
	.4byte	0x42
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC94
	.byte	0x5
	.byte	0x8a
	.4byte	0x1fd
	.uleb128 0x11
	.4byte	$LC95
	.byte	0x5
	.2byte	0x160
	.4byte	0x10f
	.uleb128 0x2
	.4byte	$LC96
	.byte	0x6
	.byte	0x3b
	.4byte	0x3e4
	.uleb128 0x3
	.4byte	$LC97
	.byte	0x4
	.byte	0x5
	.uleb128 0x2
	.4byte	$LC98
	.byte	0x6
	.byte	0x3c
	.4byte	0x3f6
	.uleb128 0x3
	.4byte	$LC99
	.byte	0x4
	.byte	0x7
	.uleb128 0x2
	.4byte	$LC100
	.byte	0x6
	.byte	0x3d
	.4byte	0x3e4
	.uleb128 0x2
	.4byte	$LC101
	.byte	0x6
	.byte	0x46
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC102
	.byte	0x6
	.byte	0x47
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC103
	.byte	0x6
	.byte	0x49
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC104
	.byte	0x6
	.byte	0x4a
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC105
	.byte	0x6
	.byte	0x51
	.4byte	0x3e4
	.uleb128 0x2
	.4byte	$LC106
	.byte	0x6
	.byte	0x5a
	.4byte	0x44a
	.uleb128 0x12
	.4byte	0x78
	.uleb128 0x2
	.4byte	$LC107
	.byte	0x7
	.byte	0x36
	.4byte	0x25
	.uleb128 0x2
	.4byte	$LC108
	.byte	0x7
	.byte	0x3b
	.4byte	0x37
	.uleb128 0x2
	.4byte	$LC109
	.byte	0x7
	.byte	0x40
	.4byte	0x49
	.uleb128 0x2
	.4byte	$LC110
	.byte	0x7
	.byte	0x45
	.4byte	0x5b
	.uleb128 0x2
	.4byte	$LC111
	.byte	0x7
	.byte	0x4a
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC112
	.byte	0x7
	.byte	0x4f
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC113
	.byte	0x7
	.byte	0x54
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC114
	.byte	0x7
	.byte	0x59
	.4byte	0xa3
	.uleb128 0x2
	.4byte	$LC115
	.byte	0x7
	.byte	0x5d
	.4byte	0x37
	.uleb128 0x2
	.4byte	$LC116
	.byte	0x7
	.byte	0x5e
	.4byte	0x5b
	.uleb128 0x2
	.4byte	$LC117
	.byte	0x7
	.byte	0x5f
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC118
	.byte	0x7
	.byte	0x60
	.4byte	0xa3
	.uleb128 0x2
	.4byte	$LC119
	.byte	0x8
	.byte	0x3a
	.4byte	0xee
	.uleb128 0x2
	.4byte	$LC120
	.byte	0x8
	.byte	0x3f
	.4byte	0xf9
	.uleb128 0x2
	.4byte	$LC121
	.byte	0x7
	.byte	0x65
	.4byte	0x42
	.uleb128 0x2
	.4byte	$LC122
	.byte	0x7
	.byte	0x66
	.4byte	0x66
	.uleb128 0x2
	.4byte	$LC123
	.byte	0x7
	.byte	0x67
	.4byte	0x8a
	.uleb128 0x2
	.4byte	$LC124
	.byte	0x7
	.byte	0x68
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC125
	.byte	0x7
	.byte	0x6a
	.4byte	0x42
	.uleb128 0x2
	.4byte	$LC126
	.byte	0x7
	.byte	0x6b
	.4byte	0x66
	.uleb128 0x2
	.4byte	$LC127
	.byte	0x7
	.byte	0x6c
	.4byte	0x8a
	.uleb128 0x2
	.4byte	$LC128
	.byte	0x7
	.byte	0x6d
	.4byte	0x3f6
	.uleb128 0x2
	.4byte	$LC129
	.byte	0x7
	.byte	0x6f
	.4byte	0x50a
	.uleb128 0x2
	.4byte	$LC130
	.byte	0x7
	.byte	0x72
	.4byte	0xa3
	.uleb128 0x2
	.4byte	$LC131
	.byte	0x7
	.byte	0x73
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC132
	.byte	0x7
	.byte	0x74
	.4byte	0x56d
	.uleb128 0x5
	.byte	0x4
	.4byte	0x557
	.uleb128 0x2
	.4byte	$LC133
	.byte	0x7
	.byte	0x80
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC134
	.byte	0x7
	.byte	0x81
	.4byte	0xa3
	.uleb128 0x2
	.4byte	$LC135
	.byte	0x7
	.byte	0x83
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC136
	.byte	0x7
	.byte	0x84
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC137
	.byte	0x7
	.byte	0x87
	.4byte	0x146
	.uleb128 0x2
	.4byte	$LC138
	.byte	0x7
	.byte	0x8c
	.4byte	0x151
	.uleb128 0x2
	.4byte	$LC139
	.byte	0x7
	.byte	0x91
	.4byte	0xcb
	.uleb128 0x2
	.4byte	$LC140
	.byte	0x7
	.byte	0x99
	.4byte	0x91
	.uleb128 0x2
	.4byte	$LC141
	.byte	0x7
	.byte	0x9c
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC142
	.byte	0x7
	.byte	0x9d
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC143
	.byte	0x7
	.byte	0xa0
	.4byte	0xe3
	.uleb128 0x2
	.4byte	$LC144
	.byte	0x7
	.byte	0xa4
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC145
	.byte	0x7
	.byte	0xa5
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC146
	.byte	0x7
	.byte	0xa6
	.4byte	0x3e4
	.uleb128 0x2
	.4byte	$LC147
	.byte	0x7
	.byte	0xa9
	.4byte	0x104
	.uleb128 0x2
	.4byte	$LC148
	.byte	0x7
	.byte	0xad
	.4byte	0x7f
	.uleb128 0x2
	.4byte	$LC149
	.byte	0x7
	.byte	0xb5
	.4byte	0x11a
	.uleb128 0x2
	.4byte	$LC150
	.byte	0x7
	.byte	0xb8
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC151
	.byte	0x7
	.byte	0xb9
	.4byte	0x557
	.uleb128 0x2
	.4byte	$LC152
	.byte	0x7
	.byte	0xba
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC153
	.byte	0x7
	.byte	0xbb
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC154
	.byte	0x7
	.byte	0xbe
	.4byte	0x13b
	.uleb128 0x2
	.4byte	$LC155
	.byte	0x7
	.byte	0xc2
	.4byte	0x6d
	.uleb128 0x2
	.4byte	$LC156
	.byte	0x7
	.byte	0xfc
	.4byte	0x3f6
	.uleb128 0x11
	.4byte	$LC157
	.byte	0x7
	.2byte	0x107
	.4byte	0x78
	.uleb128 0x11
	.4byte	$LC158
	.byte	0x7
	.2byte	0x10c
	.4byte	0x3e4
	.uleb128 0x11
	.4byte	$LC159
	.byte	0x7
	.2byte	0x111
	.4byte	0x78
	.uleb128 0x11
	.4byte	$LC160
	.byte	0x7
	.2byte	0x116
	.4byte	0x78
	.uleb128 0x11
	.4byte	$LC161
	.byte	0x7
	.2byte	0x11b
	.4byte	0x78
	.uleb128 0x11
	.4byte	$LC162
	.byte	0x7
	.2byte	0x120
	.4byte	0x8a
	.uleb128 0x11
	.4byte	$LC163
	.byte	0x7
	.2byte	0x12d
	.4byte	0x6d
	.uleb128 0x13
	.4byte	0x6ec
	.4byte	$LC164
	.byte	0x20
	.byte	0x7
	.2byte	0x142
	.uleb128 0x14
	.4byte	$LC165
	.byte	0x7
	.2byte	0x143
	.4byte	0x6ec
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.byte	0x0
	.uleb128 0x8
	.4byte	0x6fc
	.4byte	0x6c3
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x7
	.byte	0x0
	.uleb128 0x11
	.4byte	$LC164
	.byte	0x7
	.2byte	0x144
	.4byte	0x6cf
	.uleb128 0x2
	.4byte	$LC166
	.byte	0x9
	.byte	0x2e
	.4byte	0x44a
	.uleb128 0xa
	.4byte	0x73c
	.4byte	$LC167
	.byte	0x8
	.byte	0x9
	.byte	0x39
	.uleb128 0xb
	.4byte	$LC168
	.byte	0x9
	.byte	0x39
	.4byte	0x742
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC169
	.byte	0x9
	.byte	0x39
	.4byte	0x748
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x15
	.4byte	$LC262
	.byte	0x1
	.uleb128 0x5
	.byte	0x4
	.4byte	0x73c
	.uleb128 0x5
	.byte	0x4
	.4byte	0x742
	.uleb128 0x2
	.4byte	$LC170
	.byte	0x9
	.byte	0x47
	.4byte	0x742
	.uleb128 0x2
	.4byte	$LC171
	.byte	0x9
	.byte	0x48
	.4byte	0x764
	.uleb128 0xa
	.4byte	0x79b
	.4byte	$LC172
	.byte	0xc
	.byte	0x9
	.byte	0x3c
	.uleb128 0xb
	.4byte	$LC173
	.byte	0x9
	.byte	0x56
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC174
	.byte	0x9
	.byte	0x58
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC175
	.byte	0x9
	.byte	0x59
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC176
	.byte	0x9
	.byte	0x49
	.4byte	0x7a6
	.uleb128 0xa
	.4byte	0x807
	.4byte	$LC177
	.byte	0x1c
	.byte	0x9
	.byte	0x3d
	.uleb128 0xb
	.4byte	$LC178
	.byte	0x9
	.byte	0x5d
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC179
	.byte	0x9
	.byte	0x66
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC180
	.byte	0x9
	.byte	0x69
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.uleb128 0xb
	.4byte	$LC181
	.byte	0x9
	.byte	0x6a
	.4byte	0x74e
	.byte	0x2
	.byte	0x10
	.uleb128 0xc
	.uleb128 0xb
	.4byte	$LC182
	.byte	0x9
	.byte	0x6b
	.4byte	0x713
	.byte	0x2
	.byte	0x10
	.uleb128 0x10
	.uleb128 0xb
	.4byte	$LC183
	.byte	0x9
	.byte	0x6c
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x18
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC184
	.byte	0x9
	.byte	0x4a
	.4byte	0x812
	.uleb128 0xa
	.4byte	0x83b
	.4byte	$LC185
	.byte	0x8
	.byte	0x9
	.byte	0x3e
	.uleb128 0xb
	.4byte	$LC186
	.byte	0x9
	.byte	0x7c
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC187
	.byte	0x9
	.byte	0x7d
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC188
	.byte	0x9
	.byte	0x4b
	.4byte	0x846
	.uleb128 0xa
	.4byte	0x899
	.4byte	$LC189
	.byte	0x18
	.byte	0x9
	.byte	0x3f
	.uleb128 0xb
	.4byte	$LC190
	.byte	0x9
	.byte	0x85
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC191
	.byte	0x9
	.byte	0x88
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC192
	.byte	0x9
	.byte	0x89
	.4byte	0x713
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.uleb128 0xb
	.4byte	$LC193
	.byte	0x9
	.byte	0x8b
	.4byte	0xaaa
	.byte	0x2
	.byte	0x10
	.uleb128 0x10
	.uleb128 0xb
	.4byte	$LC194
	.byte	0x9
	.byte	0x8c
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x14
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC195
	.byte	0x9
	.byte	0x4c
	.4byte	0x8a4
	.uleb128 0xa
	.4byte	0x8cd
	.4byte	$LC196
	.byte	0x8
	.byte	0x9
	.byte	0x40
	.uleb128 0xb
	.4byte	$LC197
	.byte	0x9
	.byte	0x9a
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC198
	.byte	0x9
	.byte	0x9b
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC199
	.byte	0x9
	.byte	0x4d
	.4byte	0x8d8
	.uleb128 0xa
	.4byte	0x901
	.4byte	$LC200
	.byte	0x20
	.byte	0x9
	.byte	0x4d
	.uleb128 0xb
	.4byte	$LC201
	.byte	0x9
	.byte	0xa2
	.4byte	0x79b
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC202
	.byte	0x9
	.byte	0xa3
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x1c
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC203
	.byte	0x9
	.byte	0x4e
	.4byte	0x90c
	.uleb128 0xa
	.4byte	0x943
	.4byte	$LC204
	.byte	0xc
	.byte	0x9
	.byte	0x4e
	.uleb128 0xb
	.4byte	$LC205
	.byte	0x9
	.byte	0xa9
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC206
	.byte	0x9
	.byte	0xaa
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC207
	.byte	0x9
	.byte	0xab
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC208
	.byte	0x9
	.byte	0x4f
	.4byte	0x94e
	.uleb128 0xa
	.4byte	0x9bd
	.4byte	$LC209
	.byte	0x24
	.byte	0x9
	.byte	0x42
	.uleb128 0xb
	.4byte	$LC210
	.byte	0x9
	.byte	0xb9
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC211
	.byte	0x9
	.byte	0xbc
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC212
	.byte	0x9
	.byte	0xbe
	.4byte	0x713
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.uleb128 0xb
	.4byte	$LC213
	.byte	0x9
	.byte	0xbf
	.4byte	0x713
	.byte	0x2
	.byte	0x10
	.uleb128 0x10
	.uleb128 0xb
	.4byte	$LC214
	.byte	0x9
	.byte	0xc0
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x18
	.uleb128 0xb
	.4byte	$LC215
	.byte	0x9
	.byte	0xc1
	.4byte	0x74e
	.byte	0x2
	.byte	0x10
	.uleb128 0x1c
	.uleb128 0xb
	.4byte	$LC216
	.byte	0x9
	.byte	0xc2
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x20
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC217
	.byte	0x9
	.byte	0x50
	.4byte	0x9c8
	.uleb128 0xa
	.4byte	0x9f1
	.4byte	$LC218
	.byte	0x8
	.byte	0x9
	.byte	0x43
	.uleb128 0xb
	.4byte	$LC219
	.byte	0x9
	.byte	0xd2
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC220
	.byte	0x9
	.byte	0xd3
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC221
	.byte	0x9
	.byte	0x51
	.4byte	0x9fc
	.uleb128 0xa
	.4byte	0xa6b
	.4byte	$LC222
	.byte	0x20
	.byte	0x9
	.byte	0x44
	.uleb128 0xb
	.4byte	$LC223
	.byte	0x9
	.byte	0xda
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC224
	.byte	0x9
	.byte	0xdd
	.4byte	0x44a
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.uleb128 0xb
	.4byte	$LC225
	.byte	0x9
	.byte	0xdf
	.4byte	0x713
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.uleb128 0xb
	.4byte	$LC226
	.byte	0x9
	.byte	0xe0
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x10
	.uleb128 0xb
	.4byte	$LC227
	.byte	0x9
	.byte	0xe1
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x14
	.uleb128 0xb
	.4byte	$LC228
	.byte	0x9
	.byte	0xe2
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x18
	.uleb128 0xb
	.4byte	$LC229
	.byte	0x9
	.byte	0xe4
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x1c
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC230
	.byte	0x9
	.byte	0x52
	.4byte	0xa76
	.uleb128 0xa
	.4byte	0xa9f
	.4byte	$LC231
	.byte	0x8
	.byte	0x9
	.byte	0x45
	.uleb128 0xb
	.4byte	$LC232
	.byte	0x9
	.byte	0xeb
	.4byte	0x8a
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xb
	.4byte	$LC233
	.byte	0x9
	.byte	0xec
	.4byte	0x31f
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC234
	.byte	0x9
	.byte	0x53
	.4byte	0x78
	.uleb128 0x5
	.byte	0x4
	.4byte	0x79b
	.uleb128 0x2
	.4byte	$LC235
	.byte	0xa
	.byte	0x34
	.4byte	0x78
	.uleb128 0x16
	.4byte	0xae0
	.byte	0x8
	.byte	0xa
	.byte	0x3b
	.uleb128 0xb
	.4byte	$LC236
	.byte	0xa
	.byte	0x39
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xc
	.ascii	"rem\000"
	.byte	0xa
	.byte	0x3a
	.4byte	0x78
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC237
	.byte	0xa
	.byte	0x3b
	.4byte	0xabb
	.uleb128 0x16
	.4byte	0xb10
	.byte	0x8
	.byte	0xa
	.byte	0x40
	.uleb128 0xb
	.4byte	$LC236
	.byte	0xa
	.byte	0x3e
	.4byte	0x3e4
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xc
	.ascii	"rem\000"
	.byte	0xa
	.byte	0x3f
	.4byte	0x3e4
	.byte	0x2
	.byte	0x10
	.uleb128 0x4
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC238
	.byte	0xa
	.byte	0x40
	.4byte	0xaeb
	.uleb128 0x16
	.4byte	0xb40
	.byte	0x10
	.byte	0xa
	.byte	0x4a
	.uleb128 0xb
	.4byte	$LC236
	.byte	0xa
	.byte	0x47
	.4byte	0x9c
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xc
	.ascii	"rem\000"
	.byte	0xa
	.byte	0x49
	.4byte	0x9c
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC239
	.byte	0xa
	.byte	0x4a
	.4byte	0xb1b
	.uleb128 0x16
	.4byte	0xb70
	.byte	0x10
	.byte	0xa
	.byte	0x51
	.uleb128 0xb
	.4byte	$LC236
	.byte	0xa
	.byte	0x4f
	.4byte	0x557
	.byte	0x2
	.byte	0x10
	.uleb128 0x0
	.uleb128 0xc
	.ascii	"rem\000"
	.byte	0xa
	.byte	0x50
	.4byte	0x557
	.byte	0x2
	.byte	0x10
	.uleb128 0x8
	.byte	0x0
	.uleb128 0x2
	.4byte	$LC240
	.byte	0xa
	.byte	0x51
	.4byte	0xb4b
	.uleb128 0x17
	.byte	0x1
	.4byte	$LC241
	.byte	0x1
	.byte	0x15
	.4byte	0x78
	.4byte	$LFB29
	.4byte	$LFE29
	.4byte	$LSFDE0
	.byte	0x1
	.byte	0x6e
	.uleb128 0x17
	.byte	0x1
	.4byte	$LC242
	.byte	0x1
	.byte	0x22
	.4byte	0x78
	.4byte	$LFB31
	.4byte	$LFE31
	.4byte	$LSFDE2
	.byte	0x1
	.byte	0x6e
	.uleb128 0x18
	.4byte	0xc25
	.byte	0x1
	.4byte	$LC245
	.byte	0x1
	.byte	0x36
	.byte	0x1
	.4byte	0xd6
	.4byte	$LFB33
	.4byte	$LFE33
	.4byte	$LSFDE4
	.byte	0x1
	.byte	0x6e
	.uleb128 0x19
	.4byte	$LC247
	.byte	0x1
	.byte	0x36
	.4byte	0xc25
	.byte	0x2
	.byte	0x91
	.sleb128 56
	.uleb128 0x1a
	.4byte	$LC243
	.byte	0x1
	.byte	0x38
	.4byte	0x3e4
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1a
	.4byte	$LC244
	.byte	0x1
	.byte	0x39
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 28
	.uleb128 0x1b
	.4byte	$LBB3
	.4byte	$LBE3
	.uleb128 0x1c
	.ascii	"i\000"
	.byte	0x1
	.byte	0x48
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x1b
	.4byte	$LBB4
	.4byte	$LBE4
	.uleb128 0x1c
	.ascii	"j\000"
	.byte	0x1
	.byte	0x4a
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 36
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0x3c2
	.uleb128 0x18
	.4byte	0xcc5
	.byte	0x1
	.4byte	$LC246
	.byte	0x1
	.byte	0x54
	.byte	0x1
	.4byte	0xd6
	.4byte	$LFB35
	.4byte	$LFE35
	.4byte	$LSFDE6
	.byte	0x1
	.byte	0x6e
	.uleb128 0x1d
	.ascii	"src\000"
	.byte	0x1
	.byte	0x54
	.4byte	0xd6
	.byte	0x3
	.byte	0x91
	.sleb128 88
	.uleb128 0x1d
	.ascii	"len\000"
	.byte	0x1
	.byte	0x54
	.4byte	0x19d
	.byte	0x3
	.byte	0x91
	.sleb128 92
	.uleb128 0x1c
	.ascii	"i\000"
	.byte	0x1
	.byte	0x55
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1c
	.ascii	"j\000"
	.byte	0x1
	.byte	0x56
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 28
	.uleb128 0x1c
	.ascii	"l\000"
	.byte	0x1
	.byte	0x57
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x1a
	.4byte	$LC248
	.byte	0x1
	.byte	0x59
	.4byte	0x19d
	.byte	0x2
	.byte	0x91
	.sleb128 36
	.uleb128 0x1c
	.ascii	"dec\000"
	.byte	0x1
	.byte	0x5a
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x1c
	.ascii	"buf\000"
	.byte	0x1
	.byte	0x5b
	.4byte	0x3a2
	.byte	0x2
	.byte	0x91
	.sleb128 48
	.uleb128 0x1c
	.ascii	"tmp\000"
	.byte	0x1
	.byte	0x5c
	.4byte	0xcc5
	.byte	0x2
	.byte	0x91
	.sleb128 56
	.byte	0x0
	.uleb128 0x8
	.4byte	0xcd5
	.4byte	0x42
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x3
	.byte	0x0
	.uleb128 0x18
	.4byte	0xd63
	.byte	0x1
	.4byte	$LC249
	.byte	0x1
	.byte	0xb5
	.byte	0x1
	.4byte	0xd6
	.4byte	$LFB37
	.4byte	$LFE37
	.4byte	$LSFDE8
	.byte	0x1
	.byte	0x6e
	.uleb128 0x1d
	.ascii	"src\000"
	.byte	0x1
	.byte	0xb5
	.4byte	0xd6
	.byte	0x3
	.byte	0x91
	.sleb128 80
	.uleb128 0x1d
	.ascii	"len\000"
	.byte	0x1
	.byte	0xb5
	.4byte	0x19d
	.byte	0x3
	.byte	0x91
	.sleb128 84
	.uleb128 0x1c
	.ascii	"i\000"
	.byte	0x1
	.byte	0xb6
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1c
	.ascii	"j\000"
	.byte	0x1
	.byte	0xb7
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 28
	.uleb128 0x1c
	.ascii	"enc\000"
	.byte	0x1
	.byte	0xb8
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x1a
	.4byte	$LC248
	.byte	0x1
	.byte	0xb9
	.4byte	0x19d
	.byte	0x2
	.byte	0x91
	.sleb128 36
	.uleb128 0x1c
	.ascii	"buf\000"
	.byte	0x1
	.byte	0xba
	.4byte	0xcc5
	.byte	0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x1c
	.ascii	"tmp\000"
	.byte	0x1
	.byte	0xbb
	.4byte	0x3a2
	.byte	0x2
	.byte	0x91
	.sleb128 48
	.byte	0x0
	.uleb128 0x18
	.4byte	0xe1b
	.byte	0x1
	.4byte	$LC250
	.byte	0x1
	.byte	0xf2
	.byte	0x1
	.4byte	0x78
	.4byte	$LFB39
	.4byte	$LFE39
	.4byte	$LSFDE10
	.byte	0x1
	.byte	0x6e
	.uleb128 0x19
	.4byte	$LC251
	.byte	0x1
	.byte	0xf2
	.4byte	0x78
	.byte	0x3
	.byte	0x91
	.sleb128 72
	.uleb128 0x19
	.4byte	$LC252
	.byte	0x1
	.byte	0xf2
	.4byte	0xe1b
	.byte	0x3
	.byte	0x91
	.sleb128 76
	.uleb128 0x1a
	.4byte	$LC253
	.byte	0x1
	.byte	0xf4
	.4byte	0xc25
	.byte	0x2
	.byte	0x91
	.sleb128 24
	.uleb128 0x1a
	.4byte	$LC254
	.byte	0x1
	.byte	0xf5
	.4byte	0xc25
	.byte	0x2
	.byte	0x91
	.sleb128 28
	.uleb128 0x1a
	.4byte	$LC255
	.byte	0x1
	.byte	0xf6
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 32
	.uleb128 0x1a
	.4byte	$LC256
	.byte	0x1
	.byte	0xf7
	.4byte	0xe21
	.byte	0x2
	.byte	0x91
	.sleb128 36
	.uleb128 0x1a
	.4byte	$LC257
	.byte	0x1
	.byte	0xf8
	.4byte	0xe21
	.byte	0x2
	.byte	0x91
	.sleb128 37
	.uleb128 0x1e
	.4byte	$LC258
	.byte	0x1
	.2byte	0x12b
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 40
	.uleb128 0x1e
	.4byte	$LC259
	.byte	0x1
	.2byte	0x132
	.4byte	0xd6
	.byte	0x2
	.byte	0x91
	.sleb128 44
	.uleb128 0x1b
	.4byte	$LBB8
	.4byte	$LBE8
	.uleb128 0x1c
	.ascii	"i\000"
	.byte	0x1
	.byte	0xfa
	.4byte	0x78
	.byte	0x2
	.byte	0x91
	.sleb128 40
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.byte	0x4
	.4byte	0xd6
	.uleb128 0x3
	.4byte	$LC260
	.byte	0x1
	.byte	0x2
	.uleb128 0x1f
	.byte	0x1
	.4byte	0x3c2
	.uleb128 0x20
	.4byte	$LC261
	.byte	0x5
	.byte	0x8d
	.4byte	0xe28
	.byte	0x1
	.byte	0x1
	.uleb128 0x15
	.4byte	$LC263
	.byte	0x1
	.uleb128 0x20
	.4byte	$LC264
	.byte	0xb
	.byte	0x36
	.4byte	0xe4e
	.byte	0x1
	.byte	0x1
	.uleb128 0x5
	.byte	0x4
	.4byte	0xe54
	.uleb128 0x10
	.4byte	0x42
	.uleb128 0x8
	.4byte	0xe69
	.4byte	0x397
	.uleb128 0x9
	.4byte	0x18b
	.byte	0x3f
	.byte	0x0
	.uleb128 0x1a
	.4byte	$LC265
	.byte	0x1
	.byte	0xa
	.4byte	0xe7a
	.byte	0x5
	.byte	0x3
	.4byte	b64_table
	.uleb128 0x10
	.4byte	0xe59
	.byte	0x0
	.section	.debug_abbrev
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x6
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x8
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x9
	.uleb128 0x21
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xc
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0xd
	.uleb128 0xf
	.byte	0x0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0xe
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x10
	.uleb128 0x26
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x11
	.uleb128 0x16
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x12
	.uleb128 0x35
	.byte	0x0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x13
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.byte	0x0
	.byte	0x0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x15
	.uleb128 0x13
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.uleb128 0x16
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x0
	.byte	0x0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x2001
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x1
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x2001
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.byte	0x0
	.byte	0x0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1d
	.uleb128 0x5
	.byte	0x0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0x0
	.byte	0x0
	.uleb128 0x1f
	.uleb128 0x1
	.byte	0x0
	.uleb128 0x3c
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0x0
	.byte	0x0
	.uleb128 0x20
	.uleb128 0x34
	.byte	0x0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.section	.debug_pubnames,"",@progbits
	.4byte	0x5f
	.2byte	0x2
	.4byte	$Ldebug_info0
	.4byte	0xe80
	.4byte	0xb7b
	.ascii	"show_version\000"
	.4byte	0xb95
	.ascii	"show_help\000"
	.4byte	0xbaf
	.ascii	"reader\000"
	.4byte	0xc2b
	.ascii	"b64_decode\000"
	.4byte	0xcd5
	.ascii	"b64_encode\000"
	.4byte	0xd63
	.ascii	"main\000"
	.4byte	0x0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	$Ldebug_info0
	.byte	0x4
	.byte	0x0
	.2byte	0x0
	.2byte	0x0
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	0x0
	.4byte	0x0
	.section	.debug_str,"MS",@progbits,1
$LC89:
	.ascii	"_ext\000"
$LC79:
	.ascii	"_size\000"
$LC160:
	.ascii	"timer_t\000"
$LC176:
	.ascii	"pthread_mutex_t\000"
$LC218:
	.ascii	"__pthread_rwlockattr_st\000"
$LC172:
	.ascii	"__pthread_attr_st\000"
$LC112:
	.ascii	"uint32_t\000"
$LC180:
	.ascii	"ptm_interlock\000"
$LC102:
	.ascii	"psize_t\000"
$LC47:
	.ascii	"short unsigned int\000"
$LC83:
	.ascii	"_lbfsize\000"
$LC167:
	.ascii	"pthread_queue_t\000"
$LC43:
	.ascii	"unsigned char\000"
$LC200:
	.ascii	"__pthread_once_st\000"
$LC147:
	.ascii	"mode_t\000"
$LC162:
	.ascii	"useconds_t\000"
$LC225:
	.ascii	"ptb_waiters\000"
$LC220:
	.ascii	"ptra_private\000"
$LC187:
	.ascii	"ptma_private\000"
$LC95:
	.ascii	"off_t\000"
$LC214:
	.ascii	"ptr_nreaders\000"
$LC265:
	.ascii	"b64_table\000"
$LC216:
	.ascii	"ptr_private\000"
$LC77:
	.ascii	"__sbuf\000"
$LC253:
	.ascii	"input\000"
$LC87:
	.ascii	"_seek\000"
$LC61:
	.ascii	"__in_port_t\000"
$LC73:
	.ascii	"size_t\000"
$LC133:
	.ascii	"longlong_t\000"
$LC144:
	.ascii	"id_t\000"
$LC86:
	.ascii	"_read\000"
$LC134:
	.ascii	"u_longlong_t\000"
$LC63:
	.ascii	"__off_t\000"
$LC179:
	.ascii	"ptm_lock\000"
$LC210:
	.ascii	"ptr_magic\000"
$LC219:
	.ascii	"ptra_magic\000"
$LC202:
	.ascii	"pto_done\000"
$LC100:
	.ascii	"mips_fpreg_t\000"
$LC69:
	.ascii	"__fsfilcnt_t\000"
$LC161:
	.ascii	"suseconds_t\000"
$LC138:
	.ascii	"fsfilcnt_t\000"
$LC129:
	.ascii	"cpuid_t\000"
$LC80:
	.ascii	"__sFILE\000"
$LC70:
	.ascii	"__mbstate8\000"
$LC98:
	.ascii	"mips_ureg_t\000"
$LC168:
	.ascii	"ptqh_first\000"
$LC123:
	.ascii	"u_int\000"
$LC107:
	.ascii	"int8_t\000"
$LC163:
	.ascii	"__fd_mask\000"
$LC71:
	.ascii	"__mbstateL\000"
$LC206:
	.ascii	"pts_spin\000"
$LC244:
	.ascii	"buffer\000"
$LC125:
	.ascii	"unchar\000"
$LC247:
	.ascii	"miFile\000"
$LC136:
	.ascii	"blksize_t\000"
$LC188:
	.ascii	"pthread_cond_t\000"
$LC254:
	.ascii	"output\000"
$LC183:
	.ascii	"ptm_private\000"
$LC186:
	.ascii	"ptma_magic\000"
$LC264:
	.ascii	"_ctype_\000"
$LC237:
	.ascii	"div_t\000"
$LC240:
	.ascii	"qdiv_t\000"
$LC266:
	.ascii	"main.c\000"
$LC224:
	.ascii	"ptb_lock\000"
$LC85:
	.ascii	"_close\000"
$LC213:
	.ascii	"ptr_wblocked\000"
$LC145:
	.ascii	"ino_t\000"
$LC75:
	.ascii	"fpos_t\000"
$LC257:
	.ascii	"showHelp\000"
$LC53:
	.ascii	"__uint64_t\000"
$LC149:
	.ascii	"pid_t\000"
$LC104:
	.ascii	"vsize_t\000"
$LC114:
	.ascii	"uint64_t\000"
$LC164:
	.ascii	"fd_set\000"
$LC252:
	.ascii	"argv\000"
$LC84:
	.ascii	"_cookie\000"
$LC239:
	.ascii	"lldiv_t\000"
$LC99:
	.ascii	"long unsigned int\000"
$LC198:
	.ascii	"ptca_private\000"
$LC261:
	.ascii	"__sF\000"
$LC76:
	.ascii	"__sfpos\000"
$LC64:
	.ascii	"__pid_t\000"
$LC92:
	.ascii	"_blksize\000"
$LC78:
	.ascii	"_base\000"
$LC146:
	.ascii	"key_t\000"
$LC132:
	.ascii	"qaddr_t\000"
$LC251:
	.ascii	"argc\000"
$LC49:
	.ascii	"__uint32_t\000"
$LC245:
	.ascii	"reader\000"
$LC221:
	.ascii	"pthread_barrier_t\000"
$LC194:
	.ascii	"ptc_private\000"
$LC236:
	.ascii	"quot\000"
$LC141:
	.ascii	"dev_t\000"
$LC156:
	.ascii	"clock_t\000"
$LC259:
	.ascii	"result\000"
$LC150:
	.ascii	"lwpid_t\000"
$LC90:
	.ascii	"_ubuf\000"
$LC91:
	.ascii	"_nbuf\000"
$LC45:
	.ascii	"short int\000"
$LC115:
	.ascii	"u_int8_t\000"
$LC195:
	.ascii	"pthread_condattr_t\000"
$LC113:
	.ascii	"int64_t\000"
$LC154:
	.ascii	"uid_t\000"
$LC232:
	.ascii	"ptba_magic\000"
$LC52:
	.ascii	"long long int\000"
$LC231:
	.ascii	"__pthread_barrierattr_st\000"
$LC217:
	.ascii	"pthread_rwlockattr_t\000"
$LC246:
	.ascii	"b64_decode\000"
$LC142:
	.ascii	"fixpt_t\000"
$LC249:
	.ascii	"b64_encode\000"
$LC140:
	.ascii	"daddr_t\000"
$LC250:
	.ascii	"main\000"
$LC54:
	.ascii	"long long unsigned int\000"
$LC268:
	.ascii	"GNU C 3.3.3 (NetBSD nb3 20040520) -g\000"
$LC67:
	.ascii	"__uid_t\000"
$LC94:
	.ascii	"FILE\000"
$LC46:
	.ascii	"__uint16_t\000"
$LC148:
	.ascii	"nlink_t\000"
$LC153:
	.ascii	"swblk_t\000"
$LC166:
	.ascii	"pthread_spin_t\000"
$LC152:
	.ascii	"segsz_t\000"
$LC230:
	.ascii	"pthread_barrierattr_t\000"
$LC242:
	.ascii	"show_help\000"
$LC155:
	.ascii	"dtime_t\000"
$LC58:
	.ascii	"char\000"
$LC238:
	.ascii	"ldiv_t\000"
$LC256:
	.ascii	"showVersion\000"
$LC197:
	.ascii	"ptca_magic\000"
$LC101:
	.ascii	"paddr_t\000"
$LC223:
	.ascii	"ptb_magic\000"
$LC227:
	.ascii	"ptb_curcount\000"
$LC111:
	.ascii	"int32_t\000"
$LC255:
	.ascii	"action\000"
$LC199:
	.ascii	"pthread_once_t\000"
$LC103:
	.ascii	"vaddr_t\000"
$LC233:
	.ascii	"ptba_private\000"
$LC174:
	.ascii	"pta_flags\000"
$LC267:
	.ascii	"/root/orga\000"
$LC108:
	.ascii	"uint8_t\000"
$LC191:
	.ascii	"ptc_lock\000"
$LC96:
	.ascii	"mips_reg_t\000"
$LC212:
	.ascii	"ptr_rblocked\000"
$LC139:
	.ascii	"caddr_t\000"
$LC204:
	.ascii	"__pthread_spinlock_st\000"
$LC229:
	.ascii	"ptb_private\000"
$LC209:
	.ascii	"__pthread_rwlock_st\000"
$LC190:
	.ascii	"ptc_magic\000"
$LC127:
	.ascii	"uint\000"
$LC196:
	.ascii	"__pthread_condattr_st\000"
$LC207:
	.ascii	"pts_flags\000"
$LC193:
	.ascii	"ptc_mutex\000"
$LC262:
	.ascii	"__pthread_st\000"
$LC260:
	.ascii	"_Bool\000"
$LC81:
	.ascii	"_flags\000"
$LC208:
	.ascii	"pthread_rwlock_t\000"
$LC55:
	.ascii	"__intptr_t\000"
$LC74:
	.ascii	"_pos\000"
$LC109:
	.ascii	"int16_t\000"
$LC135:
	.ascii	"blkcnt_t\000"
$LC235:
	.ascii	"wchar_t\000"
$LC201:
	.ascii	"pto_mutex\000"
$LC203:
	.ascii	"pthread_spinlock_t\000"
$LC175:
	.ascii	"pta_private\000"
$LC42:
	.ascii	"signed char\000"
$LC177:
	.ascii	"__pthread_mutex_st\000"
$LC258:
	.ascii	"target\000"
$LC62:
	.ascii	"__mode_t\000"
$LC105:
	.ascii	"register_t\000"
$LC182:
	.ascii	"ptm_blocked\000"
$LC159:
	.ascii	"clockid_t\000"
$LC228:
	.ascii	"ptb_generation\000"
$LC50:
	.ascii	"unsigned int\000"
$LC131:
	.ascii	"quad_t\000"
$LC124:
	.ascii	"u_long\000"
$LC215:
	.ascii	"ptr_writer\000"
$LC211:
	.ascii	"ptr_interlock\000"
$LC118:
	.ascii	"u_int64_t\000"
$LC184:
	.ascii	"pthread_mutexattr_t\000"
$LC181:
	.ascii	"ptm_owner\000"
$LC234:
	.ascii	"pthread_key_t\000"
$LC128:
	.ascii	"ulong\000"
$LC121:
	.ascii	"u_char\000"
$LC66:
	.ascii	"__socklen_t\000"
$LC157:
	.ascii	"ssize_t\000"
$LC189:
	.ascii	"__pthread_cond_st\000"
$LC51:
	.ascii	"__int64_t\000"
$LC170:
	.ascii	"pthread_t\000"
$LC82:
	.ascii	"_file\000"
$LC119:
	.ascii	"in_addr_t\000"
$LC40:
	.ascii	"__int8_t\000"
$LC241:
	.ascii	"show_version\000"
$LC68:
	.ascii	"__fsblkcnt_t\000"
$LC143:
	.ascii	"gid_t\000"
$LC137:
	.ascii	"fsblkcnt_t\000"
$LC106:
	.ascii	"__cpu_simple_lock_t\000"
$LC117:
	.ascii	"u_int32_t\000"
$LC93:
	.ascii	"_offset\000"
$LC72:
	.ascii	"__mbstate_t\000"
$LC169:
	.ascii	"ptqh_last\000"
$LC126:
	.ascii	"ushort\000"
$LC56:
	.ascii	"__uintptr_t\000"
$LC59:
	.ascii	"__gid_t\000"
$LC48:
	.ascii	"__int32_t\000"
$LC226:
	.ascii	"ptb_initcount\000"
$LC185:
	.ascii	"__pthread_mutexattr_st\000"
$LC88:
	.ascii	"_write\000"
$LC41:
	.ascii	"__uint8_t\000"
$LC165:
	.ascii	"fds_bits\000"
$LC173:
	.ascii	"pta_magic\000"
$LC263:
	.ascii	"__pthread_spin_st\000"
$LC110:
	.ascii	"uint16_t\000"
$LC248:
	.ascii	"size\000"
$LC97:
	.ascii	"long int\000"
$LC171:
	.ascii	"pthread_attr_t\000"
$LC57:
	.ascii	"__caddr_t\000"
$LC120:
	.ascii	"in_port_t\000"
$LC243:
	.ascii	"lSize\000"
$LC222:
	.ascii	"__pthread_barrier_st\000"
$LC116:
	.ascii	"u_int16_t\000"
$LC158:
	.ascii	"time_t\000"
$LC178:
	.ascii	"ptm_magic\000"
$LC130:
	.ascii	"u_quad_t\000"
$LC205:
	.ascii	"pts_magic\000"
$LC60:
	.ascii	"__in_addr_t\000"
$LC151:
	.ascii	"rlim_t\000"
$LC65:
	.ascii	"__sa_family_t\000"
$LC122:
	.ascii	"u_short\000"
$LC44:
	.ascii	"__int16_t\000"
$LC192:
	.ascii	"ptc_waiters\000"
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
