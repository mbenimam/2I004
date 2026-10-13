.data
 v1: .byte 0xFF
.text
 lui $4, 0x1001
 ori $4, $4, 0x0000
 
 lb $7, 0($4)
 lbu $8, 0($4)
 
add $4, $7, $0
ori $2, $0, 1
syscall

add $4, $8, $0
ori $2, $0, 1
syscall

ori $2, $0, 10
syscall