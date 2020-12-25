.data

	ending: .asciiz  "\nEnding"
	exitMsg: .asciiz "\nExiting the loop"
	space: .asciiz " "

.text

	main:
	
		addi $t0, $zero, 0 # i = 0
		
		while:
			bgt $t0,  5, exit
			
			jal showI
			addi $t0, $t0, 1
			
			j while
		
		exit:
			li $v0, 4
			la $a0, exitMsg
			syscall
		
		li $v0, 4
		la $a0, ending
		syscall
		
	
	#End program
	li $v0, 10
	syscall
	
	showI:
		li $v0, 1
		add $a0, $t0, $zero
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		jr $ra
	