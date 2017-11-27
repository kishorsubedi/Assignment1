.data 					
	user_input: .space 9		#9 bytes of space in memory allocated for user_input
	invalid_input:	.asciiz "\n Invalid hexadecimal number \n"
	newline: .asciiz "\n"  		# Newline character stored in memory under label newline 
	user_prompt: .asciiz "Enter a hexadecimal number:\n" 
	
.text					#Instructions

main:
	li $v0, 4			#call code for printing out string
	la $t0, user_prompt		#address of user_prompt stored in $t0
	la $a0, ($t0) 			#Argument register $a0 now has $t0's address
	syscall 			#User_prompt is printed 
	
	addi, $s3, $0, 0		#Initializing register $s3 
	li $v0, 8			#call code to read string from user 
	la $t0, user_input		#load address of user_input in register $t0
	la $a0, ($t0)			#load address of user_input in $t0 to argument register $a0
	la $a1, 9			#OS knows the max byte the user_input is going to be 
	syscall				#OS now reads user_input and store the string in memory address whose address is in register $t0

	addi $t7, $t0, 8		#Go nine bytes from $t0, to hold the last byte of the string in memory
	addi $s5, $t0, 0

length_check:				#the length of the string in memory is checked in this label
	lb $t1, 0($s5)			#1st byte of string is loaoded in $t1 
	beq $t1, 0, sub_four		#if $t1 has value 0 branch to sub-four label
	beq $t1, 10, sub_four
	addi $s3, $s3, 4
	addi $s5, $s5, 1 
	j length_check
sub_four:				#if value in first offset refers to new line or null, label to branch 
	addi $s3, $s3, -4
	
iterate_string:				#iterate through user_input to check if all the charectars are valid	
	
	lb $t1, 0($t0)			#load first byte of memory into register $t1

	beq $t1, 0, less_than_eight	#if the value at offset 0 < 8 or <10, branch to less_than 8
	beq $t1, 10, less_than_eight
	blt $t1, 48, invalid		#branch to if_invalid label if value in $t1 is less than 48 (ASCII dec for number 0)		
	addi $s1, $0, 48		# store the ASCII dec to be subtracted in $s1
	blt $t1, 58, valid		#branch to if_invalid label if value in $t1 is less than 58 (next ASCII dec for number 9)		
	blt $t1, 65, invalid		# 65 = ASCII dec for 'A'
	addi $s1, $0, 55
	blt $t1, 71, valid		# if $t1 ascii value is less than 97, branch to invalid label
	blt $t1, 97, invalid		#if $t1 is holding a character with ascii value less than 97 , branch to invalid label
	addi $s1, $0, 87
	blt $t1, 103, valid	
	bgt $t1, 102, invalid		#branch to if_invalid if value in $t1 is greater than 102 (ASCII dec for 'f')
	
invalid:				#label to call invalid_input and exit program
	li $v0, 4			#call code to prompt invalid_input string
	la $a0, invalid_input
	syscall
	li $v0, 10			#call code to exit program
	syscall
valid:					#label to call valid_input and exit program
	addi $t0, $t0, 1		#increment offset of $t0 by 1
	sub $s4, $t1, $s1		#subtract appropriate ASCII dec value to get dec value of hex input
	sllv $s4, $s4, $s3		# multiply $s3 by 4
	addi $s3, $s3, -4
	add $s2, $s4, $s2		# add and store the value of $s4 and $s2 to $s2
	bne $t0, $t7, iterate_string	# branch to iterate_string if offset of $t0 not equal to $t7

less_than_eight:			#if the value at offset 0 < 8 branch to this label
	addi $s0, $0, 10		#10 is stored in $s0
	addi $t0, $t0, -1		#subtract 1 from user_input register $t0
	lb $t1, 0($t0)
	blt $t1, 56, exit_loop		#if 0($t0) < 8, branch to exit_loop
	divu $s2, $s0			# otherwise divide by 10 and store in $s2
	
	li $v0, 4 
	la $a0, newline 
	syscall 
	
	mflo $a0			# move lower bits from register LO to $a0 and print
	li $v0, 1			#call code to print integer 
	syscall
	mfhi $s2			#move higher bits of register HI to $s2
	
exit_loop:
	li $v0, 1			#callcode to print integer
	addi $a0, $s2, 0
	syscall
	li $v0, 10			#call code to exit program
	syscall

