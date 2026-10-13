.data
	.byte 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x00
.text
	lui $4, 0x1001
	ori $2, $0, 4
	syscall
	lb $5, 3($4)
	addi $6, $5, -0x30


	ori $2, $0, 1
	or $4, $0, $6
	syscall
	ori $2, $0, 10
	syscall
