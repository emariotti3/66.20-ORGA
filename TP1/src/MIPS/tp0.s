	.file	1 "tp0.c"
	.section .mdebug.abi32
	.previous
	.abicalls
	.rdata
	.align	2
$LC0:
	.ascii	"r+\000"
	.align	2
$LC1:
	.ascii	"%s\000"
	.text
	.align	2
	.globl	print_file
	.ent	print_file
print_file:
	.frame	$fp,152,$31		# vars= 112, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,152
	.cprestore 16
	sw	$31,144($sp)
	sw	$fp,140($sp)
	sw	$28,136($sp)
	move	$fp,$sp
	sw	$4,152($fp)
	lw	$4,152($fp)
	la	$5,$LC0
	la	$25,fopen
	jal	$31,$25
	sw	$2,128($fp)
$L18:
	lw	$2,128($fp)
	lhu	$2,12($2)
	srl	$2,$2,5
	andi	$2,$2,0x1
	beq	$2,$0,$L20
	b	$L19
$L20:
	addu	$4,$fp,24
	move	$5,$0
	li	$6,101			# 0x65
	la	$25,memset
	jal	$31,$25
	addu	$4,$fp,24
	li	$5,1			# 0x1
	li	$6,100			# 0x64
	lw	$7,128($fp)
	la	$25,fread
	jal	$31,$25
	la	$4,$LC1
	addu	$5,$fp,24
	la	$25,printf
	jal	$31,$25
	b	$L18
$L19:
	lw	$4,128($fp)
	la	$25,fclose
	jal	$31,$25
	move	$2,$0
	move	$sp,$fp
	lw	$31,144($sp)
	lw	$fp,140($sp)
	addu	$sp,$sp,152
	j	$31
	.end	print_file
	.size	print_file, .-print_file
	.align	2
	.globl	free_mem
	.ent	free_mem
free_mem:
	.frame	$fp,48,$31		# vars= 8, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,48
	.cprestore 16
	sw	$31,40($sp)
	sw	$fp,36($sp)
	sw	$28,32($sp)
	move	$fp,$sp
	sw	$4,48($fp)
	sw	$5,52($fp)
	sb	$0,24($fp)
	lw	$4,48($fp)
	la	$25,fclose
	jal	$31,$25
	move	$3,$2
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L22
	lw	$4,52($fp)
	la	$25,fclose
	jal	$31,$25
	move	$3,$2
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L22
	li	$2,1			# 0x1
	sb	$2,24($fp)
$L22:
	lbu	$2,24($fp)
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	addu	$sp,$sp,48
	j	$31
	.end	free_mem
	.size	free_mem, .-free_mem
	.rdata
	.align	2
$LC2:
	.ascii	"Usage: \n"
	.ascii	" \t\ttp0 -h \n"
	.ascii	" \t\ttp0 -V \n"
	.ascii	" \t\ttp0 [options] \n"
	.ascii	" \t\tOptions: \n"
	.ascii	" \t\t-V, --version Print version and quit.\n"
	.ascii	" \t\t-h, --help Print this information.\n"
	.ascii	" \t\t-i, --input Location of the input file.\n"
	.ascii	" \t\t-o, --output Location of the output file.\n"
	.ascii	" \t\t-a, --action Program action: encode (default) or de"
	.ascii	"code.\n"
	.ascii	" \t\tExamples:\n"
	.ascii	" \t\ttp0 -a encode -i ~/input -o ~/output\n"
	.ascii	" \t\ttp0 -a decode \n\000"
	.text
	.align	2
	.globl	show_help
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
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,$LC2
	la	$25,printf
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	show_help
	.size	show_help, .-show_help
	.rdata
	.align	2
$LC3:
	.ascii	"Organizacion de Computadoras - TP0 \n"
	.ascii	" \t\t\tEncoder/Decoder Base64 - v2.0 \n"
	.ascii	" \t\t\tGroup Members:\n"
	.ascii	" \t\t\tGonzalez Perez, Ailen Padron: 97043\n"
	.ascii	" \t\t\tMariotti, Maria Eugenia Padron: 96260\n"
	.ascii	" \t\t\tRa\303\261a, Cristian Ezequiel Padron: 95457\n\000"
	.text
	.align	2
	.globl	show_version
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
	sw	$31,32($sp)
	sw	$fp,28($sp)
	sw	$28,24($sp)
	move	$fp,$sp
	la	$4,$LC3
	la	$25,printf
	jal	$31,$25
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	addu	$sp,$sp,40
	j	$31
	.end	show_version
	.size	show_version, .-show_version
	.rdata
	.align	2
$LC4:
	.ascii	"-v\000"
	.align	2
$LC5:
	.ascii	"--version\000"
	.align	2
$LC6:
	.ascii	"-h\000"
	.align	2
$LC7:
	.ascii	"--help\000"
	.align	2
$LC8:
	.ascii	"-o\000"
	.align	2
$LC9:
	.ascii	"--output\000"
	.align	2
$LC10:
	.ascii	"-\000"
	.align	2
$LC11:
	.ascii	"-i\000"
	.align	2
$LC12:
	.ascii	"--input\000"
	.align	2
$LC13:
	.ascii	"-a\000"
	.align	2
$LC14:
	.ascii	"--action\000"
	.align	2
$LC15:
	.ascii	"decode\000"
	.align	2
$LC16:
	.ascii	"Falla en apertura de archivos. Intente nuevamente. \n\000"
	.text
	.align	2
	.globl	main
	.ent	main
main:
	.frame	$fp,80,$31		# vars= 40, regs= 3/0, args= 16, extra= 8
	.mask	0xd0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	reorder
	subu	$sp,$sp,80
	.cprestore 16
	sw	$31,72($sp)
	sw	$fp,68($sp)
	sw	$28,64($sp)
	move	$fp,$sp
	sw	$4,80($fp)
	sw	$5,84($fp)
	la	$25,saludar
	jal	$31,$25
	sb	$0,28($fp)
	sb	$0,27($fp)
	sb	$0,26($fp)
	sb	$0,25($fp)
	sb	$0,24($fp)
	sw	$0,36($fp)
	sw	$0,32($fp)
	sw	$0,40($fp)
	li	$2,1			# 0x1
	sw	$2,44($fp)
	sw	$0,48($fp)
$L26:
	lw	$2,48($fp)
	lw	$3,80($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L29
	b	$L27
$L29:
	lw	$2,48($fp)
	sll	$3,$2,2
	lw	$2,84($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,52($fp)
	lw	$4,52($fp)
	la	$5,$LC4
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L31
	lw	$4,52($fp)
	la	$5,$LC5
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L30
$L31:
	li	$2,1			# 0x1
	sb	$2,25($fp)
$L30:
	lw	$4,52($fp)
	la	$5,$LC6
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L33
	lw	$4,52($fp)
	la	$5,$LC7
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L32
$L33:
	li	$2,1			# 0x1
	sb	$2,24($fp)
$L32:
	lw	$4,52($fp)
	la	$5,$LC8
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L35
	lw	$4,52($fp)
	la	$5,$LC9
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L34
$L35:
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	sll	$3,$2,2
	lw	$2,84($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,36($fp)
	lw	$4,36($fp)
	la	$5,$LC10
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L34
	li	$2,1			# 0x1
	sb	$2,26($fp)
$L34:
	lw	$4,52($fp)
	la	$5,$LC11
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L38
	lw	$4,52($fp)
	la	$5,$LC12
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L37
$L38:
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	sll	$3,$2,2
	lw	$2,84($fp)
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,32($fp)
	lw	$4,32($fp)
	la	$5,$LC10
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L37
	li	$2,1			# 0x1
	sb	$2,27($fp)
$L37:
	lw	$4,52($fp)
	la	$5,$LC13
	la	$25,strcmp
	jal	$31,$25
	beq	$2,$0,$L41
	lw	$4,52($fp)
	la	$5,$LC14
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L28
$L41:
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	sll	$3,$2,2
	lw	$2,84($fp)
	addu	$2,$3,$2
	lw	$4,0($2)
	la	$5,$LC15
	la	$25,strcmp
	jal	$31,$25
	bne	$2,$0,$L28
	li	$2,1			# 0x1
	sb	$2,28($fp)
$L28:
	lw	$2,48($fp)
	addu	$2,$2,1
	sw	$2,48($fp)
	b	$L26
$L27:
	sw	$0,52($fp)
	lbu	$2,24($fp)
	beq	$2,$0,$L43
	la	$25,show_help
	jal	$31,$25
	lw	$2,52($fp)
	sw	$2,56($fp)
	b	$L25
$L43:
	lbu	$2,25($fp)
	beq	$2,$0,$L44
	la	$25,show_version
	jal	$31,$25
	lw	$2,52($fp)
	sw	$2,56($fp)
	b	$L25
$L44:
	lbu	$2,27($fp)
	beq	$2,$0,$L45
	lw	$4,32($fp)
	move	$5,$0
	la	$25,open
	jal	$31,$25
	sw	$2,40($fp)
$L45:
	lbu	$2,26($fp)
	beq	$2,$0,$L46
	lw	$4,36($fp)
	li	$5,514			# 0x202
	li	$6,448			# 0x1c0
	la	$25,open
	jal	$31,$25
	sw	$2,44($fp)
$L46:
	lw	$3,44($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L48
	lw	$3,40($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L48
	b	$L47
$L48:
	la	$4,$LC16
	la	$25,printf
	jal	$31,$25
	la	$25,__errno
	jal	$31,$25
	lw	$2,0($2)
	sw	$2,56($fp)
	b	$L25
$L47:
	lbu	$2,28($fp)
	beq	$2,$0,$L49
	lw	$4,40($fp)
	lw	$5,44($fp)
	la	$25,base64_decode
	jal	$31,$25
	sw	$2,52($fp)
	b	$L50
$L49:
	lw	$4,40($fp)
	lw	$5,44($fp)
	la	$25,base64_encode
	jal	$31,$25
	sw	$2,52($fp)
$L50:
	lw	$4,40($fp)
	la	$25,close
	jal	$31,$25
	lw	$4,44($fp)
	la	$25,close
	jal	$31,$25
	lw	$2,52($fp)
	sw	$2,56($fp)
$L25:
	lw	$2,56($fp)
	move	$sp,$fp
	lw	$31,72($sp)
	lw	$fp,68($sp)
	addu	$sp,$sp,80
	j	$31
	.end	main
	.size	main, .-main
	.ident	"GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
