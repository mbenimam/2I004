.text
	ori $5,$0, 1 # i=$5
	ori $6,$0,0 # somme=$6
	debut : slti $8,$5,11 #comparer si i<11
	beq $8,$0,fin_for #si $8=0, i>=11 donc fin boucle for
	add $6,$6,$5 #somme = somme+i
	addi $5,$5,1 #i++
	j debut
	fin_for : ori $2,$0,1 #affichage de somme
	ori $4,$6,0
	syscall
	ori $2,$0, 10 #fin programme
	syscall
