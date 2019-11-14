.data
	prompt : .asciiz "hello, please enter the lasr 3 digits of your registration number...   "
	message : .asciiz "your number is divided by 3, and the answer is..." # this string will be shown when the program outputs the string
	userInput : .space 4 			#the user has the ability to input a maximum of 15 characters



.text
	
	
	la $a0, prompt
	li $v0, 4
	syscall
	
	li $v0, 8
	la $a0, userInput
	li $a1, 4
	syscall
	
	move $t0, $v0
	
	la $a0, message
	addi $t0, $zero, 15
	addi $t1, $zero, 3
	li $v0, 4
	syscall
	
	div $s0, $t0, $t1
	
	#print
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	
li $v0, 10 #system call code for exit 
syscall