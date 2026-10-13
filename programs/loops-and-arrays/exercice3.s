.data
	ch : .asciiz "coucou"

.text
	lui $8,0x1001 #Adresse
	ori $6,$0, 0 #compteur
	debut : lb $5,0($8) #recupere le caractere a l'adresse indiqué
	beq $5,$0,fin_while
	addi $8,$8,1 #incremete l'adresse de 1
	addi $6,$6,1#incremente le compteur de 1
	j debut
	fin_while : ori $2,$0,1 #affichage du compteur
	ori $4,$6,0
	syscall
	ori $2,$0, 10 #fin programme
	syscall
