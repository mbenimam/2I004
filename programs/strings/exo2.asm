.data
n: .word 2
p: .word 4

.text
lui $3,0x1001
ori $3,$3,0x0000
lw $3,0($3)

lui $5,0x1001
ori $5,$5,0x0004
lw $5,0($5)

ori $6,$0,6

addiu $29,$29,-12
sw $3,0($29)
sw $5,4($29)
sw $6,8($29)

jal moyenne
addiu $29,$29,12

or $4,$0,$2
ori $2,$0,1
syscall


ori $2,$0,10
syscall



moyenne:
prologue:
addiu $29,$29,-16
sw $10,0($29)
sw $11,4($29)
sw $12,8($29)
sw $31,12($29)

lw $10,16($29)
lw $11,20($29)
lw $12,24($29)




corps:
add $10,$10,$11
add $10,$12,$10

sra $2,$10,3


epilogue:
lw $10,0($29)
lw $11,4($29)
lw $12,8($29)
lw $31,12($29)

addiu $28,$29,16
jr $31