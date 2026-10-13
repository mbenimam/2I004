.data
	tab : .word 28,1,14,7,5,4,19,-1 
	V : .word 5

.text
	ori $5,$0,0#compteur
	lui $6,0x1001#Adresse
	lw $9,32($6) #recuper la valeur V
	debut : lw $7,0($6)#valeur de tab
	slti $8,$7,0#si valeur de tab<0 $8=1 donc fin boucle
	bne $8,$0,fin_while #si $8 !=0 fin boucle
	slt $8,$7,$9 #si tab<V
	addi $6,$6,4 #incremente l'adresse pour passer a la valeur suivante
	beq $8,$0,else #si $8=0 saut a else
	addi $5,$5,1 #incremente le compteur de 1
	j debut
	else : j debut
	fin_while :  ori $2,$0,1 #affichage du compteur
	ori $4,$5,0
	syscall
	ori $2,$0, 10 #fin programme
	syscall

