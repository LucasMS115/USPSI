.data
	myChar: .byte 'L'
	myMessage: .asciiz "\nHello World"
	age: .word 23
	pi: .float 3.14
	myDouble: .double 7.002
	zeroDouble: .double 0.0

.text
	#Print integer
	li $v0, 1
	lw, $a0, age
	syscall
	
	#Print float
	li $v0, 2
	lwc1, $f12, pi
	syscall
	
	#Print double
	ldc1, $f2, myDouble
	ldc1, $f0, zeroDouble
	li $v0, 3
	add.d, $f12, $f2, $f0
	syscall
	
	#Print char
	li $v0, 4
	la, $a0, myChar
	syscall
	
	#Print string
	li $v0, 4
	la, $a0, myMessage
	syscall