.data 

str:    
    .space 9 #8 bits for 8 characters and 1 bit for end 
str1:
    asciiz "Invalid number" 
    
.text 

li $v0, 8 #v0 code 8 means OS expects to input a string from user
la $a0, str #address of str in memory store in register  $a0 
li $a1, 9 #OS knows 9 bits string is about to get inputted 
syscall #Call to the system 
#By this point, user input string is stored in memory, and that address is in register $a0

j slabel #jumps to slabel right away
label: 
    addi $a0, 1  
slabel: 
    lb $t0, 0($a0) #loads a byte from 0($a0) to register $t0
    beq $t0, 8($a0) right_label #if $t0 has address of 8th byte, go to right_label, or move down
    
beq $t0, valid, label #checks if that byte has a valid number. if yes, goes to label to check another byte

li $v0, 4  #if that corresponding byte in memory is invalid, $v0 has call code4 for printing out str1 

la $a0, str1 #address of str1 is put into $a0
syscall #takes argument from $a0
li $v0, 10 #call code for exit
exit  #program exits

right_label:
    convert to decimal #converting is done here
    li $v0, 1 #call code for printing out an integer
    li $a0, answer #register $a0 has value to be printed 
    syscall #prints out argument $a0
    li $v0, 10 #call code for exit
    exit  #program exits
