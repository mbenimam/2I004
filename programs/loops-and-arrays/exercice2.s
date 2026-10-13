.text
	ori $5,$0,123 #a=$5
	ori $6,$0,245 #b=$6
	debut : beq $5,$6,fin_while #si a=b fin de boucle
	slt $7,$6,$5 #si a>b $7=0
	beq $7,$0,else #si $7 = 0 else
	sub $5,$5,$6 #a=a-b
	j debut
	else : sub $6,$6,$5#b=b-a
	j debut
	fin_while : ori $2,$0,1 #affichage de a 
	ori $4,$5,0
	syscall
	ori $2,$0, 10 #fin programme
	syscall
