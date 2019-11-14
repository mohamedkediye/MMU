.data #this declares the vairables for the program

	enterString : .asciiz "hello, please enter your name(less than 15 characters):   "
	outputString : .asciiz "hello,"		 # this string will be shown when the program outputs the string
	regestrationString : .asciiz "please enter the last 4 digits of your studnet regestration  "
	userInput : .space 15 			#the user has the ability to input a maximum of 15 characters
	
	prompt: .asciiz "please enter the last 4 digits of your student id..."
	message: .asciiz "your student id No. is..."
	userInput2 : .space 4
	
	
.text
	main:
	#
	la $a0, enterString
	li $v0, 4
	syscall
	#this asks the user to input their name
	li $v0, 8
	la $a0, userInput
	li $a1, 15
	syscall
	#This outputs the users input onto the screen
	la $a0, outputString
	li $v0, 4
	syscall
	
	li $v0, 4
	la $a0, userInput
	syscall
	
	#
	li $v0, 4
	la $a0, prompt
	syscall
	
	#
	li $v0, 5
	la $a0, userInput2
	syscall
	
	#
	move $t0, $v0
	#
	li $v0, 4
	la $a0, message
	syscall
	
	#
	li $v0, 1
	move, $a0, $t0
	syscall

	#
	li $v0, 10
	syscall
