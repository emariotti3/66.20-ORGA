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
		li a0,1
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
