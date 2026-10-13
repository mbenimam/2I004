.data 
	n :  	.word 5
	espace :  .ascii " "    #code ascii 0x20
	etoile :     .ascii "*"      # code ascii  : 0x2A
	image :    .space 60     #  5x12 = 60
	fin_char:   .byte 0           # code ascii   0x00

.text 

	ori $5,$0,0      #    $5 => i
	ori $6,$0,0      #    $6 => j

	lui $8, 0x1001
	ori $8, $8, 0x0000 #    $8 => 0x 1001 0000
	lw $10, 0($8)   #    $10 => n

	add $9, $10,$10  
	addi $9, $9, 2    # $9 => 2*n+2 

	ori $7, $8, 6     #    $7 => @image[0][0]

	ori $4, $7, 0     #     $4 = >adresse  i 

	for_i:

		slt $11, $5, $10       # i < n
		beq $11,$0, fin_for_i

		ori $6,$0,0              # j = 0 
		sub $14,$10,$5      # $14 => n- i

		for1 :

			slt $12, $6, $14      # j <  n - i
			beq $12, $0, fin1

			mult $9, $5      # $15 => i * Nb_colonne
			mflo $15
		
			ori $16, $15, 0        # $16 => i * Nb_colonne
		
			sub $17, $9, $6       # $17 =>     2n+2 - j 
			addi $17, $17, -2     # $17 =>     2n - j 
		
			add $15, $15, $6    #   $15 = >       i * Nb_colonne+ j
			add $15, $15, $7    #   $15 =>        i * Nb_colonnes + j + adresse de image [0][0]
		
			add $16, $16, $17  #   $16 = i * Nb_colonne + 2n - j 
			add $16,$16, $7     #   $16 = i *Nb_colonne + 2n - j + adresse de image [0][0]
		
			lb $18, 4($8)           # $18 = code ascii de space
			sb $18, 0($15)
			sb $18, 0($16)
		
			addi $6,$6, 1       # j=j+1
			j for1

		fin1 :

		ori $6, $14, 0    # j = n- i
		add $13, $10,$5
		addi $13, $13, 1     #  $13 = n + i + 1
	
		for2 : 
			slt $19, $6, $13
			beq $19,$0, fin2
	
			mult $9, $5      #   $15 =        i * nb_colonnes
			mflo $15
			add $15, $15, $6    #   $15 =        i * nb_colonnes + j	
			add $15, $15, $7    #   $15 =        i * nb_colonnes + j + adresse de image [0][0]	
	
			lb $18, 5($8)	       #$18 = code ASCII de etoile
			sb $18, 0($15)

			addi $6,$6, 1       # j++
		
			j for2
	
		fin2 :
	
		mult $9, $5      #   $15 =        i * nb_colonnes
		mflo $15
		add $15, $15, $9    #   $15 =        i * nb_colonnes + 2n+2	
		add $15, $15, $7    #   $15 =        i * nb_colonnes + 2n+2 + adresse de image [0][0]	
		ori $20, $0, 0x0a
		sb $20, -1($15)
		addi $5,$5,1
	
	j for_i

	fin_for_i:


	ori $4,$7, 0
	ori $2,$0,4
	syscall

ori $2,$0,10
syscall 
