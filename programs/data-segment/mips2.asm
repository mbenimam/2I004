.data
 v1:.word -1
 v2:.word 0xFF	
.text
 lui $4, 0x1001
 ori $4, $4, 0x0000
 
 lw $5, 0($4)
 lw $6, 4($4)
 
 addi $5, $5, 2
 addi $6, $6, 2
 
 sw $5, 0($4)
 sw $6, 4($4)
 
 add $4, $5, $0
 ori $2, $0, 1
 syscall
 
 add $4, $6, $0
 ori $2, $0, 1
 syscall
 
 ori $2, $0, 10
 syscall