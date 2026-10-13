.data
ch: .asciiz "chaine1"
ch2: .asciiz "chaine2"

.text
	lui $4,0x1001
	ori $4,$4,0x0000

	addiu $29,$29,-4
	sw $4,0($29)

	jal f
	addiu $29,$29,4

	ori $2,$0,4
	syscall

	ori $2,$0,10
	syscall






	min_to_maj:
	prologue:
	addiu $29,$29,-24
	sw $1, 0($29)
	sw $5,4($29)
	sw $6, 8($29)
	sw $7,12($29)
	sw $11,16($29)
	sw $31,20($29)

	lw $5, 24($29)


	corps:
	ori $6,$0,0x61		#$6=a
	ori $7,$0,0x7A		#$7=z
	ori $1,$0,1
	if:
	slt $11,$6,$5		#if a<c $6=1	
	beq $11,$1,else
	slt $11, $5,$7
	beq $11,$0,else

	addi $5,$5,-0x20
	or $2,$0,$5
	j fin

	else:
	or $2,$0,$5

	fin:

	Epilogue:

	lw $1, 0($29)
	lw $5,4($29)
	lw $6, 8($29)
	lw $7,12($29)
	lw $11,16($29)
	lw $31,20($29)

	addiu $29,$29,24
	jr $31


	f:
		Prologue:
		addiu $29,$29,-12
		sw $10,0($29)
		sw $11,4($29)
		sw $31, 8($29)

		lw $10,12($29)


	corps2:

		while:
			lbu $11,0($10)
			beq $11,$0,finb
			addiu $29,$29,-4
			sw $11,0($29)
			jal min_to_maj
			sb $2,0($10)
			addiu $29,$29,4


			addi $10,$10,1

			j while

		finb:

	Epilogue2:


	lw $10,0($29)
	lw $11,4($29)
	lw $31, 8($29)
	addiu $29,$29,12
	jr $31
