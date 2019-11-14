.data
	prompt: .asciiz "Please enter the last 3 digits of your registration number.... "
	message: .asciiz "It has been divided by 3 and the answer is.... "
	userInput: .space 3

.text
	main:

	#displays "Enter registration number:"
	li $v0 4
	la $a0 prompt
	syscall
	

	#Reads the  int and stores in $s0
	li $v0 5
	syscall
	move $s0 $v0

	#Divides user input $s0 and divides the user input by 3 then stores it in $t0
	div $t0, $s0, 3
	
	li $v0, 4
	la $a0, message
	syscall


	#Print value of $t0
	li $v0 1
	move $a0 $t0
	syscall

li $v0 10
syscall