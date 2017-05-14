#include <mips/regdef.h>
#include <sys/syscall.h>

.text
.abicalls
.ent saludar
.globl saludar

saludar: .frame $fp,8,ra
		.set noreorder
		.cpload t9
		.set reorder
		
		subu sp,sp,8
		sw $fp,0(sp)
		.cprestore 4
		
		lw a0,hola 
		li v0,SYS_write
		syscall
	
		move v0,t0
		lw $fp,0(sp)
		lw gp,4(sp)
		addu sp,sp,8
		jr ra
		
.end saludar

.data
hola: .asciiz "Hola"
