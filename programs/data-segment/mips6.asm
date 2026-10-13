.data
	tab: .word 4, 23, 12, 3, 8, 1
.text
	lui $3, 0x1001
	lw $5, 12($3)
	lw $6, 16($3)
	addi $7, $5, 1
	sw $7, 0($3)
	add $8, $5, $6
	sw $8, 4($3)
	lw $9, 20($3)
	sw $9, 8($3)

	ori $2, $0, 10
	syscall
