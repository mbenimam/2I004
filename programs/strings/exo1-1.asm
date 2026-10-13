.data
	ch: .asciiz "machainech"

.text
	lui $4,0x1001
	ori $4,$4,0x0000

	ori $2,$0,4
	syscall 
	or $3,$4,$0
	
	while:
		lbu $5,0($3)
		beq $5,$0,finb
		addi $5,$5,-0x20
		sb  $5,0($3)
		addi $3,$3,1

	j while

	finb:

	ori $2,$0,4
	syscall 

	ori $2,$0,10
	syscall





