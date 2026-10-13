.data
	ch: .asciiz "coucou"
.text
	lui $4, 0x1001
	lb $7, 0($4)
	lb $8, 1($4)
	sb $7, 1($4)
	sb $8, 0($4)

	ori $2, $0, 4
	syscall
	ori $2, $0, 10
	syscall
