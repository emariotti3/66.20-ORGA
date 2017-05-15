	.file	1 "base64.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
	.type	letters, @object
	.size	letters, 65
letters:
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
	.byte	61
	.align	3
$LC0:
	.word	0
	.word	1075314688
	.align	3
$LC1:
	.word	0
	.word	1075838976
	.align	3
$LC2:
	.word	0
	.word	1105199104
	.text
	.align	2
	.globl	encode_text_to_output
	.ent	encode_text_to_output
encode_text_to_output:
	.frame	$fp,96,$31		# vars= 56, regs= 4/0, args= 16, extra= 8
	.mask	0xd0010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,96
	.cprestore 16
	sw	$31,92($sp)
	sw	$fp,88($sp)
	sw	$28,84($sp)
	sw	$16,80($sp)
	move	$fp,$sp
	sw	$4,96($fp)
	sw	$5,100($fp)
	sw	$6,104($fp)
	sw	$7,108($fp)
	sw	$sp,48($fp)
	li	$2,4			# 0x4
	sw	$2,24($fp)
	lw	$2,112($fp)
	sll	$2,$2,3
	mtc1	$2,$f0
	cvt.d.w	$f2,$f0
	l.d	$f0,$LC0
	div.d	$f0,$f2,$f0
	mov.d	$f12,$f0
	la	$25,ceil
	jal	$31,$25
	trunc.w.d $f0,$f0,$2
	s.s	$f0,28($fp)
	sw	$0,32($fp)
	sw	$0,36($fp)
	sw	$0,40($fp)
	lw	$2,28($fp)
	addu	$2,$2,1
	addu	$2,$2,7
	srl	$2,$2,3
	sll	$2,$2,3
	subu	$sp,$sp,$2
	addu	$3,$sp,16
	sw	$3,52($fp)
	lw	$2,28($fp)
	addu	$2,$2,1
	lw	$4,52($fp)
	move	$5,$0
	move	$6,$2
	la	$25,memset
	jal	$31,$25
	la	$25,get_fill_char
	jal	$31,$25
	lw	$4,52($fp)
	move	$5,$2
	lw	$6,24($fp)
	la	$25,memset
	jal	$31,$25
	lw	$4,108($fp)
	la	$25,concantenate_binary_to_int
	jal	$31,$25
	sw	$2,32($fp)
	sw	$0,44($fp)
$L18:
	lw	$2,44($fp)
	lw	$3,28($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L21
	b	$L19
$L21:
	lw	$3,24($fp)
	lw	$2,44($fp)
	subu	$2,$3,$2
	addu	$2,$2,-1
	mtc1	$2,$f0
	cvt.d.w	$f2,$f0
	l.d	$f0,$LC0
	mul.d	$f2,$f2,$f0
	l.d	$f0,$LC1
	add.d	$f2,$f2,$f0
	s.d	$f2,56($fp)
	l.d	$f0,$LC2
	s.d	$f0,72($fp)
	l.d	$f2,56($fp)
	l.d	$f4,72($fp)
	c.le.d	$f4,$f2
	bc1t	$L22
	l.d	$f0,56($fp)
	trunc.w.d $f0,$f0,$2
	s.s	$f0,64($fp)
	b	$L23
$L22:
	l.d	$f2,56($fp)
	l.d	$f4,72($fp)
	sub.d	$f0,$f2,$f4
	li	$2,-2147483648			# 0xffffffff80000000
	trunc.w.d $f2,$f0,$4
	s.s	$f2,64($fp)
	lw	$3,64($fp)
	or	$3,$3,$2
	sw	$3,64($fp)
$L23:
	lw	$4,64($fp)
	sw	$4,40($fp)
	lw	$3,32($fp)
	lw	$2,40($fp)
	sra	$2,$3,$2
	andi	$2,$2,0x3f
	sw	$2,36($fp)
	lw	$2,44($fp)
	lw	$5,52($fp)
	addu	$16,$5,$2
	lw	$4,36($fp)
	la	$25,encode
	jal	$31,$25
	sb	$2,0($16)
	lw	$2,44($fp)
	addu	$2,$2,1
	sw	$2,44($fp)
	b	$L18
$L19:
	lw	$2,104($fp)
	bne	$2,$0,$L24
	lw	$4,100($fp)
	lw	$5,52($fp)
	lw	$6,24($fp)
	la	$25,write
	jal	$31,$25
	sw	$2,44($fp)
	lw	$3,44($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L24
	la	$25,__errno
	jal	$31,$25
	lw	$2,0($2)
	sw	$2,104($fp)
$L24:
	lw	$2,104($fp)
	lw	$sp,48($fp)
	move	$sp,$fp
	lw	$31,92($sp)
	lw	$fp,88($sp)
	lw	$16,80($sp)
	addu	$sp,$sp,96
	j	$31
	.end	encode_text_to_output
	.size	encode_text_to_output, .-encode_text_to_output
	.align	2
	.globl	encode_text
	.ent	encode_text
encode_text:
	.frame	$fp,72,$31		# vars= 24, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 24
	sw	$31,64($sp)
	sw	$fp,60($sp)
	sw	$28,56($sp)
	move	$fp,$sp
	sw	$4,72($fp)
	sw	$5,76($fp)
	sw	$0,32($fp)
	addu	$2,$fp,40
	move	$4,$2
	move	$5,$0
	li	$6,4			# 0x4
	la	$25,memset
	jal	$31,$25
	addu	$2,$fp,40
	lw	$4,72($fp)
	move	$5,$2
	li	$6,3			# 0x3
	la	$25,read
	jal	$31,$25
	sw	$2,48($fp)
$L27:
	lw	$2,32($fp)
	bne	$2,$0,$L28
	lw	$3,48($fp)
	li	$2,3			# 0x3
	beq	$3,$2,$L29
	b	$L28
$L29:
	addu	$3,$fp,40
	lw	$2,48($fp)
	sw	$2,16($sp)
	lw	$4,72($fp)
	lw	$5,76($fp)
	lw	$6,32($fp)
	move	$7,$3
	la	$25,encode_text_to_output
	jal	$31,$25
	addu	$2,$fp,40
	move	$4,$2
	move	$5,$0
	li	$6,4			# 0x4
	la	$25,memset
	jal	$31,$25
	addu	$2,$fp,40
	lw	$4,72($fp)
	move	$5,$2
	li	$6,3			# 0x3
	la	$25,read
	jal	$31,$25
	sw	$2,48($fp)
	b	$L27
$L28:
	lw	$2,32($fp)
	bne	$2,$0,$L31
	lw	$2,48($fp)
	blez	$2,$L31
	addu	$2,$fp,40
	lw	$3,48($fp)
	sw	$3,16($sp)
	lw	$4,72($fp)
	lw	$5,76($fp)
	lw	$6,32($fp)
	move	$7,$2
	la	$25,encode_text_to_output
	jal	$31,$25
	sw	$2,52($fp)
	b	$L26
$L31:
	lw	$2,32($fp)
	sw	$2,52($fp)
$L26:
	lw	$2,52($fp)
	move	$sp,$fp
	lw	$31,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$31
	.end	encode_text
	.size	encode_text, .-encode_text
	.align	2
	.globl	decode_to_output_file
	.ent	decode_to_output_file
decode_to_output_file:
	.frame	$fp,56,$31		# vars= 16, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,56
	.cprestore 16
	sw	$31,48($sp)
	sw	$fp,44($sp)
	sw	$28,40($sp)
	move	$fp,$sp
	sw	$4,56($fp)
	sw	$5,60($fp)
	sw	$6,64($fp)
	sw	$7,68($fp)
	addu	$4,$fp,24
	move	$5,$0
	li	$6,4			# 0x4
	la	$25,memset
	jal	$31,$25
	lw	$2,68($fp)
	lb	$2,0($2)
	sll	$3,$2,2
	lw	$2,68($fp)
	addu	$2,$2,1
	lbu	$2,0($2)
	andi	$2,$2,0x30
	sra	$2,$2,4
	or	$2,$3,$2
	sb	$2,24($fp)
	lw	$2,68($fp)
	addu	$2,$2,1
	lbu	$2,0($2)
	andi	$2,$2,0xf
	sll	$3,$2,4
	lw	$2,68($fp)
	addu	$2,$2,2
	lbu	$2,0($2)
	andi	$2,$2,0x3c
	sra	$2,$2,2
	or	$2,$3,$2
	sb	$2,25($fp)
	lw	$2,68($fp)
	addu	$2,$2,2
	lbu	$2,0($2)
	andi	$2,$2,0x3
	sll	$3,$2,6
	lw	$2,68($fp)
	addu	$2,$2,3
	lbu	$2,0($2)
	or	$2,$3,$2
	sb	$2,26($fp)
	li	$3,3			# 0x3
	lw	$2,72($fp)
	subu	$2,$3,$2
	sw	$2,32($fp)
	lw	$2,64($fp)
	bne	$2,$0,$L33
	lw	$4,60($fp)
	addu	$5,$fp,24
	lw	$6,32($fp)
	la	$25,write
	jal	$31,$25
	sw	$2,36($fp)
	lw	$3,36($fp)
	li	$2,-1			# 0xffffffffffffffff
	bne	$3,$2,$L33
	la	$25,__errno
	jal	$31,$25
	lw	$2,0($2)
	sw	$2,64($fp)
$L33:
	lw	$2,64($fp)
	move	$sp,$fp
	lw	$31,48($sp)
	lw	$fp,44($sp)
	addu	$sp,$sp,56
	j	$31
	.end	decode_to_output_file
	.size	decode_to_output_file, .-decode_to_output_file
	.align	2
	.globl	decode
	.ent	decode
decode:
	.frame	$fp,80,$31		# vars= 32, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 24
	sw	$31,72($sp)
	sw	$fp,68($sp)
	sw	$28,64($sp)
	move	$fp,$sp
	sw	$4,80($fp)
	sw	$5,84($fp)
	sw	$6,88($fp)
	sw	$7,92($fp)
	lw	$2,96($fp)
	sb	$2,32($fp)
	addu	$2,$fp,40
	move	$4,$2
	move	$5,$0
	li	$6,5			# 0x5
	la	$25,memset
	jal	$31,$25
	sw	$0,48($fp)
	sw	$0,52($fp)
$L36:
	lw	$2,52($fp)
	lw	$3,100($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L39
	b	$L37
$L39:
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$3,0($2)
	lb	$2,32($fp)
	bne	$3,$2,$L40
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	addu	$3,$fp,40
	lw	$2,52($fp)
	addu	$2,$3,$2
	sb	$0,0($2)
	b	$L38
$L40:
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$3,0($2)
	lw	$2,_ctype_
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	andi	$2,$2,0x1
	beq	$2,$0,$L41
	addu	$3,$fp,40
	lw	$2,52($fp)
	addu	$4,$3,$2
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	addu	$2,$2,-65
	sb	$2,0($4)
	b	$L38
$L41:
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$3,0($2)
	lw	$2,_ctype_
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	srl	$2,$2,1
	andi	$2,$2,0x1
	beq	$2,$0,$L42
	addu	$3,$fp,40
	lw	$2,52($fp)
	addu	$4,$3,$2
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	addu	$2,$2,-71
	sb	$2,0($4)
	b	$L38
$L42:
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$3,0($2)
	lw	$2,_ctype_
	addu	$2,$3,$2
	addu	$2,$2,1
	lbu	$2,0($2)
	srl	$2,$2,2
	andi	$2,$2,0x1
	beq	$2,$0,$L43
	addu	$3,$fp,40
	lw	$2,52($fp)
	addu	$4,$3,$2
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$2,$3,$2
	lbu	$2,0($2)
	addu	$2,$2,4
	sb	$2,0($4)
	b	$L38
$L43:
	lw	$3,92($fp)
	lw	$2,52($fp)
	addu	$4,$3,$2
	addu	$3,$fp,40
	lw	$2,52($fp)
	addu	$2,$3,$2
	move	$5,$2
	la	$25,issymbol
	jal	$31,$25
	bne	$2,$0,$L38
	li	$2,1			# 0x1
	sw	$2,56($fp)
	b	$L35
$L38:
	lw	$2,52($fp)
	addu	$2,$2,1
	sw	$2,52($fp)
	b	$L36
$L37:
	addu	$2,$fp,40
	lw	$3,48($fp)
	sw	$3,16($sp)
	lw	$4,80($fp)
	lw	$5,84($fp)
	lw	$6,88($fp)
	move	$7,$2
	la	$25,decode_to_output_file
	jal	$31,$25
	sw	$2,56($fp)
$L35:
	lw	$2,56($fp)
	move	$sp,$fp
	lw	$31,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$31
	.end	decode
	.size	decode, .-decode
	.align	2
	.globl	decode_text
	.ent	decode_text
decode_text:
	.frame	$fp,72,$31		# vars= 24, regs= 3/0, args= 24, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,72
	.cprestore 24
	sw	$31,64($sp)
	sw	$fp,60($sp)
	sw	$28,56($sp)
	move	$fp,$sp
	sw	$4,72($fp)
	sw	$5,76($fp)
	sw	$0,32($fp)
	la	$25,get_fill_char
	jal	$31,$25
	sb	$2,36($fp)
	addu	$2,$fp,40
	move	$4,$2
	move	$5,$0
	li	$6,5			# 0x5
	la	$25,memset
	jal	$31,$25
	addu	$2,$fp,40
	lw	$4,72($fp)
	move	$5,$2
	li	$6,4			# 0x4
	la	$25,read
	jal	$31,$25
	sw	$2,48($fp)
$L46:
	lw	$2,32($fp)
	bne	$2,$0,$L47
	lw	$3,48($fp)
	li	$2,4			# 0x4
	beq	$3,$2,$L48
	b	$L47
$L48:
	addu	$3,$fp,40
	lb	$2,36($fp)
	sw	$2,16($sp)
	li	$2,4			# 0x4
	sw	$2,20($sp)
	lw	$4,72($fp)
	lw	$5,76($fp)
	lw	$6,32($fp)
	move	$7,$3
	la	$25,decode
	jal	$31,$25
	sw	$2,32($fp)
	addu	$2,$fp,40
	move	$4,$2
	move	$5,$0
	li	$6,4			# 0x4
	la	$25,memset
	jal	$31,$25
	addu	$2,$fp,40
	lw	$4,72($fp)
	move	$5,$2
	li	$6,4			# 0x4
	la	$25,read
	jal	$31,$25
	sw	$2,48($fp)
	b	$L46
$L47:
	lw	$2,32($fp)
	bne	$2,$0,$L50
	lw	$2,48($fp)
	blez	$2,$L50
	addu	$3,$fp,40
	lb	$2,36($fp)
	sw	$2,16($sp)
	lw	$2,48($fp)
	sw	$2,20($sp)
	lw	$4,72($fp)
	lw	$5,76($fp)
	lw	$6,32($fp)
	move	$7,$3
	la	$25,decode
	jal	$31,$25
	sw	$2,52($fp)
	b	$L45
$L50:
	lw	$2,32($fp)
	sw	$2,52($fp)
$L45:
	lw	$2,52($fp)
	move	$sp,$fp
	lw	$31,64($sp)
	lw	$fp,60($sp)
	addu	$sp,$sp,72
	j	$31
	.end	decode_text
	.size	decode_text, .-decode_text
	.align	2
	.globl	base64_encode
	.ent	base64_encode
base64_encode:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	lw	$4,40($fp)
	lw	$5,44($fp)
	la	$25,encode_text
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	base64_encode
	.size	base64_encode, .-base64_encode
	.align	2
	.globl	base64_decode
	.ent	base64_decode
base64_decode:
	.frame	$fp,40,$31		# vars= 0, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,40
	.cprestore 16
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	lw	$4,40($fp)
	lw	$5,44($fp)
	la	$25,decode_text
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	base64_decode
	.size	base64_decode, .-base64_decode
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
