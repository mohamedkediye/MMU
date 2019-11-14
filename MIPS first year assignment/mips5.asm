# division.asm 
.data 
intI: .asciiz "please enter the last 3 digits of " 
intJ: .asciiz "\nEnter j: " 
str1: .asciiz "\nThe quotient of " 
str2: .asciiz "and "
 str3: .asciiz "is " 
str4: .asciiz " and the remainder is " 
str5: .asciiz "." 
.text 
main: 
li $v0, 4 # system call code for print_string
la $a0, intI # address of intI 
syscall # print intI 

#get the first number from user, put it into $s0 
li $v0, 5 # system call code for read_int 
syscall # read an integer into $v0 from console 
add $s0, $v0, $zero # copy $v0 into $s0 

#read print_string for intJ 
li $v0, 4 # system call code for print_string
la $a0, intJ # address of intJ 
syscall # print str1
 # get second number from user, put it into $t1 
li $v0, 5 #load syscall for read_int 
syscall #make the syscall 
move $s1, $v0 #move the number read into $s1 
div $s0, $s1 #diving $s0 by $s1 
mflo $t0 #storing value of lo(quotient) in 
#register $t0 

mfhi $t1 #storing value of hi(remainder) in 

#register $t1 
mult $s0, $s1
mflo $t2
li $v0, 1 #load syscall print_int into $v0
move $a0, $t0 #move the number to print into $t2 
syscall 

# read print string for remainder 
li $v0, 4 
la $a0, str1 
syscall



li $v0, 4
la $a0, str2
syscall

li $v0, 4
la $a0, str3 
syscall

# print quotient
li $v0, 1
move $a0, $t0
syscall 

li $v0, 4
la $a0, str4
syscall 

# print remainder 
li $v0, 1
move $a0, $t1
syscall 

li $v0, 4 
la $a0, str5 
syscall 

#end of program 
li $v0, 10 #system call code for exit 
syscall
