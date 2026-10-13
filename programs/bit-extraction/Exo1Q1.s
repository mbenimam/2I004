.data
	.byte 0x2f
.text
	ori $6, $0, 0 # bit
	lui $3, 0x1001
	ori $3, $3, 0x0000
	
	lw $5, 0($3)# int nb = n
	addi $7, $0, 0 # int i
	boucle:
		subi $8, $7, 8 
		bgez $8, fin_de_boucle
		andi $6, $5, 0x1
		srl $5, $5, 1
		#affichage entier bit
		addi $4, $6, 0
		ori $2, $0, 1
		syscall
		# affichage charactere  espace
		addi $4, $0, 0x20
		ori $2, $0, 11
		syscall
		
		addi $7, $7, 1 # incrementation de i
		j boucle	
	fin_de_boucle:
	
	ori $2, $0, 10
	syscall

	