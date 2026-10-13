.data
	n:.byte 0x71
	espace:.byte 0x00,0x00,0x00
	tab:.byte 0,0,0,0,0,0,0,0
	
.text
	ori $6, $0, 0 # bit
	lui $3, 0x1001
	ori $3, $3, 0x0000
	
	lb $5, 0($3)# int nb = n
	addi $7, $0, 0 # int i
	ori $3, $3, 0x0001 #tab
	addi $1, $3, 7 #tab

	ori $2, $0, 1
	syscall
	boucle:
		
		subi $8, $7, 8 
		bgez $8, fin_de_boucle # si i >= 8
		andi $6, $5, 0x1 # bit = nb & 0x1
		srl $5, $5, 1 #shift right
		
		sb $6, 0($1) #s cahrgement dansla memoire
		subi $1, $1, 1 
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
	
	addi $7, $0, 0
	
	boucle_tab:
		subi $8, $7, 8 
		bgez $8, fin_de_boucle # si i >= 8
		andi $6, $5, 0x1 # bit = nb & 0x1
		srl $5, $5, 1 #shift right	
	fin_boucle_tab:
	ori $2, $0, 10
	syscall

	