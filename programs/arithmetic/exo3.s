.text
	addi $9, $0, 84
	addi $10, $0, 10
	div $9, $10
	mflo $11
	mfhi $12

	mult $10, $11
	mflo $13
	add $13, $13, $12

	addi $2, $0, 1
	add $4, $0, $13

	syscall

	ori $2,$0,10
	syscall
