# Given positive integers a and b, output a/b and a%b.
  .data
str1: .asciiz "Enter a: "
str2: .asciiz "Enter b: "

  .text

main: li   $v0, 4            # system call code for print_string
  la   $a0, str1         # address of str1
  syscall                # print str1

#get the first number from user, put it into $s0

li   $v0, 5            # system call code for read_int
  syscall                # read an integer into $v0 from console
  add  $s0, $v0, $zero   # copy $v0 into $s0 (a)


#read print_string for str2
li   $v0, 4            # system call code for print_string
  la   $a0, str2         # address of str1
  syscall                # print str1

# get second number from user, put it into $t1  
li  $v0, 5      #load syscall for read_int
syscall         #make the syscall
move $s1, $v0       #move the number read into $s1(b)

#DO THE CALCULATIONS................................................
div $s0, $s1        #diving $s0 by $s1
mflo    $t0         #storing value of lo(quotient) in
                #register $t0
mfhi    $t1         #storing value of hi(remainder) in
                #register $t1

mult $s0, $s1
mflo $t2


li $v0,1
move $a0, $t2
syscall





#end of program
li  $v0, 10     #system call code for exit
syscall