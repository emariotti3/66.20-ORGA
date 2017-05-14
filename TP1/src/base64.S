#include <mips/regdef.h>
#include <sys/syscall.h>

.data
str:  .asciiz "the answer = "

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
		
        li v0, 4        # system call code for print_str
        la a0, str      # address of string to print
        syscall          # print the string

        li v0, 1        # system call code for print_int
        li a0, 5        # integer to print
        syscall          # print it
        
		li v0,8
		lw $fp,0(sp)
		lw gp,4(sp)
		lw ra,8(sp)
		addu sp,sp,16
		jr ra
		
.end saludar

