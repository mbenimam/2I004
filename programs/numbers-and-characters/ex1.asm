.data
	.space 11
.text
	lui $3,0x1001
	ori $3,$3,0x0000
	addi $12,$0,0 
	ori $2,$0,5
	syscall
	add $14,$2,$0 #nb
	add $10,$2,$0 #q =nb
	addi $11,$0,10 # init de 10
	div $10,$11
	mflo $10
	addi $9,$0,1

	debut_boucle:
		beq $10,$12,fin_boucle
		div $10,$11
		mflo $10
		addi $9,$9,1 #cpt ++
		j debut_boucle
	fin_boucle:
		add $3, $3, $9
		sb $0,0($3)
		add $10,$0,$14
	

	div $10,$11
	mfhi $15
	mflo $10
	addi $9,$9,-1
	addi $3, $3, -1
	addi $13,$15,0x30
	sb $13,0($3)

	debut_boucle2.0:

		blez $9,fin_boucle2.0
		div $10,$11
		mfhi $15
		mflo $10
		addi $9,$9,-1
		addi $3, $3, -1
		addi $13,$15,0x30
 
		sb $13,0($3)
		j debut_boucle2.0

	fin_boucle2.0:

	add $4,$3,$0
	ori $2,$0,4
	syscall
