.data
N: .word 5
A: 	.word 1 1 1 1 1 
	.word 2 2 2 2 2
	.word 3 5 3 3 3
	.word 4 4 4 18 4
	.word 5 5 5 5 5

B: 	.word 1 1 1 1 1 
	.word 2 2 2 2 2
	.word 3 3 3 3 3
	.word 4 4 4 4 4
	.word 5 5 5 5 5
c: 	.space 25 

.text
	lui $20 0x1001	
	lw $21 0($20)	
	addi $22 $20 4 	 # $22 A
	mult $21 $21
	mflo $23 # n*n	
	ori $24 $0 4
	mult $23 $24	
	mflo $25 # nb octets	
	add $26 $22 $25 # B
	add $27 $26 $25 # C
	ori $5 $0 0 # i
	for1:
		beq $5 $21 endfor1
		ori $6 $0 0 
		for2:
			beq $6 $21 endfor2
			lw $7 0($22)
			lw $8 0($26)
			add $9 $7 $8
			sw $9 0($27)
			jal printValue
			jal printEspace	
			addi $6 $6 1
			addi $22 $22 4
			addi $26 $26 4
			addi $27 $27 4
			j for2
		endfor2:
		jal printBackSlashN
		addi $5 $5 1
		j for1
	endfor1:
	ori $2 $0 10
	syscall

	printBackSlashN:
		ori $2 $0 11
		ori $4 $0 '\n'
		syscall
		jr $31
	printEspace:
		ori $2 $0 11
		ori $4 $0 ' '
		syscall
		jr $31
	printValue:
		ori $2 $0 1
		lw $4 0($27)
		syscall
		jr $31
