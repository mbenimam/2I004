.text
	addi $16, $0, 137

	ori $2, $0, 1

	andi $4, $4, 0
	ori $4, $16, 0

	syscall

	ori $2, $0, 10
	syscall
