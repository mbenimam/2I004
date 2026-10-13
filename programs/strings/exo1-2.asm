.data
ch: .asciiz "machainech"
ch2: .asciiz "deuxiemechaine"

.text
	lui $4,0x1001
	ori $4,$4,0x0000

	addiu $29,$29,4
	sw $4,0($29)

	jal f

	addiu $29,$29,4
	ori $2,$0,4
	syscall

	addi $4,$4,11
	addiu $29,$29,-4
	sw $4,0($29)
	jal f

	addiu $29,$29,4

	ori $2,$0,4
	syscall

	ori $2,$0,10
	syscall






	
	f:
		Prologue:
			addiu $29,$29,-12
			sw $3,0($29)
			sw $5,4($29)
			sw $31,8($29)
			lw $3,12($29)

		corp:


		while:
			lbu $5,0($3)
			beq $5,$0,finb
			addi $5,$5,-0x20
			sb  $5,0($3)
			addi $3,$3,1


			j while
		finb:
		epilogue:
			lw $3,0($29)
			lw $5,4($29)
			lw $31,8($29)
			addiu $29,$29,16
			jr $31











